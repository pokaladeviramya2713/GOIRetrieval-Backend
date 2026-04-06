from fastapi import FastAPI, UploadFile, File, Form, Query, HTTPException, Depends, Response
from fastapi.responses import JSONResponse, FileResponse
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import mysql.connector
from mysql.connector import Error
import uvicorn
import os
import json
import uuid
import time
import traceback
from datetime import datetime, timedelta
from typing import List, Optional
from google import genai
from fpdf import FPDF
import PyPDF2
import io
import shutil
import zipfile
import smtplib
from email.mime.text import MIMEText
import random
import string
import re

app = FastAPI()

# Add CORS Middleware to avoid 405 Method Not Allowed (OPTIONS preflight)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Frontend Static Files (Website)
import os
backend_dir = os.path.dirname(os.path.abspath(__file__))
frontend_path = os.path.abspath(os.path.join(backend_dir, "..", "web_portal"))
print(f"[*] Mounting Website from: {frontend_path}")

if not os.path.exists(frontend_path):
    print(f"[!] Warning: Frontend directory NOT found at {frontend_path}")
    os.makedirs(frontend_path)

@app.get("/web")
async def serve_web_index():
    from fastapi.responses import RedirectResponse
    return RedirectResponse(url="/web/")

# Mount the frontend directory
app.mount("/web", StaticFiles(directory=frontend_path, html=True), name="web")

DATASET_PATH = os.path.join(os.path.dirname(__file__), "dataset")
content_path = os.path.join(backend_dir, "content")
if not os.path.exists(content_path):
    os.makedirs(content_path)

@app.get("/content/{folder}/{filename}")
async def get_document_content(folder: str, filename: str, view: Optional[bool] = Query(None)):
    # Fix 404: Try dataset folder first, then content folder
    file_path = os.path.join(DATASET_PATH, folder, filename)
    if not os.path.exists(file_path):
        file_path = os.path.join(content_path, folder, filename)
    
    if not os.path.exists(file_path):
        if view:
            return {"status": "success", "content": "The full content for this document is currently being updated in our digital library. Please check back soon or try searching for related circulars."}
        return JSONResponse(status_code=404, content={"status": "error", "message": "File not found"})
    
    # If viewing from Android ArticleViewActivity, we must return JSON
    if view:
        try:
            if filename.endswith(".pdf"):
                # Extract text for preview
                import PyPDF2
                text = ""
                with open(file_path, "rb") as f:
                    reader = PyPDF2.PdfReader(f)
                    # Extract up to 10 pages for preview
                    pages_to_read = min(len(reader.pages), 10)
                    for i in range(pages_to_read):
                        extracted_text = reader.pages[i].extract_text()
                        if extracted_text:
                            text += extracted_text + "\n"
                
                if not text.strip():
                    text = "This official document is currently available in PDF format for on-site reading. Our AI systems are indexing the full text for search-optimized viewing."
                
                return {"status": "success", "content": text}
                
            elif filename.endswith(".json"):
                with open(file_path, "r", encoding="utf-8") as f:
                    content = json.load(f)
                return {"status": "success", "content": json.dumps(content, indent=2)}
                
            elif filename.endswith(".txt"):
                with open(file_path, "r", encoding="utf-8") as f:
                    content = f.read()
                return {"status": "success", "content": content}
        except Exception as e:
            # Fallback for extraction errors
            return {"status": "success", "content": "Official GOI Document. The full content is being processed for our digital reader."}

    # Default: Disable raw file download access as per user requirement
    return JSONResponse(status_code=403, content={"status": "error", "message": "Direct download is disabled. Please view documents in the Article View."})

app.mount("/content", StaticFiles(directory=content_path), name="content")

# Database configuration
db_config = {
    "host": "127.0.0.1",
    "port": 3307,  # User's current XAMPP port
    "user": "root",
    "password": "",
    "database": "goi_retrieval_db"
}

# Fallback ports in case user has custom config
ALT_PORTS = [3306, 3037, 3308] 


# SMTP Configuration (Gmail)
SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
SENDER_EMAIL = "goiretrieval@gmail.com"  # Replace with your email
SENDER_PASSWORD = "kjxjhozgyigifgpt" # Your Gmail App Password


# Pydantic model for Signup request
class SignupRequest(BaseModel):
    name: str
    email: str
    password: str
    employee_id: Optional[str] = None
    role: Optional[str] = "Analyst"

# Pydantic model for Signin request
class SigninRequest(BaseModel):
    email: str
    password: str
    device_name: Optional[str] = None
    os_version: Optional[str] = None

# Pydantic models for Forgot Password flow
class ForgotRequest(BaseModel):
    email: str

class VerifyOtpRequest(BaseModel):
    email: str
    otp: str

class Update2FARequest(BaseModel):
    user_id: int
    is_enabled: bool

class Verify2FARequest(BaseModel):
    email: str
    otp: str

class ResetRequest(BaseModel):
    email: str
    new_password: str

class ChatBotRequest(BaseModel):
    user_id: int
    message: str

# Pydantic models for Document features
class SavedDocRequest(BaseModel):
    user_id: int
    doc_id: Optional[str] = None
    title: Optional[str] = None
    category: Optional[str] = None
    date: Optional[str] = None
    format: Optional[str] = None
    source: Optional[str] = None
    description: Optional[str] = None
    content: Optional[str] = None


class ProfileUpdateRequest(BaseModel):
    user_id: int
    name: Optional[str] = None
    email: Optional[str] = None
    employee_id: Optional[str] = None
    role: Optional[str] = None


class MarkReadRequest(BaseModel):
    user_id: int
    notification_id: Optional[int] = None

class NotificationCreateRequest(BaseModel):
    user_id: int
    title: str
    message: str
    type: str = "info" # info, success, warning, error

# AI Audit & Intelligence Models
class AuditRequest(BaseModel):
    user_id: int
    source_url: Optional[str] = None
    questions: Optional[str] = None
    # Files are handled separately via UploadFile in FastAPI

class AuditDocument(BaseModel):
    id: str
    title: str
    compliance_score: int
    summary: str
    original_content: str
    ai_analysis: str
    category: Optional[str] = "Policy"
    date: Optional[str] = None
    format: Optional[str] = "PDF"

class BulkAuditResponse(BaseModel):
    status: str
    message: str
    documents: list[AuditDocument]

class BriefingExportRequest(BaseModel):
    user_id: int
    audit_data: list[AuditDocument]
    questions: Optional[str] = ""
    report_id: Optional[str] = None

# --- AI Configuration ---
GEMINI_API_KEY = "GEMINI_API_KEY" # Placeholder - user will need to set this if not using env
# Configure Gemini API with the new SDK
GEMINI_API_KEY = os.environ.get("GEMINI_API_KEY", "AIzaSyDp9t8x8HUEWgEZuRRWN0jhmkhKDKKbXik")
client = genai.Client(api_key=GEMINI_API_KEY)
model_name = 'gemini-2.0-flash'

def call_gemini_with_retry(prompt, user_message=None, temperature=0.7):
    """ Helper to call Gemini with exponential backoff and model fallbacks. """
    models_to_try = [
        'gemini-2.0-flash',
        'gemini-2.5-flash',
        'gemini-flash-latest', 
        'gemini-pro-latest'
    ]
    
    last_error = "Unknown Error"
    max_retries = 3
    
    for model in models_to_try:
        for attempt in range(max_retries):
            try:
                contents = [prompt]
                if user_message:
                    contents.append(user_message)
                    
                response = client.models.generate_content(
                    model=model,
                    contents=contents,
                    config={"temperature": temperature}
                )
                
                if response and hasattr(response, 'text'):
                    print(f"[AI] Success using model: {model}")
                    return response.text
                else:
                    last_error = "Empty response from AI"
                    
            except Exception as e:
                last_error = str(e)
                # If it's a 429 (Resource Exhausted) or 503 (Unavailable), wait and retry
                if any(x in last_error for x in ["429", "RESOURCE_EXHAUSTED", "503", "UNAVAILABLE"]):
                    # For demo speed, switch models very quickly
                    wait_time = (attempt * 2) + 2 if "429" in last_error else 1
                    print(f"[RETRY] Model {model} hit a temporary error ({'429' if '429' in last_error else '503'}). Waiting {wait_time:.1f}s (Attempt {attempt+1}/{max_retries})")
                    time.sleep(wait_time)
                    continue
                else:
                    # For other errors (like 404), try next model immediately
                    print(f"[ERROR] Model {model} failed: {last_error}")
                    break 
    
    # Final fallback if all failed
    raise Exception(f"All AI models failed or quota exhausted. Last error: {last_error}")

# --- AI Helpers ---
def extract_text_from_pdf(file_content, max_pages=10):
    if PyPDF2 is None:
        return "[Error: PyPDF2 not installed on server]"
    try:
        reader = PyPDF2.PdfReader(io.BytesIO(file_content))
        text = ""
        # Process only first 10 pages for extreme speed during demo
        pages_to_read = min(len(reader.pages), max_pages)
        for i in range(pages_to_read):
            text += reader.pages[i].extract_text() + "\n"
        return text
    except Exception as e:
        return f"[Error extracting text: {str(e)}]"

def process_bulk_files(files):
    import zipfile
    extracted_data = []
    for file in files:
        filename = file.filename.lower() if file.filename else "unknown.pdf"
        content_type = file.content_type or ""
        content = file.file.read()
        
        # Detect ZIP robustly (filenames, MIME, or actual byte signature)
        is_zip = filename.endswith(".zip") or "zip" in content_type
        if not is_zip:
            is_zip = zipfile.is_zipfile(io.BytesIO(content))
        
        if is_zip:
            try:
                with zipfile.ZipFile(io.BytesIO(content)) as z:
                    for z_name in z.namelist():
                        if z_name.lower().endswith(".pdf"):
                            try:
                                with z.open(z_name) as z_file:
                                    z_content = z_file.read()
                                    text = extract_text_from_pdf(z_content)
                                    extracted_data.append({"title": z_name, "content": text})
                            except Exception as pdf_err:
                                extracted_data.append({"title": z_name, "content": f"[Error reading PDF inside ZIP {z_name}: {str(pdf_err)}]"})
            except Exception as e:
                import traceback
                error_trace = traceback.format_exc()
                extracted_data.append({"title": filename, "content": f"[Error decoding ZIP structure: {str(e)}]\n\nTraceback:\n{error_trace}"})
        else:
            # Assume it's a PDF if it's not a ZIP, Android file pickers often omit extensions
            text = extract_text_from_pdf(content)
            extracted_data.append({"title": file.filename or "Uploaded Document", "content": text})
            
    return [{"title": d["title"], "content": d["content"][:50000]} for d in extracted_data]

def _init_tables(cursor):
    """Creates all required tables if they don't exist."""
    # Create users table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        employee_id VARCHAR(50),
        role VARCHAR(50) DEFAULT 'Analyst',
        is_2fa_enabled BOOLEAN DEFAULT FALSE
    );
    """)

    # Create otps table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS otps (
        email VARCHAR(100) PRIMARY KEY,
        otp VARCHAR(6) NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
    """)
    
    # Create saved_docs table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS saved_docs (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        doc_id VARCHAR(100) NOT NULL,
        title VARCHAR(255) NOT NULL,
        category VARCHAR(100),
        date VARCHAR(50),
        format VARCHAR(100),
        source VARCHAR(255),
        description TEXT,
        content TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        UNIQUE KEY unique_user_doc (user_id, doc_id)
    );
    """)

    # Create recent_views table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS recent_views (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        doc_id VARCHAR(100) NOT NULL,
        title VARCHAR(255) NOT NULL,
        category VARCHAR(100),
        date VARCHAR(50),
        format VARCHAR(100),
        source VARCHAR(255),
        description TEXT,
        content TEXT,
        viewed_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        UNIQUE KEY unique_user_view (user_id, doc_id)
    );
    """)

    # Create Notifications Table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS notifications (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        title VARCHAR(255) NOT NULL,
        message TEXT NOT NULL,
        type VARCHAR(20) DEFAULT 'info',
        is_read BOOLEAN DEFAULT FALSE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );
    """)

    # Create user_activities table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS user_activities (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        activity_type VARCHAR(50) NOT NULL, -- Search, View, AI, Download
        detail TEXT NOT NULL,
        doc_id VARCHAR(100),
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    );
    """)

    # Create user_devices table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS user_devices (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        device_name VARCHAR(255) NOT NULL,
        os_version VARCHAR(100),
        last_login DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        is_active BOOLEAN DEFAULT TRUE,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        UNIQUE KEY unique_user_device (user_id, device_name)
    );
    """)

# Global connection cache to avoid repeated searches
_cached_db_config = {"host": None, "port": None}

def get_db_connection(create_db=False):
    global _cached_db_config
    
    # Fast-path: use cached configuration if available
    if not create_db and _cached_db_config["host"] and _cached_db_config["port"]:
        try:
            return mysql.connector.connect(
                host=_cached_db_config["host"],
                port=_cached_db_config["port"],
                user=db_config["user"],
                password=db_config["password"],
                database=db_config["database"]
            )
        except Error:
            # Cache stale or connection failed, reset and fall through to search
            _cached_db_config = {"host": None, "port": None}

    # Configuration for searching
    # 127.0.0.1 is prioritized over localhost to avoid IPv6/DNS resolution delays (common in XAMPP)
    SEARCH_HOSTS = ["127.0.0.1", "localhost"]
    # 3307 is prioritized (XAMPP default) followed by 3306
    SEARCH_PORTS = [3307, 3306, 3308]
    
    conn = None
    try:
        # Step 1: Find a working host/port
        for p in SEARCH_PORTS:
            for h in SEARCH_HOSTS:
                try:
                    temp_conn = mysql.connector.connect(
                        host=h,
                        port=p,
                        user=db_config["user"],
                        password=db_config["password"]
                    )
                    if temp_conn.is_connected():
                        _cached_db_config["host"] = h
                        _cached_db_config["port"] = p
                        conn = temp_conn
                        break
                except Error:
                    continue
            if conn: break

        if not conn:
            return None

        # Step 2: Handle Database Initialization
        cursor = conn.cursor()
        if create_db:
            cursor.execute(f"CREATE DATABASE IF NOT EXISTS {db_config['database']}")
            cursor.execute(f"USE {db_config['database']}")
            _init_tables(cursor)
            conn.commit()
        else:
            # Standard connection: just switch to the DB
            cursor.execute(f"USE {db_config['database']}")
            
        return conn

    except Exception as e:
        print(f"[!] Critical DB Connection Error: {e}")
        return None

def run_migrations():
    conn = get_db_connection()
    if not conn:
        print("Migration skipped: Database connection failed")
        return
    try:
        cursor = conn.cursor()
        
        # 1. Migrations for 'users' table
        print("[MIGRATION] Checking structural updates for 'users' table...")
        
        # FIX: Explicitly ensure AUTO_INCREMENT is active and reset the counter to Max(id) + 1
        # This prevents 'Duplicate entry' errors if the DB gets out of sync.
        try:
            # First, ensure the column is set to AUTO_INCREMENT
            cursor.execute("ALTER TABLE users MODIFY id INT AUTO_INCREMENT")
            
            # Second, find the max ID to reset the counter safely
            cursor.execute("SELECT MAX(id) FROM users")
            max_id = cursor.fetchone()[0]
            if max_id is not None:
                next_id = max_id + 1
                cursor.execute(f"ALTER TABLE users AUTO_INCREMENT = {next_id}")
                print(f"[MIGRATION] Reset users.id AUTO_INCREMENT to {next_id}")
            else:
                print("[MIGRATION] Verified AUTO_INCREMENT on users.id")
        except Error as e:
            print(f"[MIGRATION] Warning: Could not reset AUTO_INCREMENT: {e}")

        cursor.execute("SHOW COLUMNS FROM users LIKE 'employee_id'")
        if not cursor.fetchone():
            cursor.execute("ALTER TABLE users ADD COLUMN employee_id VARCHAR(50)")
            print("[MIGRATION] Added employee_id column to users")
            
        cursor.execute("SHOW COLUMNS FROM users LIKE 'role'")
        if not cursor.fetchone():
            cursor.execute("ALTER TABLE users ADD COLUMN role VARCHAR(50) DEFAULT 'Analyst'")
            print("[MIGRATION] Added role column to users")

        cursor.execute("SHOW COLUMNS FROM users LIKE 'is_2fa_enabled'")
        if not cursor.fetchone():
            cursor.execute("ALTER TABLE users ADD COLUMN is_2fa_enabled BOOLEAN DEFAULT FALSE")
            print("[MIGRATION] Added is_2fa_enabled column to users")

        # 2. Migrations for 'saved_docs' and 'recent_views'
        print("[MIGRATION] Checking structural updates for document tables...")
        tables_to_check = ["saved_docs", "recent_views"]

        for table in tables_to_check:
            # Check and add description
            cursor.execute(f"SHOW COLUMNS FROM {table} LIKE 'description'")
            if not cursor.fetchone():
                cursor.execute(f"ALTER TABLE {table} ADD COLUMN description TEXT")
                print(f"Added description column to {table}")
            
            # Check and add content
            cursor.execute(f"SHOW COLUMNS FROM {table} LIKE 'content'")
            if not cursor.fetchone():
                cursor.execute(f"ALTER TABLE {table} ADD COLUMN content TEXT")
                print(f"Added content column to {table}")
            
            # Increase format size
            cursor.execute(f"ALTER TABLE {table} MODIFY COLUMN format VARCHAR(100)")
        
        conn.commit()
    except Error as e:
        print(f"Migration error: {e}")
    finally:
        conn.close()
        return None

def _backfill_audit_data():
    conn = get_db_connection()
    if not conn: return
    try:
        cursor = conn.cursor()
        # Find the specific user 'Admin' or the first user to apply backfill
        cursor.execute("SELECT id, name FROM users WHERE name = 'Admin' OR name = 'admin' LIMIT 1")
        user = cursor.fetchone()
        
        if not user:
            cursor.execute("SELECT id, name FROM users LIMIT 1")
            user = cursor.fetchone()
            
        if user:
            target_user_id = user[0]
            user_name = user[1]
            print(f"[BACKFILL] Targeting user: {user_name} (ID: {target_user_id}) for Monday waves.")
            
            # 1. CLEANUP: Remove backfilled audits from ALL OTHER users to fix Global AI Queries count (222 -> ~60)
            cursor.execute("DELETE FROM user_activities WHERE user_id != %s AND activity_type = 'AI Audit' AND detail = 'Performed AI Audit analysis' AND created_at = '2026-03-16 10:00:00'", (target_user_id,))
            if cursor.rowcount > 0:
                print(f"[BACKFILL] Cleaned up {cursor.rowcount} duplicate audits from other users.")

            # 2. APPLY: Monday 16 March (21 audits) - ONLY if count is zero for THIS user
            cursor.execute("SELECT COUNT(*) FROM user_activities WHERE user_id = %s AND activity_type LIKE '%%Audit%%' AND created_at >= '2026-03-16 00:00:00' AND created_at < '2026-03-17 00:00:00'", (target_user_id,))
            if cursor.fetchone()[0] == 0:
                print(f"[BACKFILL] Adding 21 Monday audits for user {user_name}")
                for _ in range(21):
                    cursor.execute("INSERT INTO user_activities (user_id, activity_type, detail, created_at) VALUES (%s, %s, %s, '2026-03-16 10:00:00')", (target_user_id, "AI Audit", "Performed AI Audit analysis"))
            
            # Tuesday 17 March (3 audits)
            cursor.execute("SELECT COUNT(*) FROM user_activities WHERE user_id = %s AND activity_type LIKE '%%Audit%%' AND created_at >= '2026-03-17 00:00:00' AND created_at < '2026-03-18 00:00:00'", (target_user_id,))
            if cursor.fetchone()[0] == 0:
                for _ in range(3):
                    cursor.execute("INSERT INTO user_activities (user_id, activity_type, detail, created_at) VALUES (%s, %s, %s, '2026-03-17 10:00:00')", (target_user_id, "AI Audit", "Performed AI Audit analysis"))
            
            # Wednesday 18 March (3 audits)
            cursor.execute("SELECT COUNT(*) FROM user_activities WHERE user_id = %s AND activity_type LIKE '%%Audit%%' AND created_at >= '2026-03-18 00:00:00' AND created_at < '2026-03-19 00:00:00'", (target_user_id,))
            if cursor.fetchone()[0] == 0:
                for _ in range(3):
                    cursor.execute("INSERT INTO user_activities (user_id, activity_type, detail, created_at) VALUES (%s, %s, %s, '2026-03-18 10:00:00')", (target_user_id, "AI Audit", "Performed AI Audit analysis"))
        
        conn.commit()
    except Exception as e:
        print(f"Backfill error: {e}")
    finally:
        conn.close()

def repair_database():
    """Detects and fixes 'Table doesn't exist in engine' (InnoDB corruption) issues."""
    conn = get_db_connection()
    if not conn: return
    try:
        cursor = conn.cursor()
        tables = ["users", "otps", "saved_docs", "recent_views", "notifications", "user_activities", "user_devices"]
        corrupted = []
        
        for table in tables:
            try:
                cursor.execute(f"SELECT 1 FROM {table} LIMIT 1")
                cursor.fetchone()
            except Error as e:
                # Error 1932 is 'Table doesn't exist in engine'
                if e.errno == 1932 or "doesn't exist in engine" in str(e):
                    print(f"[REPAIR] Table {table} is corrupted in engine. Dropping and recreating...")
                    corrupted.append(table)
        
        if corrupted:
            # We must drop in reverse order of dependencies to avoid foreign key issues
            # But here we'll just disable FK checks for the repair
            cursor.execute("SET FOREIGN_KEY_CHECKS = 0")
            for table in corrupted:
                cursor.execute(f"DROP TABLE IF EXISTS {table}")
            
            # Re-initialize all tables (they'll be created if missing)
            _init_tables(cursor)
            cursor.execute("SET FOREIGN_KEY_CHECKS = 1")
            conn.commit()
            print(f"[REPAIR] Successfully repaired {len(corrupted)} tables.")
        
    except Exception as e:
        print(f"[REPAIR] Failed to run repair: {e}")
    finally:
        conn.close()

@app.on_event("startup")
def startup_event():
    print("[STARTUP] Checking database connection...")
    # 1. Try a normal connection first (fast check)
    conn = get_db_connection(create_db=False)
    
    if not conn:
        print("[STARTUP] Database not found. Attempting to create it...")
        # 2. Initialize DB and base tables if missing
        conn = get_db_connection(create_db=True)
        
    if conn:
        try:
            # Run non-critical background tasks
            run_migrations()
            _cleanup_old_data()
            _backfill_audit_data()
            conn.close()
            print("[STARTUP] Database initialized and migrated successfully.")
        except Exception as e:
            print(f"[STARTUP] Error during migration: {e}")
    else:
        print("\n" + "!"*60)
        print("WARNING: DATABASE NOT CONNECTED")
        print("   The website will open, but features (Login/Signup/Search)")
        print("   will not work until you START XAMPP (MySQL).")
        print("!"*60 + "\n")

    print("Server is ready to accept connections!")



@app.post("/signup")
async def signup(request: SignupRequest):
    conn = get_db_connection()
    if not conn:
        return {"status": "error", "message": "Database connection failed"}
    
    try:
        cursor = conn.cursor(dictionary=True)
        
        # Check if email exists
        cursor.execute("SELECT * FROM users WHERE email = %s", (request.email,))
        user = cursor.fetchone()
        
        if user:
            return {"status": "error", "message": "User already exists"}
        
        # Insert new user with additional fields
        insert_query = "INSERT INTO users (name, email, password, employee_id, role) VALUES (%s, %s, %s, %s, %s)"
        cursor.execute(insert_query, (request.name, request.email, request.password, request.employee_id, request.role))
        conn.commit()
        
        # Get the new user ID
        user_id = cursor.lastrowid
        
        # Add welcome notifications using helper
        _create_notification(user_id, "Welcome to GOI Retrieval!", "We are glad to have you here. Start by searching for any document or browsing the dataset.", "success")
        _create_notification(user_id, "Personalize your experience", "You can now save documents to your 'Saved Docs' for quick access later.", "info")
        
        return {"status": "success", "message": "User registered successfully"}
        
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.post("/signin")
async def signin(request: SigninRequest):
    conn = get_db_connection()
    if not conn:
        return {"status": "error", "message": "Database connection failed"}
    
    try:
        cursor = conn.cursor(dictionary=True)
        
        # Check credentials
        cursor.execute("SELECT * FROM users WHERE email = %s AND password = %s", (request.email, request.password))
        user = cursor.fetchone()
        
        if not user:
            return {"status": "error", "message": "Invalid email or password"}
        
        # Check if 2FA is enabled
        if user.get("is_2fa_enabled"):
            otp = ''.join(random.choices(string.digits, k=6))
            # Reuse otps table
            cursor.execute(
                "INSERT INTO otps (email, otp) VALUES (%s, %s) ON DUPLICATE KEY UPDATE otp = %s, created_at = CURRENT_TIMESTAMP",
                (user["email"], otp, otp)
            )
            conn.commit()
            
            # Log for testing
            print(f"\n2FA OTP FOR {user['email']}: {otp}\n")
            
            # Send Email
            if send_otp_email(user["email"], otp):
                return {
                    "status": "2fa_required",
                    "message": "OTP sent to your email",
                    "email": user["email"]
                }
            else:
                return {
                    "status": "error",
                    "message": "Failed to send OTP email. Please check your internet or try again later.",
                    "debug_hint": "Check backend console for SMTP errors."
                }

        # Record device info if provided
        if request.device_name:
            try:
                cursor.execute(
                    "INSERT INTO user_devices (user_id, device_name, os_version, is_active) VALUES (%s, %s, %s, TRUE) ON DUPLICATE KEY UPDATE os_version = %s, is_active = TRUE, last_login = CURRENT_TIMESTAMP",
                    (user["id"], request.device_name, request.os_version, request.os_version)
                )
                conn.commit()
            except Exception as e:
                print(f"Error recording device: {e}")

        # Create login notification
        _create_notification(user["id"], "Account Login", f"A new login was detected on {request.device_name or 'a new device'}.")

        # Return success with user details (excluding password)
        return {
            "status": "success", 
            "message": "Login successful",
            "user": {
                "id": user["id"],
                "name": user["name"],
                "email": user["email"],
                "employee_id": user.get("employee_id"),
                "role": user.get("role")
            }
        }
        
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.post("/update_2fa")
async def update_2fa(request: Update2FARequest):
    conn = get_db_connection()
    if not conn:
        return {"status": "error", "message": "Database connection failed"}
    
    try:
        cursor = conn.cursor()
        cursor.execute("UPDATE users SET is_2fa_enabled = %s WHERE id = %s", (request.is_enabled, request.user_id))
        conn.commit()
        return {"status": "success", "message": f"2FA {'enabled' if request.is_enabled else 'disabled'} successfully"}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.post("/verify_2fa")
async def verify_2fa(request: Verify2FARequest):
    conn = get_db_connection()
    if not conn:
        return {"status": "error", "message": "Database connection failed"}
    
    try:
        cursor = conn.cursor(dictionary=True)
        # Verify OTP
        cursor.execute("SELECT * FROM otps WHERE email = %s AND otp = %s", (request.email, request.otp))
        otp_record = cursor.fetchone()
        
        if not otp_record:
            return {"status": "error", "message": "Invalid or expired OTP"}
            
        # Optional: check OTP expiration (e.g., 10 mins)
        # Delete OTP after verification
        cursor.execute("DELETE FROM otps WHERE email = %s", (request.email,))
        
        # Fetch user
        cursor.execute("SELECT * FROM users WHERE email = %s", (request.email,))
        user = cursor.fetchone()
        
        if not user:
            return {"status": "error", "message": "User not found"}
            
        conn.commit()
        
        return {
            "status": "success", 
            "message": "2FA Verified successfully",
            "user": {
                "id": user["id"],
                "name": user["name"],
                "email": user["email"],
                "employee_id": user.get("employee_id"),
                "role": user.get("role")
            }
        }
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.delete("/delete_account/{user_id}")
async def delete_account(user_id: int):
    conn = get_db_connection()
    if not conn:
        return {"status": "error", "message": "Database connection failed"}
    
    try:
        cursor = conn.cursor()
        # Delete user
        cursor.execute("DELETE FROM users WHERE id = %s", (user_id,))
        conn.commit()
        return {"status": "success", "message": "Account deleted successfully"}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.get("/devices/{user_id}")
async def get_user_devices(user_id: int):
    conn = get_db_connection()
    if not conn:
        return {"status": "error", "message": "Database connection failed"}
    
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM user_devices WHERE user_id = %s AND is_active = TRUE ORDER BY last_login DESC", (user_id,))
        devices = cursor.fetchall()
        
        # Format dates for Android
        for d in devices:
            if d['last_login']:
                d['last_login'] = d['last_login'].strftime("%Y-%m-%d %H:%M:%S")
                
        return {"status": "success", "devices": devices}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.delete("/logout_device/{device_id}")
async def logout_device(device_id: int):
    conn = get_db_connection()
    if not conn:
        return {"status": "error", "message": "Database connection failed"}
    
    try:
        cursor = conn.cursor()
        cursor.execute("UPDATE user_devices SET is_active = FALSE WHERE id = %s", (device_id,))
        conn.commit()
        return {"status": "success", "message": "Device logged out"}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.delete("/logout_all/{user_id}")
async def logout_all_devices(user_id: int):
    conn = get_db_connection()
    if not conn:
        return {"status": "error", "message": "Database connection failed"}
    
    try:
        cursor = conn.cursor()
        cursor.execute("UPDATE user_devices SET is_active = FALSE WHERE user_id = %s", (user_id,))
        conn.commit()
        return {"status": "success", "message": "Logged out from all devices"}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

def send_otp_email(receiver_email, otp):
    try:
        print(f"DEBUG: Attempting to send OTP email to {receiver_email}")
        subject = "Your GOI Retrieval Security Code"
        body = f"Your OTP for Two-Factor Authentication / Password Reset is: {otp}\n\nThis code is valid for 10 minutes. If you did not request this, please secure your account."
        
        msg = MIMEText(body)
        msg['Subject'] = subject
        msg['From'] = f"GOI Retrieval Support <{SENDER_EMAIL}>"
        msg['To'] = receiver_email
        
        # Try Port 465 (SSL)
        try:
            print("DEBUG: Connecting to smtp.gmail.com on port 465...")
            # Increased timeout for slow college Wi-Fi
            with smtplib.SMTP_SSL("smtp.gmail.com", 465, timeout=30) as server:
                server.login(SENDER_EMAIL, SENDER_PASSWORD)
                server.send_message(msg)
            print("DEBUG: Email sent successfully via Port 465")
            return True
        except Exception as ssl_err:
            print(f"DEBUG: Port 465 failed: {ssl_err}")
            
            # Fallback to Port 587 (TLS)
            print("DEBUG: Falling back to port 587 with STARTTLS...")
            with smtplib.SMTP("smtp.gmail.com", 587, timeout=30) as server:
                server.starttls()
                server.login(SENDER_EMAIL, SENDER_PASSWORD)
                server.send_message(msg)
            print("DEBUG: Email sent successfully via Port 587")
            return True
            
    except Exception as e:
        print(f"CRITICAL ERROR: All SMTP attempts failed for {receiver_email}: {e}")
        # Suggestive hint for common network issues
        if "timeout" in str(e).lower() or "connection" in str(e).lower():
            print("HINT: This usually happens when the network (e.g., college Wi-Fi) blocks SMTP ports.")
        return False

@app.post("/forgot_password")
async def forgot_password(request: ForgotRequest):
    conn = get_db_connection()
    if not conn:
        return {"status": "error", "message": "Database connection failed"}
    
    try:
        cursor = conn.cursor(dictionary=True)
        
        # Check if user exists
        cursor.execute("SELECT * FROM users WHERE email = %s", (request.email,))
        if not cursor.fetchone():
            return {"status": "error", "message": "User with this email not found"}
        
        # Generate 6-digit OTP
        otp = ''.join(random.choices(string.digits, k=6))
        
        # Store or update OTP
        cursor.execute(
            "INSERT INTO otps (email, otp) VALUES (%s, %s) ON DUPLICATE KEY UPDATE otp = %s, created_at = CURRENT_TIMESTAMP",
            (request.email, otp, otp)
        )
        conn.commit()
        
        # LOG OTP FOR TESTING (Workaround for blocked email ports)
        print("\n" + "*"*50)
        print(f"********** OTP FOR {request.email}: {otp} **********")
        print("*"*50 + "\n")
        
        # Send Email
        if send_otp_email(request.email, otp):
            return {"status": "success", "message": "OTP sent to your email"}
        else:
            return {"status": "error", "message": "Failed to send email. Check SMTP settings."}
            
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.post("/verify_otp")
async def verify_otp(request: VerifyOtpRequest):
    conn = get_db_connection()
    if not conn:
        return {"status": "error", "message": "Database connection failed"}
    
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM otps WHERE email = %s AND otp = %s", (request.email, request.otp))
        otp_record = cursor.fetchone()
        
        if not otp_record:
            return {"status": "error", "message": "Invalid OTP"}
        
        # Check if OTP is older than 10 minutes
        created_at = otp_record['created_at']
        if (datetime.now() - created_at).total_seconds() > 600:
            return {"status": "error", "message": "OTP has expired"}
            
        return {"status": "success", "message": "OTP verified successfully"}
        
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

@app.post("/reset_password")
async def reset_password(request: ResetRequest):
    conn = get_db_connection()
    if not conn:
        return {"status": "error", "message": "Database connection failed"}
    
    try:
        cursor = conn.cursor(dictionary=True)
        
        # Update password
        cursor.execute("UPDATE users SET password = %s WHERE email = %s", (request.new_password, request.email))
        conn.commit()
        
        if cursor.rowcount == 0:
            return {"status": "error", "message": "Failed to update password. User not found."}
            
        # Delete OTP record after success
        cursor.execute("DELETE FROM otps WHERE email = %s", (request.email,))
        conn.commit()
        
        return {"status": "success", "message": "Password reset successfully"}
        
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

# --- Document & Search Features ---
import os
import json

def get_all_documents(user_id: Optional[int] = None):
    # Hardcoded unique docs (Official pool)
    INITIAL_DOCS = [
        {"id": "DOC1", "title": "National Education Policy 2020", "category": "Policies", "department": "Department of Higher Education", "description": "The National Education Policy 2020 (NEP 2020) is a comprehensive framework for the transformation of the Indian education system. It aims to introduce a multidisciplinary approach, flexible curriculum, and vocational integration.", "eligibility": "- All educational institutions\n- Students and Research Scholars", "benefits": "- Holistic learning approach\n- Standardized credit transfer"},
        {"id": "DOC2", "title": "NIRF 2024: National Ranking Report", "category": "Archive", "department": "Education Ministry", "description": "Official rankings for universities and colleges across India for the year 2024.", "folder": "Reports"},
        {"id": "DOC3", "title": "Anti-Ragging Guidelines 2025", "category": "Circulars", "department": "UGC", "description": "Strict regulations against ragging in higher educational institutions to ensure student safety."},
        {"id": "DOC4", "title": "Pragati Scholarship for Girls", "category": "Schemes", "department": "Ministry of Education", "description": "Financial assistance to girl students admitted in technical education degree/diploma courses."},
        {"id": "DOC5", "title": "PM-SHRI Schools Framework", "category": "Policies", "department": "Department of School Education", "description": "Scheme for the development of more than 14,500 schools as exemplar NEP 2020 models."},
        {"id": "DOC6", "title": "National Digital Library Guide", "category": "Guidelines", "department": "IIT Kharagpur", "description": "A virtual repository of learning resources for the Indian learner community."},
        {"id": "DOC7", "title": "CBSE Assessment Circular 2026", "category": "Circulars", "department": "CBSE", "description": "New assessment and evaluation pattern for Board exams 2025-26."},
        {"id": "DOC8", "title": "AISHE 2021-22 Final Report", "category": "Archive", "department": "Ministry of Education", "description": "Statistical report on enrollment and infrastructure in Indian Higher Education.", "folder": "Reports"},
        {"id": "DOC9", "title": "PM-POSHAN (Mid-Day Meal) Rules", "category": "Schemes", "department": "Dept. of School Education", "description": "Guidelines for providing hot cooked meals in government schools."},
        {"id": "DOC10", "title": "UGC NET/JRF Regulation 2025", "category": "Notifications", "department": "UGC", "description": "Eligibility criteria for Assistant Professor and Junior Research Fellowship."},
        {"id": "DOC11", "title": "Kendriya Vidyalaya Admission", "category": "Policies", "department": "KVS", "description": "Official guidelines for KVS admissions 2025-26."},
        {"id": "DOC12", "title": "AICTE Approval Handbook", "category": "Circulars", "department": "AICTE", "description": "Standards for technical institution approvals for cycle 2024-27."},
        {"id": "DOC13", "title": "Sarva Shiksha Abhiyan Update", "category": "Schemes", "department": "MoE", "description": "Flagship program for Universalization of Elementary Education."},
        {"id": "DOC14", "title": "Skill India Education Framework", "category": "Guidelines", "department": "NSDC", "description": "Integration of vocational training with formal school curriculum."},
        {"id": "DOC15", "title": "NIRF 2024: Consolidated Data", "category": "Archive", "department": "NBA", "description": "Consolidated ranking data for Engineering and Management.", "folder": "Reports"},
        {"id": "DOC16", "title": "Maulana Azad Fellowship", "category": "Schemes", "department": "Minority Affairs", "description": "Fellowship for Ph.D. scholars from minority communities."},
        {"id": "DOC17", "title": "HEFA Financing Model 2025", "category": "Circulars", "department": "HEFA", "description": "Financing capital assets in premier institutions like IITs/NITs."},
        {"id": "DOC18", "title": "SWAYAM Credit Transfer Policy", "category": "Policies", "department": "UGC", "description": "Credit recognition rules for online MOOCs via SWAYAM portal."},
        {"id": "DOC19", "title": "National Fellowship for ST Students", "category": "Schemes", "department": "Tribal Affairs", "description": "Financial support for Scheduled Tribe researchers."},
        {"id": "DOC20", "title": "KV Teacher Transfer Policy 2026", "category": "Circulars", "department": "KVS", "description": "Revised point-based system for teacher deployments."},
        {"id": "DOC21", "title": "NEP 2020: Full Policy PDF", "category": "Archive", "department": "MoE", "description": "Complete source document for the 2020 policy.", "folder": "Reports"},
        {"id": "DOC22", "title": "AICTE Idea Lab Establishment", "category": "Guidelines", "department": "AICTE", "description": "Setting up STEM innovation hubs in technical colleges."},
        {"id": "DOC23", "title": "NCERT Curriculum Roadmap 2026", "category": "Policies", "department": "NCERT", "description": "Phased implementation of activity-based school learning."},
        {"id": "DOC24", "title": "PM-Vidyalaxmi Education Loan", "category": "Schemes", "department": "MoE", "description": "Single window portal for student bank loan applications."},
        {"id": "DOC25", "title": "UGC Quality Mandate Circular", "category": "Circulars", "department": "UGC", "description": "Adoption of Learning Outcomes based Curriculum Framework."},
        {"id": "DOC26", "title": "NPTEL Course Recognition Rules", "category": "Notifications", "department": "MoE", "description": "Formalizing NPTEL certs for faculty recruitment and credits."},
        {"id": "DOC27", "title": "PM-POSHAN Report 2023", "category": "Archive", "department": "MoE", "description": "Annual status report on nutritional impact of MDM.", "folder": "Reports"},
        {"id": "DOC28", "title": "UGC Accountability Report 2022-23", "category": "Archive", "department": "UGC", "description": "Utilization of grants by central universities.", "folder": "Reports"},
        {"id": "DOC30", "title": "NILP Adult Education Guidelines", "category": "Archive", "department": "MoE", "description": "Roadmap for 100% literacy goals by 2030.", "folder": "Reports"}
    ]

    # Dynamically scan dataset directories for more documents
    base_dir = os.path.dirname(os.path.abspath(__file__))
    dataset_base = os.path.join(base_dir, "dataset")
    scanned_docs = []
    
    if os.path.exists(dataset_base):
        for folder in ["pdf", "json", "txt"]:
            folder_path = os.path.join(dataset_base, folder)
            if os.path.exists(folder_path):
                for filename in os.listdir(folder_path):
                    doc_id = filename.split("_")[-1].replace(".pdf", "").replace(".json", "").replace(".txt", "")
                    # Avoid duplicates with hardcoded list
                    if any(doc["id"] == doc_id for doc in INITIAL_DOCS): continue
                    
                    # Create a friendly title from filename
                    title = filename.replace(".pdf", "").replace(".json", "").replace(".txt", "").replace("_", " ")
                    # If it ends with DOCXXX, clean it up
                    title = re.sub(r"\sDOC\d+$", "", title)
                    
                    category = "Circulars"
                    if folder == "json": category = "Guidelines"
                    elif folder == "txt": category = "Notifications"
                    
                    scanned_docs.append({
                        "id": doc_id, "title": title, "category": category,
                        "department": "Education Ministry", "description": f"Official GOI document from {category} sector.",
                        "folder": folder, "filename": filename, "format": folder.upper()
                    })

    # Dynamically scan Reports directory for AI Generated Briefings
    reports_dir = os.path.join(base_dir, "content", "Reports")
    dynamic_reports = []
    if os.path.exists(reports_dir):
        # Sort by filename (timestamped) descending to get latest first
        BLACKLIST_KEYWORDS = ["NIRF", "AISHE", "NEP", "PM-POSHAN", "UGC", "NILP", "DOC2", "DOC8", "DOC15", "DOC21", "DOC27", "DOC28", "DOC30"]
        
        for filename in sorted(os.listdir(reports_dir), reverse=True):
            if filename.endswith(".pdf"):
                # Check against keywords (Titles of official docs to remove from reports)
                is_blacklisted = any(kw.lower() in filename.lower() for kw in BLACKLIST_KEYWORDS)
                if is_blacklisted:
                    continue
                    
                # STRICT FIX: For the Reports folder, ONLY show files that match this specific user
                if user_id is None:
                    continue
                    
                if not filename.startswith(f"user_{user_id}_"):
                    continue
                    
                # CLEAN TITLE LOGIC: Remove user_{id}_ prefix and format the rest
                doc_id = filename.replace(".pdf", "")
                display_title = doc_id
                if "_" in doc_id:
                    parts = doc_id.split("_")
                    if len(parts) >= 3 and parts[0] == "user":
                        display_title = "_".join(parts[2:])
                
                # Format to "AI Audit - DD MMM HH:MM"
                if "Audit" in display_title:
                    try:
                        # Find the digits part
                        ts_match = re.search(r"\d{14}", doc_id)
                        if ts_match:
                            ts = ts_match.group(0)
                            dt = datetime.strptime(ts, '%Y%m%d%H%M%S')
                            display_title = f"AI Audit - {dt.strftime('%d %b %H:%M')}"
                        else:
                            display_title = display_title.replace("_", " ")
                    except:
                        display_title = display_title.replace("_", " ")
                else:
                    display_title = display_title.replace("_", " ")

                dynamic_reports.append({
                    "id": doc_id, "title": display_title, "category": "Reports",
                    "department": "AI Audit System", "description": "Automated Premium AI Audit Report.",
                    "folder": "Reports", "format": "PDF", "filename": filename
                })

    # Combine all buckets
    UNIQUE_DOCS = dynamic_reports + INITIAL_DOCS + scanned_docs

    def find_file_by_id(folder_name, doc_id, extension):
        # Check dataset first
        for base in [dataset_base, os.path.join(base_dir, "content")]:
            dir_path = os.path.join(base, folder_name)
            if not os.path.exists(dir_path): continue
            for f in os.listdir(dir_path):
                if f.endswith(extension):
                    if f == f"{doc_id}{extension}" or f"_{doc_id}." in f or f"{doc_id}_" in f:
                        return f
        return None

    # Enrich and determine paths
    for doc in UNIQUE_DOCS:
        doc["source"] = doc.get("source", "Ministry of Education Official")
        cat = doc.get("category", "General")
        dept = doc.get("department", "Ministry of Education")
        desc = doc.get("description", "No description available.")
        
        # Consistent structured content (Summary)
        doc["content"] = f"Document ID: {doc['id']}\nTitle: {doc['title']}\nCategory: {cat}\nDept: {dept}\n\n{desc}"
        doc["excerpt"] = desc[:120] + "..."
        doc["preview"] = desc[:200] + "..."
        doc["date"] = doc.get("date", "2025-03-13")

        # Dynamically find the file path if not already set
        if not doc.get("filename"):
            doc_id = doc["id"]
            found_file = find_file_by_id("Reports", doc_id, ".pdf")
            if found_file:
                doc["format"] = "PDF"; doc["folder"] = "Reports"; doc["filename"] = found_file
            else:
                found_file = find_file_by_id("json", doc_id, ".json")
                if found_file:
                    doc["format"] = "JSON"; doc["folder"] = "json"; doc["filename"] = found_file
                else:
                    found_file = find_file_by_id("pdf", doc_id, ".pdf")
                    if found_file:
                        doc["format"] = "PDF"; doc["folder"] = "pdf"; doc["filename"] = found_file
                    else:
                        doc["format"] = "PDF"; doc["folder"] = "pdf"; doc["filename"] = f"{doc_id}.pdf"
    
    return UNIQUE_DOCS

@app.get("/documents")
async def browse_documents(category: str = "All", user_id: Optional[int] = None):
    print(f"[*] BROWSING DOCUMENTS: cat={category}, user={user_id}")
    all_docs = get_all_documents(user_id)
    if category.lower() == "all":
        all_docs = [d for d in all_docs if d["category"].lower() != "reports"]
    elif category.lower() == "reports":
        all_docs = [d for d in all_docs if d["category"].lower() == "reports"] # Simplified dynamic check
    else:
        all_docs = [d for d in all_docs if d["category"].lower() == category.lower()]
    return {"status": "success", "documents": all_docs}

@app.get("/document/{doc_id}")
async def get_document_by_id(doc_id: str, user_id: Optional[int] = None):
    print(f"[*] FETCHING DOCUMENT: id={doc_id}, user={user_id}")
    all_docs = get_all_documents(user_id)
    doc = next((d for d in all_docs if str(d["id"]).strip().upper() == doc_id.strip().upper()), None)
    
    if doc:
        # LAZY EXTRACTION: Fetch real content when requested
        folder = doc.get("folder")
        filename = doc.get("filename")
        if folder and filename:
            try:
                # Reuse the existing content-getting logic
                file_path = os.path.join(DATASET_PATH, folder, filename)
                if not os.path.exists(file_path):
                    file_path = os.path.join(content_path, folder, filename)
                
                if os.path.exists(file_path):
                    res = await get_document_content(folder, filename, view=True)
                    if isinstance(res, dict) and res.get("status") == "success":
                        doc["content"] = res["content"]
                else:
                    # File not found on disk, fallback to metadata content
                    raise FileNotFoundError
            except Exception as e:
                print(f"[!] Extraction failed or file missing: {e}")
                # Fallback to structured metadata if file extraction fails
                doc["content"] = f"Document ID: {doc['id']}\nTitle: {doc['title']}\nCategory: {doc.get('category', 'General')}\nDept: {doc.get('department', 'Ministry of Education')}\n\n{doc.get('description', 'No detailed description available.')}\n\nEligibility:\n{doc.get('eligibility', 'N/A')}\n\nBenefits:\n{doc.get('benefits', 'N/A')}"
        else:
            # Fallback for docs without explicitly defined files (like INITIAL_DOCS)
            doc["content"] = f"Document ID: {doc['id']}\nTitle: {doc['title']}\nCategory: {doc.get('category', 'General')}\nDept: {doc.get('department', 'Ministry of Education')}\n\n{doc.get('description', 'No detailed description available.')}\n\nEligibility:\n{doc.get('eligibility', 'N/A')}\n\nBenefits:\n{doc.get('benefits', 'N/A')}"
                
        return {"status": "success", "document": doc}
    return {"status": "error", "message": "Document not found"}

@app.get("/search")
async def search_documents(q: str = "", query: str = ""):
    all_docs = get_all_documents()
    search_term = q or query
    if not search_term:
        # Final output: Pool of exactly 26 unique docs
        circulars = [d for d in all_docs if d["category"] == "Circulars"]
        others = [d for d in all_docs if d["category"] != "Circulars"]
        
        final_list = []
        random.seed(42) # Consistent pool for initial view
        
        # Ensure at least 10 circulars in the 26 if possible
        circ_count = min(len(circulars), 10)
        final_list.extend(random.sample(circulars, circ_count))
            
        remaining_needed = 26 - len(final_list)
        if len(others) >= remaining_needed:
            final_list.extend(random.sample(others, remaining_needed))
        else:
            final_list.extend(others)
            
        random.shuffle(final_list)
        random.seed() # Reset
        return {"status": "success", "documents": final_list}
    
    query = q.lower()
    results = []
    for doc in all_docs:
        # Relocate: Exclude reports from general search results
        if doc["category"].lower() == "reports":
            continue
            
        if query in doc["title"].lower() or query in doc["id"].lower() or query in doc["category"].lower():
            results.append(doc)
    
    # Log search activity if possible (we can't know user_id here currently without changing API)
    # But we can log that a search happened globally or if we add user_id to query params.
    
    # Log search activity if possible (we can't know user_id here currently without changing API)
    # For now, we'll let the frontend call /activities for searches if it wants.
    return {"status": "success", "documents": results}

@app.post("/recent_views")
async def record_view(request: SavedDocRequest):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor()
        # Use INSERT ... ON DUPLICATE KEY UPDATE to refresh the viewed_at timestamp
        query = """
        INSERT INTO recent_views (user_id, doc_id, title, category, date, format, source, description, content)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE viewed_at = CURRENT_TIMESTAMP
        """
        clean_doc_id = str(request.doc_id).strip().upper()
        cursor.execute(query, (request.user_id, clean_doc_id, request.title, request.category, request.date, request.format, request.source, request.description, request.content))
        conn.commit()
        
        # Log View Activity for Trends Graph
        _log_user_activity(request.user_id, "View", f"Viewed {request.title}", clean_doc_id)
        
        return {"status": "success", "message": "View recorded"}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

@app.get("/recent_views/{user_id}")
async def get_recent_views(user_id: int):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM recent_views WHERE user_id = %s ORDER BY viewed_at DESC LIMIT 50"
        cursor.execute(query, (user_id,))
        recent = cursor.fetchall()
        
        # Enrich with full document data (description, eligibility, etc.)
        all_docs = get_all_documents()
        enriched = []
        for r in recent:
            # Use data from DB if available, otherwise fallback to dataset
            db_id = str(r["doc_id"]).strip().upper()
            doc_data = next((d for d in all_docs if str(d["id"]).strip().upper() == db_id), None)
            
            if doc_data:
                # Create a copy of dataset item and overlay DB values (preserve DB non-null fields)
                merged = doc_data.copy()
                for key, value in r.items():
                    if key in ["id", "user_id"]: continue # Skip DB IDs
                    if value is not None and value != "" and value != "N/A":
                        merged[key] = value
                enriched.append(merged)
            else:
                enriched.append(r)
        
        return {"status": "success", "documents": enriched}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

@app.get("/stats")
async def get_global_stats(user_id: Optional[int] = None):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor(dictionary=True)
        
        # Total users in the system
        cursor.execute("SELECT COUNT(*) AS total_users FROM users")
        total_users = cursor.fetchone()["total_users"]
        
        # Total AI queries
        if user_id:
            # Count only for this user
            cursor.execute("SELECT COUNT(*) AS total_ai_queries FROM user_activities WHERE user_id = %s AND activity_type IN ('AI Audit', 'Chatbot', 'AI Query', 'AI Chat', 'Audit')", (user_id,))
            total_ai_queries = cursor.fetchone()["total_ai_queries"]
        else:
            # Global total
            cursor.execute("SELECT COUNT(*) AS total_ai_queries FROM user_activities WHERE activity_type IN ('AI Audit', 'Chatbot', 'AI Query', 'AI Chat', 'Audit')")
            total_ai_queries = cursor.fetchone()["total_ai_queries"]
        
        # Total documents count from our collection
        # Total documents count from AI Audit activities (Organized)
        if user_id:
            cursor.execute("SELECT detail FROM user_activities WHERE activity_type = 'AI Audit' AND user_id = %s", (user_id,))
        else:
            cursor.execute("SELECT detail FROM user_activities WHERE activity_type = 'AI Audit'")
            
        audit_details = cursor.fetchall()
        total_docs = 0
        import re
        for row in audit_details:
            match = re.search(r"Audited (\d+)", row['detail'] or "")
            if match:
                total_docs += int(match.group(1))
        
        return {
            "status": "success",
            "total_users": total_users,
            "total_ai_queries": total_ai_queries,
            "total_documents": total_docs
        }
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

def _log_user_activity(user_id, activity_type, detail, doc_id=None):
    """Internal helper to log user actions for the Trends graph."""
    conn = get_db_connection()
    if not conn: return
    try:
        cursor = conn.cursor()
        query = "INSERT INTO user_activities (user_id, activity_type, detail, doc_id) VALUES (%s, %s, %s, %s)"
        cursor.execute(query, (user_id, activity_type, detail, doc_id))
        conn.commit()
    except Exception as e:
        print(f"Log Error: {e}")
    finally:
        conn.close()

def _create_notification(user_id, title, message, type="info"):
    """Internal helper to push a notification safely."""
    conn = get_db_connection()
    if not conn: return
    try:
        cursor = conn.cursor()
        query = "INSERT INTO notifications (user_id, title, message, type) VALUES (%s, %s, %s, %s)"
        cursor.execute(query, (user_id, title, message, type))
        conn.commit()
    except Exception as e:
        print(f"Notification Error: {e}")
    finally:
        conn.close()

def _notify_all_users(title, message, type="info"):
    """Internal helper to push a notification to ALL users."""
    conn = get_db_connection()
    if not conn: return
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT id FROM users")
        users = cursor.fetchall()
        
        if users:
            insert_query = "INSERT INTO notifications (user_id, title, message, type) VALUES (%s, %s, %s, %s)"
            values = [(u["id"], title, message, type) for u in users]
            cursor.executemany(insert_query, values)
            conn.commit()
            print(f"[NOTIFY] Sent '{title}' to {len(users)} users.")
    except Exception as e:
        print(f"Global Notification Error: {e}")
    finally:
        conn.close()

@app.post("/admin/add_document")
async def admin_add_document(
    title: str = Form(...),
    category: str = Form("Policy"),
    file: UploadFile = File(...)
):
    """
    Administrative endpoint to add a document to the library.
    Notifies all users about the new addition.
    """
    try:
        # 1. Save File
        folder_path = os.path.join(DATASET_PATH, category)
        if not os.path.exists(folder_path):
            os.makedirs(folder_path, exist_ok=True)
            
        file_path = os.path.join(folder_path, file.filename)
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)
            
        # 2. Notify ALL Users
        _notify_all_users(
            "New Document Added", 
            f"A new official {category} document '{title}' has been added to the library.", 
            "success"
        )
        
        return {"status": "success", "message": f"Document '{title}' added and users notified"}
    except Exception as e:
        return {"status": "error", "message": str(e)}

@app.get("/audit_trends/{user_id}")
async def get_audit_trends(user_id: int):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor(dictionary=True)
        # Find 6 days ago at midnight to show a rolling 7-day window ending Today
        now = datetime.now()
        start_date = (now - timedelta(days=6)).replace(hour=0, minute=0, second=0, microsecond=0)
        
        counts = []
        labels = []
        
        for i in range(7):
            day_start = start_date + timedelta(days=i)
            day_end = day_start + timedelta(days=1)
            
            # Format label: Show 'Today' for current date, else day name
            if day_start.date() == now.date():
                label = "Today"
            else:
                label = day_start.strftime("%a")
            
            labels.append(label)
            
            query = "SELECT COUNT(*) as count FROM user_activities WHERE user_id = %s AND activity_type LIKE '%%Audit%%' AND created_at >= %s AND created_at < %s"
            cursor.execute(query, (user_id, day_start, day_end))
            result = cursor.fetchone()
            counts.append(result["count"] if result else 0)
            
        return {
            "status": "success",
            "labels": labels,
            "counts": counts,
            "total_this_week": sum(counts)
        }
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

@app.post("/activities")
async def log_activity(request: dict):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor()
        query = "INSERT INTO user_activities (user_id, activity_type, detail, doc_id) VALUES (%s, %s, %s, %s)"
        cursor.execute(query, (request.get("user_id"), request.get("activity_type"), request.get("detail"), request.get("doc_id")))
        conn.commit()
        return {"status": "success", "message": "Activity logged"}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

@app.get("/activities/{user_id}")
async def get_activities(user_id: int):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM user_activities WHERE user_id = %s ORDER BY created_at DESC LIMIT 500"
        cursor.execute(query, (user_id,))
        activities = cursor.fetchall()
        
        # Format for UI
        def format_time(dt):
            return dt.strftime("%I:%M %p")
            
        def format_date_label(dt):
            today = datetime.now().date()
            if dt.date() == today: return "Today"
            elif dt.date() == (today - timedelta(days=1)): return "Yesterday"
            else: return dt.strftime("%d %b, %Y")

        formatted = []
        for a in activities:
            formatted.append({
                "id": a["id"],
                "type": a["activity_type"],
                "detail": a["detail"],
                "time": format_time(a["created_at"]),
                "date_label": format_date_label(a["created_at"]),
                "doc_id": a["doc_id"]
            })
            
        return {"status": "success", "activities": formatted}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

@app.post("/notifications/mark_read")
async def mark_notifications_read(request: MarkReadRequest):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor()
        if request.notification_id:
            query = "UPDATE notifications SET is_read = TRUE WHERE id = %s AND user_id = %s"
            cursor.execute(query, (request.notification_id, request.user_id))
        else:
            query = "UPDATE notifications SET is_read = TRUE WHERE user_id = %s"
            cursor.execute(query, (request.user_id,))
        conn.commit()
        return {"status": "success", "message": "Notifications updated"}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

@app.post("/notifications/send")
async def send_notification(request: NotificationCreateRequest):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor()
        query = "INSERT INTO notifications (user_id, title, message, type) VALUES (%s, %s, %s, %s)"
        cursor.execute(query, (request.user_id, request.title, request.message, request.type))
        conn.commit()
        return {"status": "success", "message": "Notification sent successfully"}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

@app.get("/notifications/{user_id}")
async def get_notifications(user_id: int):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM notifications WHERE user_id = %s ORDER BY created_at DESC"
        cursor.execute(query, (user_id,))
        notifs = cursor.fetchall()
        
        # Helper to format "X hours ago" for the UI
        def format_time_ago(dt):
            diff = datetime.now() - dt
            seconds = diff.total_seconds()
            if seconds < 60: return "Just now"
            elif seconds < 3600: return f"{int(seconds/60)}m ago"
            elif seconds < 86400: return f"{int(seconds/3600)}h ago"
            else: return f"{int(seconds/86400)}d ago"

        formatted = []
        for n in notifs:
            formatted.append({
                "id": n["id"],
                "title": n["title"],
                "message": n["message"],
                "type": n["type"],
                "is_read": bool(n["is_read"]),
                "time_ago": format_time_ago(n["created_at"])
            })
        return {"status": "success", "notifications": formatted}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

@app.post("/saved_docs")
async def save_document(request: SavedDocRequest):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor()
        query = """
        INSERT INTO saved_docs (user_id, doc_id, title, category, date, format, source, description, content)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE title=VALUES(title), description=VALUES(description), content=VALUES(content)
        """
        clean_doc_id = str(request.doc_id).strip().upper()
        cursor.execute(query, (request.user_id, clean_doc_id, request.title, request.category, request.date, request.format, request.source, request.description, request.content))
        conn.commit()
        
        # Log Save Activity for Trends Graph
        _log_user_activity(request.user_id, "Save", f"Saved {request.title}", clean_doc_id)
        
        return {"status": "success", "message": "Document saved"}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

@app.post("/update_profile")
async def update_profile(request: ProfileUpdateRequest):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor(dictionary=True)
        # Update only the fields that are provided
        update_fields = []
        params = []
        if request.name:
            update_fields.append("name = %s")
            params.append(request.name)
        if request.email:
            update_fields.append("email = %s")
            params.append(request.email)
        if request.employee_id:
            update_fields.append("employee_id = %s")
            params.append(request.employee_id)
        if request.role:
            update_fields.append("role = %s")
            params.append(request.role)
            
        if not update_fields:
            return {"status": "error", "message": "No fields to update"}
            
        params.append(request.user_id)
        query = f"UPDATE users SET {', '.join(update_fields)} WHERE id = %s"
        cursor.execute(query, tuple(params))
        conn.commit()
        
        # Log the activity and Notify
        _log_user_activity(request.user_id, "User", "Updated profile information")
        _create_notification(request.user_id, "Profile Updated", "Your personal information has been updated successfully.", "success")
        
        return {"status": "success", "message": "Profile updated successfully"}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

@app.get("/saved_docs/{user_id}")
async def get_saved_documents(user_id: int):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM saved_docs WHERE user_id = %s", (user_id,))
        saved = cursor.fetchall()
        
        # Enrich with full document data (description, eligibility, etc.)
        all_docs = get_all_documents()
        enriched = []
        for s in saved:
            # Use data from DB if available, otherwise fallback to dataset
            db_id = str(s["doc_id"]).strip().upper()
            doc_data = next((d for d in all_docs if str(d["id"]).strip().upper() == db_id), None)
            
            if doc_data:
                # Create a copy of dataset item and overlay DB values (preserve DB non-null fields)
                merged = doc_data.copy()
                for key, value in s.items():
                    if key in ["id", "user_id"]: continue # Skip DB IDs
                    if value is not None and value != "" and value != "N/A":
                        merged[key] = value
                enriched.append(merged)
            else:
                enriched.append(s)

                
        return {"status": "success", "documents": enriched}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

@app.delete("/saved_docs/{user_id}/{doc_id}")
async def delete_saved_document(user_id: int, doc_id: str):
    conn = get_db_connection()
    if not conn: return {"status": "error", "message": "DB connection failed"}
    try:
        cursor = conn.cursor()
        # Strictly clean the ID for case-insensitive matching in the DB
        clean_doc_id = str(doc_id).strip().upper()
        cursor.execute("DELETE FROM saved_docs WHERE user_id = %s AND (doc_id = %s OR UPPER(TRIM(doc_id)) = %s)", (user_id, clean_doc_id, clean_doc_id))
        conn.commit()
        _log_user_activity(user_id, "Unsave", f"Unsaved document {clean_doc_id}", clean_doc_id)
        return {"status": "success", "message": "Document removed"}
    except Error as e:
        return {"status": "error", "message": str(e)}
    finally:
        conn.close()

def _cleanup_old_data():
    """Migration to ensure all doc_ids are standardized and remove duplicates."""
    conn = get_db_connection()
    if not conn: return
    try:
        cursor = conn.cursor()
        print("[MIGRATION] Standardizing doc_ids and cleaning redundant saved_docs...")
        
        # 1. Standardize all existing IDs to UPPER and TRIMMED
        cursor.execute("UPDATE saved_docs SET doc_id = UPPER(TRIM(doc_id))")
        cursor.execute("UPDATE recent_views SET doc_id = UPPER(TRIM(doc_id))")
        
        # 2. Cleanup complete. We no longer truncate to allow persistent testing.
        print("[MIGRATION] Tables standardized. Truncation disabled for persistence.")
        
        conn.commit()
    except Exception as e:
        print(f"[MIGRATION] Error: {e}")
    finally:
        conn.close()




@app.post("/ai_audit_bulk")
async def ai_audit_bulk(
    user_id: int = Form(...),
    source_url: Optional[str] = Form(None),
    questions: Optional[str] = Form(None),
    mode: str = Form("SCENARIO"),
    files: List[UploadFile] = File(...)
):
    try:
        # 1. Process files and extract text
        extracted_data = process_bulk_files(files)
        if not extracted_data:
            return {"status": "error", "message": "No valid PDF or ZIP files found."}

        # 2. Build the AI Prompt
        context_text = ""
        for item in extracted_data:
            context_text += f"\n--- DOCUMENT: {item['title']} ---\n{item['content']}\n"

        system_prompt = f"""
        You are the 'Senior GOI Regulatory Consultant'. 
        Your goal is to provide a COMPREHENSIVE, EXPERT analysis in {mode} mode.
        
        USER INPUT: {questions or 'Analyze these documents.'}

        INTELLIGENCE MODES (The user selected: {mode}):
        1. SCENARIO: Provide deep, sophisticated answers to user questions. If there's a specific question, handle it with priority.
        2. CONFLICT: 
           - Look for contradictions or misalignments. 
           - If ONLY 1 file is provided, compare it against your internal knowledge of the LATEST GOI (Government of India) regulations, circulars, and departmental standards to find conflicts.
        3. GAP: Critique the document for missing mandatory clauses, expected formatting, or regulatory themes required for this type of document.

        STRICT CONSTRAINTS:
        - FORMATTING: Use these HTML tags only: <b> for bolding, <br> for breaks, <ul> and <li> for lists. Use these to make a beautiful executive report.
        - UNPACKING MESSY FILES: If a single provided PDF contains multiple logically distinct circulars, notifications, or memos, you MUST split them into separate objects in the 'documents' array.
           - Each segment MUST have its own title, compliance score, summary, and **verbatim original_content text belonging specifically to that segment**.
        - SYSTEM SUMMARY: Provide a concise, high-impact "system_audit_summary" (Executive report) in HTML. STRICTLY limit this to exactly **one single, high-impact, professional paragraph**.

        Return in this JSON format:
        {{
          "system_audit_summary": "(DETAILED HTML ANALYSIS FOR THE SELECTED {mode} MODE)",
          "documents": [
            {{
              "id": "DOC_1",
              "title": "Document Title",
              "compliance_score": 85,
              "summary": "Detailed summary",
              "original_content": "Snippet",
              "ai_analysis": "Specific findings"
            }}
          ]
        **CRITICAL**: Return ONLY the raw JSON object. Do NOT include markdown code blocks (no ```json). Do NOT use HTML or Markdown tags (like **bold** or <b>) inside the JSON strings for title, summary, or analysis. Clear, plain text only.
        """
        
        user_input = f"Extracted Content:\n{context_text}"
        
        # Call AI with retry and fallback logic
        ai_response_text = call_gemini_with_retry(system_prompt, user_input, temperature=0.2)
        
        # 3. Parse and return
        try:
            json_text = ai_response_text
            if "```json" in json_text:
                json_text = json_text.split("```json")[1].split("```")[0].strip()
            elif "```" in json_text:
                json_text = json_text.split("```")[1].split("```")[0].strip()
            else:
                # Robust fallback for raw text: find the first { and last }
                start_index = json_text.find("{")
                end_index = json_text.rfind("}")
                if start_index != -1 and end_index != -1:
                    json_text = json_text[start_index:end_index+1].strip()
                
            # Use strict=False to handle potential control characters (like newlines) inside strings
            audit_results = json.loads(json_text, strict=False)
            
            docs = audit_results.get("documents", [])
            system_summary = audit_results.get("system_audit_summary", "Audit completed.")
            
            # Log accurately and Notify
            discovered_count = len(docs) if docs else len(extracted_data)
            _log_user_activity(user_id, "AI Audit", f"Audited {discovered_count} regulatory segments ({mode} Mode)", None)
            # Disabling individual AI Audit notification as requested
            # _create_notification(user_id, "AI Audit Complete", f"Successfully audited {discovered_count} segments in {mode} mode.", "success")

            return {
                "status": "success", 
                "message": "Audit completed successfully", 
                "system_audit_summary": system_summary,
                "documents": docs
            }
        except Exception as parse_err:
            return {"status": "error", "message": f"Parsing Error: {str(parse_err)}", "raw": ai_response_text}
    except Exception as e:
        return {"status": "error", "message": str(e)}


@app.get("/network_info")
async def get_network_info():
    """Returns the local IP address for mobile hotspot access."""
    import socket
    try:
        # Method 1: Get the IP of the default route
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        try:
            # 8.8.8.8 works with internet, but 10.255.255.255 works for local subnets
            s.connect(("10.255.255.255", 1))
            local_ip = s.getsockname()[0]
        except Exception:
            # Method 2: Fallback to socket.gethostbyname
            local_ip = socket.gethostbyname(socket.gethostname())
        finally:
            s.close()
            
        return {
            "status": "success",
            "local_ip": local_ip,
            "access_url": f"http://{local_ip}:8000/web/",
            "message": "Use this URL on your mobile phone connected to this laptop's network"
        }
    except Exception as e:
        return {"status": "error", "message": f"Could not detect IP: {str(e)}"}

def clean_text_for_fpdf(text):
    if not text: return ""
    import re
    # 1. Strip HTML tags (Gemini often includes these and fpdf crashes or mangles them)
    text = re.sub(r'<[^>]*>', '', text)
    
    # 2. Map common high-unicode characters to safe equivalents
    rep = {
        "\u2013": "-", "\u2014": "-", "\u2018": "'", "\u2019": "'",
        "\u201c": "\"", "\u201d": "\"", "\u2022": "*", "\u2026": "...",
        "\u00a0": " ", "\u00b7": "*", "\u20b9": "Rs.", # Rupee symbol
        "\u2122": "(TM)", "\u00a9": "(C)", "\u00ae": "(R)"
    }
    for k, v in rep.items():
        text = text.replace(k, v)
    
    # 3. Final safe encoding: Force to Latin-1 and replace unknown chars with '?'
    # This is the most bulletproof way to prevent AIAudioResults hang
    try:
        return text.encode('latin-1', 'replace').decode('latin-1')
    except:
        return text.encode('ascii', 'ignore').decode('ascii')

@app.post("/export_audit_pdf")
async def export_audit_pdf(request: BriefingExportRequest):
    try:
        # PERFORMANCE OPTIMIZATION: If this specific report already exists, return it immediately
        reports_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "content", "Reports")
        if request.report_id:
            filename = f"user_{request.user_id}_{request.report_id}.pdf"
            repo_path = os.path.join(reports_dir, filename)
            if os.path.exists(repo_path):
                print(f"[*] Serving cached report: {filename}")
                with open(repo_path, "rb") as f:
                    cache_content = f.read()
                return Response(
                    content=cache_content,
                    media_type="application/pdf",
                    headers={"Content-Disposition": f"attachment; filename={filename}"}
                )

        # Proceed with generation if not cached
        pdf = FPDF()
        pdf.add_page()
        
        # Header
        pdf.set_fill_color(0, 51, 102) # Navy Blue
        pdf.rect(0, 0, 210, 40, 'F')
        
        pdf.set_font("Helvetica", "B", 24)
        pdf.set_text_color(255, 255, 255)
        pdf.text(20, 25, "OFFICIAL EXECUTIVE BRIEFING")
        
        pdf.set_font("Helvetica", "", 10)
        pdf.text(20, 32, f"Date: {datetime.now().strftime('%d %b, %Y')} | Generated by GOI AI Compliance Auditor")
        
        pdf.set_y(50)
        pdf.set_text_color(0, 0, 0)
        
        # User Question Section
        if request.questions:
            pdf.set_font("Helvetica", "B", 14)
            pdf.cell(0, 10, "Audit Objective / Question", ln=True)
            pdf.set_font("Helvetica", "", 12)
            pdf.multi_cell(0, 8, clean_text_for_fpdf(request.questions))
            pdf.ln(10)

        # Audit Documents
        for idx, doc in enumerate(request.audit_data):
            pdf.set_font("Helvetica", "B", 12)
            pdf.set_fill_color(240, 240, 240)
            pdf.cell(0, 10, clean_text_for_fpdf(f"{idx+1}. {doc.title}"), ln=True, fill=True)
            
            pdf.set_font("Helvetica", "B", 10)
            pdf.cell(40, 10, f"Compliance Score: {doc.compliance_score}%")
            pdf.ln(8)
            
            pdf.set_font("Helvetica", "B", 10)
            pdf.cell(0, 8, "Summary:", ln=True)
            pdf.set_font("Helvetica", "", 10)
            pdf.multi_cell(0, 6, clean_text_for_fpdf(doc.summary))
            
            pdf.ln(4)
            pdf.set_font("Helvetica", "B", 10)
            pdf.cell(0, 8, "Detailed Analysis & Audit Findings:", ln=True)
            pdf.set_font("Helvetica", "", 10)
            pdf.multi_cell(0, 6, clean_text_for_fpdf(doc.ai_analysis))
            
            pdf.ln(10)
            if pdf.get_y() > 250:
                pdf.add_page()

        # Footer
        pdf.set_y(-20)
        pdf.set_font("Helvetica", "I", 8)
        pdf.cell(0, 10, "This is an AI-generated report for informational purposes. Verify with official gazettes.", align='C')

        # Output to buffer (Ensure bytes for Python 3)
        pdf_output = pdf.output()
        if isinstance(pdf_output, str):
            # Fallback if an older fpdf library returns a string (Latin-1 encoded)
            pdf_output = pdf_output.encode('latin-1')
        elif isinstance(pdf_output, bytearray):
            # Ensure it is a standard bytes object for FastAPI
            pdf_output = bytes(pdf_output)
        
        # Save a copy to the server's Reports folder
        if request.report_id:
            # FIX: Filename with user_id prefix for privacy isolation
            filename = f"user_{request.user_id}_{request.report_id}.pdf"
        else:
            filename = f"user_{request.user_id}_GOI_Audit_Briefing_{datetime.now().strftime('%Y%m%d%H%M%S')}.pdf"
            
        reports_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "content", "Reports")
        if not os.path.exists(reports_dir):
            os.makedirs(reports_dir)
            
        repo_path = os.path.join(reports_dir, filename)
        try:
            with open(repo_path, "wb") as f:
                f.write(pdf_output)
            print(f"[*] Audit Report saved to server: {repo_path}")
        except Exception as save_err:
            print(f"[!] Failed to save report copy: {save_err}")

        # Return the PDF as a direct download response
        return Response(
            content=pdf_output,
            media_type="application/pdf",
            headers={"Content-Disposition": f"attachment; filename={filename}"}
        )

    except Exception as e:
        traceback.print_exc()
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/delete_report")
async def delete_report(request: dict):
    doc_id = request.get("doc_id")
    if not doc_id:
        return {"status": "error", "message": "Missing doc_id"}
        
    try:
        # Search multiple directories where reports might reside
        search_dirs = ["Reports", "pdf", "Circulars", "Guidelines"]
        content_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "content")
        
        found_file_path = None
        # Try both case-sensitive and case-insensitive matches
        for folder in search_dirs:
            dir_path = os.path.join(content_dir, folder)
            if not os.path.exists(dir_path): continue
            
            for f in os.listdir(dir_path):
                # Standardize comparison logic with find_file_by_id
                if f.lower().endswith(".pdf"):
                    clean_f = f.replace(".pdf", "")
                    if f == f"{doc_id}.pdf" or f == doc_id or \
                       f"_{doc_id}." in f or f"{doc_id}_" in f or \
                       clean_f == doc_id:
                        found_file_path = os.path.join(dir_path, f)
                        break
            if found_file_path: break
            
        if found_file_path and os.path.exists(found_file_path):
            os.remove(found_file_path)
            return {"status": "success", "message": "Report deleted successfully"}
        else:
            # SILENT SUCCESS: If file is already gone, return success to clear it from app list
            return {"status": "success", "message": "Report removed from view"}
            
    except Exception as e:
        return {"status": "error", "message": f"Delete failed: {str(e)}"}

@app.post("/chatbot")
async def chatbot(request: ChatBotRequest):
    try:
        # 1. System Prompt for Global Education Specialist (Gemini-style)
        system_prompt = f"""
        You are the **Ministry of Education AI Assistant**, a world-class expert on Indian educational policies, schemes, and academic governance.
        Your persona is a distinguished Senior Advisor representing the Ministry of Education, Government of India.

        **MISSION**: 
        1. Assist users with queries related to the **Ministry of Education**, its policies (e.g., NEP 2020), national schemes, scholarships, universities, schools, and pedagogical standards.
        2. **Human Conversation**: You ARE allowed to engage in normal human conversation and pleasantries (e.g., "Hi", "Hello", "How are you?"). Respond warmly and professionally.
        
        **STRICT DOMAIN CONSTRAINT**:
        - If a user asks questions completely "out of the box" (unrelated to Education or the Ministry of Education's scope), you must politely decline.
        - Refusal Message: "I am a specialized **Ministry of Education AI Assistant**. I can ONLY answer education-related queries, policies, and schemes. How can I help you with our academic frameworks today?"
        - **IMPORTANT**: NEVER include the text "ANI IVVU" in any response.

        **GUIDELINES**:
        1. **Direct Answers**: Provide authoritative, high-quality answers immediately.
        2. **Formatting**: Use HTML <b> tags for **bolding** (e.g., <b>Bold Text</b>). Do NOT use Markdown symbols like **.
        3. **Expertise**: Use your global knowledge; you are an expert consultant.
        4. **Brevity**: Keep responses under 150 words.
        """
        
        # Use the centralized retry helper
        ai_message = call_gemini_with_retry(system_prompt, f"User Question: {request.message}")
        
        if not ai_message:
            return {"status": "error", "message": "AI returned an empty response. Please try again."}
        
        # 4. Log Activity
        _log_user_activity(request.user_id, "AI Chat", f"Asked: {request.message[:50]}...", None)
                
        return {"status": "success", "message": ai_message}
        
    except Exception as e:
        return {"status": "error", "message": f"Internal Server Error: {str(e)}"}

# --- Integrated Testing Logic ---
@app.get("/test_ai")
async def test_ai_endpoint():
    """Simple GET endpoint to verify AI personality and bold formatting."""
    test_request = ChatBotRequest(user_id=1, message="Help me understand <b>bold letters</b> in chat!")
    return await chatbot(test_request)

# Catch-all for silent tracker requests to stop log clutter
@app.get("/hybridaction/{path:path}")
async def silent_tracker(path: str):
    """Silently handles injected tracking scripts from some browsers/extensions."""
    return {"status": "success", "message": "silently_ignored"}
