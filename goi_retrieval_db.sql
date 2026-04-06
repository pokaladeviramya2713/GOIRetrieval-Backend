-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Apr 06, 2026 at 09:32 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `goi_retrieval_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(20) DEFAULT 'info',
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `type`, `is_read`, `created_at`) VALUES
(1, 6, 'Welcome to GOI Retrieval!', 'We are glad to have you here. Start by searching for any document or browsing the dataset.', 'success', 1, '2026-03-13 14:19:45'),
(2, 6, 'Personalize your experience', 'You can now save documents to your \'Saved Docs\' for quick access later.', 'info', 1, '2026-03-13 14:19:45'),
(3, 7, 'Welcome to GOI Retrieval!', 'We are glad to have you here. Start by searching for any document or browsing the dataset.', 'success', 1, '2026-03-13 14:26:56'),
(4, 7, 'Personalize your experience', 'You can now save documents to your \'Saved Docs\' for quick access later.', 'info', 1, '2026-03-13 14:26:56'),
(7, 1, 'New Policy Alert', 'A new GOI directive has been released. Please review.', 'info', 1, '2026-03-13 14:36:54'),
(10, 10, 'Welcome to GOI Retrieval!', 'We are glad to have you here. Start by searching for any document or browsing the dataset.', 'success', 1, '2026-03-30 10:39:10'),
(11, 10, 'Personalize your experience', 'You can now save documents to your \'Saved Docs\' for quick access later.', 'info', 1, '2026-03-30 10:39:10'),
(12, 1, 'AI Audit Complete', 'Successfully audited 1 segments in SCENARIO mode.', 'success', 1, '2026-04-03 13:13:38'),
(13, 1, 'AI Audit Complete', 'Successfully audited 1 segments in CONFLICT mode.', 'success', 1, '2026-04-03 13:15:06'),
(14, 1, 'AI Audit Complete', 'Successfully audited 1 segments in GAP mode.', 'success', 1, '2026-04-03 13:16:26'),
(15, 1, 'Profile Updated', 'Your personal information has been updated successfully.', 'success', 1, '2026-04-03 13:16:55'),
(16, 1, 'Support Ticket Raised', 'We\'ve initiated your support request. Please complete the email to our team at goiretrieval@gmail.com.', 'success', 1, '2026-04-03 13:38:37'),
(20, 12, 'Welcome to GOI Retrieval!', 'We are glad to have you here. Start by searching for any document or browsing the dataset.', 'success', 1, '2026-04-03 14:24:28'),
(21, 12, 'Personalize your experience', 'You can now save documents to your \'Saved Docs\' for quick access later.', 'info', 1, '2026-04-03 14:24:28'),
(22, 1, 'AI Audit Complete', 'Successfully audited 2 segments in SCENARIO mode.', 'success', 1, '2026-04-04 10:30:39'),
(23, 1, 'AI Audit Complete', 'Successfully audited 2 segments in SCENARIO mode.', 'success', 1, '2026-04-04 10:38:55'),
(24, 1, 'AI Audit Complete', 'Successfully audited 2 segments in SCENARIO mode.', 'success', 1, '2026-04-04 10:47:19'),
(25, 1, 'New Policy Document Added', 'A new official Regulation & Policy document has been added to the library (Search Docs).', 'success', 1, '2026-04-04 12:19:44'),
(26, 4, 'New Policy Document Added', 'A new official Regulation & Policy document has been added to the library (Search Docs).', 'success', 0, '2026-04-04 12:19:44'),
(27, 10, 'New Policy Document Added', 'A new official Regulation & Policy document has been added to the library (Search Docs).', 'success', 0, '2026-04-04 12:19:44'),
(28, 12, 'New Policy Document Added', 'A new official Regulation & Policy document has been added to the library (Search Docs).', 'success', 0, '2026-04-04 12:19:44'),
(29, 2, 'New Policy Document Added', 'A new official Regulation & Policy document has been added to the library (Search Docs).', 'success', 0, '2026-04-04 12:19:44'),
(30, 5, 'New Policy Document Added', 'A new official Regulation & Policy document has been added to the library (Search Docs).', 'success', 0, '2026-04-04 12:19:44'),
(31, 6, 'New Policy Document Added', 'A new official Regulation & Policy document has been added to the library (Search Docs).', 'success', 0, '2026-04-04 12:19:44'),
(32, 7, 'New Policy Document Added', 'A new official Regulation & Policy document has been added to the library (Search Docs).', 'success', 0, '2026-04-04 12:19:44'),
(33, 11, 'New Policy Document Added', 'A new official Regulation & Policy document has been added to the library (Search Docs).', 'success', 0, '2026-04-04 12:19:44'),
(34, 1, 'Update Available', 'A system update (v2.1) is now available. Please restart the app to apply the latest improvements.', 'info', 1, '2026-04-04 12:29:17'),
(35, 4, 'Update Available', 'A system update (v2.1) is now available. Please restart the app to apply the latest improvements.', 'info', 0, '2026-04-04 12:29:17'),
(36, 10, 'Update Available', 'A system update (v2.1) is now available. Please restart the app to apply the latest improvements.', 'info', 0, '2026-04-04 12:29:17'),
(37, 12, 'Update Available', 'A system update (v2.1) is now available. Please restart the app to apply the latest improvements.', 'info', 0, '2026-04-04 12:29:17'),
(38, 2, 'Update Available', 'A system update (v2.1) is now available. Please restart the app to apply the latest improvements.', 'info', 0, '2026-04-04 12:29:17'),
(39, 5, 'Update Available', 'A system update (v2.1) is now available. Please restart the app to apply the latest improvements.', 'info', 0, '2026-04-04 12:29:17'),
(40, 6, 'Update Available', 'A system update (v2.1) is now available. Please restart the app to apply the latest improvements.', 'info', 0, '2026-04-04 12:29:17'),
(41, 7, 'Update Available', 'A system update (v2.1) is now available. Please restart the app to apply the latest improvements.', 'info', 0, '2026-04-04 12:29:17'),
(42, 11, 'Update Available', 'A system update (v2.1) is now available. Please restart the app to apply the latest improvements.', 'info', 0, '2026-04-04 12:29:17'),
(43, 1, 'Account Login', 'A new login was detected on Redmi Note 9 Pro.', 'info', 1, '2026-04-05 09:25:44'),
(44, 1, 'Account Login', 'A new login was detected on Redmi Note 9 Pro.', 'info', 1, '2026-04-05 09:28:19'),
(45, 1, 'Account Login', 'A new login was detected on a new device.', 'info', 1, '2026-04-05 10:07:35'),
(46, 1, 'Account Login', 'A new login was detected on Redmi Note 9 Pro.', 'info', 1, '2026-04-05 10:24:52'),
(47, 13, 'Welcome to GOI Retrieval!', 'We are glad to have you here. Start by searching for any document or browsing the dataset.', 'success', 1, '2026-04-05 10:26:45'),
(48, 13, 'Personalize your experience', 'You can now save documents to your \'Saved Docs\' for quick access later.', 'info', 1, '2026-04-05 10:26:45'),
(49, 13, 'Account Login', 'A new login was detected on Redmi Note 9 Pro.', 'info', 1, '2026-04-05 10:27:00'),
(50, 1, 'Profile Updated', 'Your personal information has been updated successfully.', 'success', 1, '2026-04-05 20:34:58'),
(51, 1, 'Profile Updated', 'Your personal information has been updated successfully.', 'success', 1, '2026-04-05 20:43:17'),
(52, 1, 'Profile Updated', 'Your personal information has been updated successfully.', 'success', 1, '2026-04-05 20:43:47'),
(53, 1, 'Profile Updated', 'Your personal information has been updated successfully.', 'success', 0, '2026-04-05 21:08:02'),
(54, 1, 'Profile Updated', 'Your personal information has been updated successfully.', 'success', 0, '2026-04-05 21:14:29'),
(55, 1, 'Profile Updated', 'Your personal information has been updated successfully.', 'success', 0, '2026-04-05 21:17:10'),
(56, 1, 'Profile Updated', 'Your personal information has been updated successfully.', 'success', 0, '2026-04-05 21:39:27'),
(57, 14, 'Welcome to GOI Retrieval!', 'We are glad to have you here. Start by searching for any document or browsing the dataset.', 'success', 0, '2026-04-05 22:38:33'),
(58, 14, 'Personalize your experience', 'You can now save documents to your \'Saved Docs\' for quick access later.', 'info', 0, '2026-04-05 22:38:34'),
(59, 5, 'Account Login', 'A new login was detected on Web Portal.', 'info', 0, '2026-04-05 22:54:01'),
(60, 1, 'Account Login', 'A new login was detected on Web Portal.', 'info', 0, '2026-04-05 22:55:14'),
(61, 15, 'Welcome to GOI Retrieval!', 'We are glad to have you here. Start by searching for any document or browsing the dataset.', 'success', 0, '2026-04-05 22:56:28'),
(62, 15, 'Personalize your experience', 'You can now save documents to your \'Saved Docs\' for quick access later.', 'info', 0, '2026-04-05 22:56:28'),
(63, 1, 'Account Login', 'A new login was detected on Web Portal.', 'info', 0, '2026-04-05 22:57:41'),
(64, 1, 'Account Login', 'A new login was detected on Redmi Note 9 Pro.', 'info', 0, '2026-04-06 08:38:56'),
(65, 15, 'Account Login', 'A new login was detected on Web Portal.', 'info', 0, '2026-04-06 10:08:47'),
(66, 1, 'Account Login', 'A new login was detected on Redmi Note 9 Pro.', 'info', 0, '2026-04-06 10:47:20'),
(67, 1, 'Account Login', 'A new login was detected on Redmi Note 9 Pro.', 'info', 0, '2026-04-06 10:48:16');

-- --------------------------------------------------------

--
-- Table structure for table `otps`
--

CREATE TABLE `otps` (
  `email` varchar(100) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `otps`
--

INSERT INTO `otps` (`email`, `otp`, `created_at`) VALUES
('pokala.deviramya2713@gmail.com', '867208', '2026-04-05 22:56:40'),
('test@education.gov.in', '173476', '2026-04-05 22:50:50'),
('testuser@example.com', '619396', '2026-03-20 09:24:27');

-- --------------------------------------------------------

--
-- Table structure for table `recent_views`
--

CREATE TABLE `recent_views` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `doc_id` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `format` varchar(100) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  `viewed_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recent_views`
--

INSERT INTO `recent_views` (`id`, `user_id`, `doc_id`, `title`, `category`, `date`, `format`, `source`, `description`, `content`, `viewed_at`) VALUES
(1, 1, 'DOC19', 'National Fellowship for ST Students', 'Schemes', '2025-03-13', 'TXT', 'Ministry of Education', 'This scheme provides financial support to students belonging to Scheduled Tribes (ST) for pursuing higher studies leading to M.Phil and Ph.D degrees in all disciplines. The initiative is part of the government\'s commitment to social justice and empowerment. It ensures that tribal students have the financial means to attain the highest levels of academic excellence in premier institutions both within India and abroad through specialized support modules.', 'Document ID: DOC19\n\nTitle: National Fellowship for ST Students\n\nCategory: Schemes\n\nDepartment: Ministry of Education / Tribal Affairs\n\nDescription:\nThis scheme provides financial support to students belonging to Scheduled Tribes (ST) for pursuing higher studies leading to M.Phil and Ph.D degrees in all disciplines. The initiative is part of the government\'s commitment to social justice and empowerment. It ensures that tribal students have the financial means to attain the highest levels of academic excellence in premier institutions both within India and abroad through specialized support modules.\n\nEligibility:\n- Candidates belonging to the Scheduled Tribe community\n- Qualified in UGC-NET or CSIR-NET exams\n- Admitted to recognized Universities/Institutions\n\nBenefits:\n- Full fellowship covering living and research expenses\n- Support for purchasing computers and books\n- Travel grants for participating in international conferences', '2026-03-28 21:29:54'),
(2, 1, 'DOC21', 'NEP 2020 Implementation Progress Report', 'Reports', '2025-03-13', 'PDF', 'Ministry of Education', 'This report tracks the status of various initiatives launched under the National Education Policy 2020. It covers progress in areas like the National Credit Framework, Digital Learning through SWAYAM, Multidisciplinary Education, and the creation of Academic Bank of Credits (ABC). The report provides a roadmap for the next phase of implementation across states and central institutions.', 'Document ID: DOC21\n\nTitle: NEP 2020 Implementation Progress Report\n\nCategory: Reports\n\nDepartment: Ministry of Education\n\nDescription:\nThis report tracks the status of various initiatives launched under the National Education Policy 2020. It covers progress in areas like the National Credit Framework, Digital Learning through SWAYAM, Multidisciplinary Education, and the creation of Academic Bank of Credits (ABC). The report provides a roadmap for the next phase of implementation across states and central institutions.\n\nEligibility:\n- State Education Departments\n- University Vice Chancellors and Academic Deans\n- Policy Implementers and Evaluators\n\nBenefits:\n- Clear understanding of policy milestones achieved\n- Guidance on pending implementation requirements\n- Alignment with national educational transformation goals', '2026-03-23 09:22:17'),
(124, 1, 'DOC26', 'NPTEL Course Recognition Rules', 'Notifications', '2025-03-13', 'TXT', 'Ministry of Education', '™¹fë÷National Programme on Technology Enhanced Learning (NPTEL) is a project of MHRD initiated by seven Indian Institutes of Technology (IITs). This notification formalizes the recognition of NPTEL certificates for credit transfer and for faculty recruitment in engineering and science colleges. It specifies the examination process, the proctored nature of tests, and how the results are verified by the host IITs to ensure high standards of academic rigor equivalent to on-campus cou', 'rses.Document ID: DOC26\n\nTitle: NPTEL Course Recognition Rules\n\nCategory: Notifications\n\nDepartment: Ministry of Education\n\nDescription:\nNational Programme on Technology Enhanced Learning (NPTEL) is a project of MHRD initiated by seven Indian Institutes of Technology (IITs). This notification formalizes the recognition of NPTEL certificates for credit transfer and for faculty recruitment in engineering and science colleges. It specifies the examination process, the proctored nature of tests, and how the results are verified by the host IITs to ensure high standards of academic rigor equivalent to on-campus courses.\n\nEligibility:\n- Students and faculty in technical institutions\n- Working professionals seeking specialized certifications\n- Institutions seeking to augment their course offerings\n\nBenefits:\n- High-quality video lectures from IIT faculty\n- Industry-recognized certificates for career advancement\n- Credit transfer into university records upon successful compl', '2026-04-05 09:04:15'),
(125, 1, 'DOC12', 'AICTE Approval Handbook 2024-27', 'Circulars', '2025-03-13', 'TXT', 'Ministry of Education', '™¹hÊ(This handbook provides the comprehensive procedures and requirements for establishing new technical institutions or for getting approval for extension/variation in courses. It sets the minimum standards for infrastructure, faculty-student ratio, library resources, and laboratory equipment. The new 2024-27 cycle emphasizes industry-academia collaboration and the introduction of vocational or skill-based courses in technical domains to improve student employabi', 'lity.Document ID: DOC12\n\nTitle: AICTE Approval Handbook 2024-27\n\nCategory: Circulars\n\nDepartment: AICTE\n\nDescription:\nThis handbook provides the comprehensive procedures and requirements for establishing new technical institutions or for getting approval for extension/variation in courses. It sets the minimum standards for infrastructure, faculty-student ratio, library resources, and laboratory equipment. The new 2024-27 cycle emphasizes industry-academia collaboration and the introduction of vocational or skill-based courses in technical domains to improve student employability.\n\nEligibility:\n- Trusts, Societies, or Companies managing colleges\n- Government-run technical institutions\n- Universities seeking AICTE validation for technical courses\n\nBenefits:\n- National recognition and validity of technical degrees\n- Eligibility for central funding and faculty development programs\n- Enhanced credibility for student place', '2026-03-30 10:24:38'),
(126, 1, 'DOC20', 'KV Teacher Transfer Policy 2026', 'Circulars', '2025-03-13', 'TXT', 'Ministry of Education', '™¹fì\0This circular outlines the revised transfer policy for teaching and non-teaching staff of Kendriya Vidyalayas. It introduces a point-based system for transfers based on tenure, performance, and family circumstances. The policy emphasizes the need for \'hard station\' deployments and provides incentives for teachers willing to serve in remote or North-Eastern regions. It aims to ensure a balanced distribution of experienced faculty across all schools in the KVS net', 'work.Document ID: DOC20\n\nTitle: KV Teacher Transfer Policy 2026\n\nCategory: Circulars\n\nDepartment: KVS\n\nDescription:\nThis circular outlines the revised transfer policy for teaching and non-teaching staff of Kendriya Vidyalayas. It introduces a point-based system for transfers based on tenure, performance, and family circumstances. The policy emphasizes the need for \'hard station\' deployments and provides incentives for teachers willing to serve in remote or North-Eastern regions. It aims to ensure a balanced distribution of experienced faculty across all schools in the KVS network.\n\nEligibility:\n- All regular employees of Kendriya Vidyalaya Sangathan\n- Minimum tenure completed at current station\n- Priority for medical and spouse-ground cases\n\nBenefits:\n- Transparent and automated transfer process\n- Incentives for serving in difficult locations\n- Predictability for personal and professional pla', '1383-11-11 09:06:25'),
(127, 1, 'DOC7', 'CBSE Assessment Circular 2026', 'Circulars', '2025-03-13', 'TXT', 'Ministry of Education', '™¹fìThis official circular outlines the new assessment and evaluation pattern for Class X and XII Board examinations scheduled for the academic session 2025-26. It introduces more competency-based questions that test the application of concepts in real-life situations. The weightage for traditional rote-learning based questions has been reduced in favor of case-study and assertion-reasoning type questions to align with NEP 2020 g', 'oals.Document ID: DOC7\n\nTitle: CBSE Assessment Circular 2026\n\nCategory: Circulars\n\nDepartment: CBSE\n\nDescription:\nThis official circular outlines the new assessment and evaluation pattern for Class X and XII Board examinations scheduled for the academic session 2025-26. It introduces more competency-based questions that test the application of concepts in real-life situations. The weightage for traditional rote-learning based questions has been reduced in favor of case-study and assertion-reasoning type questions to align with NEP 2020 goals.\n\nEligibility:\n- All schools affiliated with CBSE\n- Students appearing for Board Exams in 2026\n- Teachers and examiners involved in school-based assessments\n\nBenefits:\n- Shift from rote learning to conceptual understanding\n- Better preparation for competitive entrance exams\n- Transparent and fair evaluation bench', '2026-04-01 09:32:32'),
(128, 1, 'DOC22', 'AICTE Idea Lab Establishment', 'Guidelines', '2025-03-13', 'TXT', 'Ministry of Education', '™¹hˆIThese guidelines explain the procedure for setting up an \'AICTE IDEA (Idea Development, Evaluation & Application) Lab\' in technical institutions. The lab is meant to encourage students to apply science, technology, engineering and mathematics (STEM) fundamentals towards solving real-life problems. It provides a platform for students to work on projects that lead to prototypes, patents, and startups. The document outlines the equipment list, space requirements, and the funding pattern from A', 'ICTE.Document ID: DOC22\n\nTitle: AICTE Idea Lab Establishment\n\nCategory: Guidelines\n\nDepartment: AICTE\n\nDescription:\nThese guidelines explain the procedure for setting up an \'AICTE IDEA (Idea Development, Evaluation & Application) Lab\' in technical institutions. The lab is meant to encourage students to apply science, technology, engineering and mathematics (STEM) fundamentals towards solving real-life problems. It provides a platform for students to work on projects that lead to prototypes, patents, and startups. The document outlines the equipment list, space requirements, and the funding pattern from AICTE.\n\nEligibility:\n- AICTE approved institutions with at least 10 years standing\n- Availability of 3000 sq ft space for the lab\n- Commitment of matching funds from the institution\n\nBenefits:\n- Grant of Rs. 15 Lakhs for lab equipment\n- Access to specialized training and mentorship programs\n- Recognition as a hub for innovation and entrepreneu', '2026-04-05 09:04:09'),
(131, 1, 'DOC9', 'Mid-Day Meal (PM-POSHAN) Rules', 'Schemes', '2025-03-13', 'TXT', 'Ministry of Education', '™¹hÊ%The PM-POSHAN (Pradhan Mantri Poshan Shakti Nirman) Scheme provides a hot cooked meal to children in government and government-aided schools. These updated 2025 rules focus on the nutritional quality of the meals, emphasizing the inclusion of millets, fresh vegetables, and fortifying ingredients. The policy also mandates regular social audits and the involvement of School Management Committees (SMCs) in monitoring the daily cooking process and hygiene stand', 'ards.Document ID: DOC9\n\nTitle: Mid-Day Meal (PM-POSHAN) Rules\n\nCategory: Schemes\n\nDepartment: Department of School Education\n\nDescription:\nThe PM-POSHAN (Pradhan Mantri Poshan Shakti Nirman) Scheme provides a hot cooked meal to children in government and government-aided schools. These updated 2025 rules focus on the nutritional quality of the meals, emphasizing the inclusion of millets, fresh vegetables, and fortifying ingredients. The policy also mandates regular social audits and the involvement of School Management Committees (SMCs) in monitoring the daily cooking process and hygiene standards.\n\nEligibility:\n- Children in Classes I-VIII in government schools\n- Specific focus on Aspirational Districts\n- Implementation through local self-help groups (SHGs)\n\nBenefits:\n- Improved nutritional status and health of school-going children\n- Increased enrollment and retention rates in primary schools\n- Employment creation for local women in cooking ce', '2026-03-31 10:19:43'),
(133, 1, 'DOC3', 'Anti-Ragging Guidelines 2025', 'Circulars', '2025-03-13', 'TXT', 'Ministry of Education', '™¹hÊ+These updated guidelines strictly prohibit any form of ragging in higher educational institutions. Every institution is required to form an Anti-Ragging Committee and an Anti-Ragging Squad to monitor and prevent untoward incidents. The circular mandates the submission of anti-ragging undertakings by students and parents at the time of admission. Zero tolerance is prescribed for any violations, with potential rustication of offen', 'ders.Document ID: DOC3\n\nTitle: Anti-Ragging Guidelines 2025\n\nCategory: Circulars\n\nDepartment: UGC\n\nDescription:\nThese updated guidelines strictly prohibit any form of ragging in higher educational institutions. Every institution is required to form an Anti-Ragging Committee and an Anti-Ragging Squad to monitor and prevent untoward incidents. The circular mandates the submission of anti-ragging undertakings by students and parents at the time of admission. Zero tolerance is prescribed for any violations, with potential rustication of offenders.\n\nEligibility:\n- Mandatory for all Universities recognized by UGC\n- Applies to all constituent and affiliated colleges\n- Applicable to all students and staff members\n\nBenefits:\n- Safe and secure campus environment for new students\n- Standardized disciplinary procedures for violations\n- 24/7 National Anti-Ragging Helpline a', '2026-04-05 09:04:12'),
(136, 1, 'DOC27', 'PM-POSHAN Monitoring Report 2025', 'Reports', '2025-03-13', 'PDF', 'Ministry of Education', 'A comprehensive progress report on the PM-POSHAN (Mid-Day Meal) scheme across all Indian states. This report analyzes the reach of the hot cooked meal program, the nutritional impact on children, and the efficiency of the direct benefit transfer (DBT) mechanisms. It includes case studies of best practices from high-performing districts and identifies areas requiring infrastructure upgrades for better hygiene.', 'Document ID: DOC27\n\nTitle: PM-POSHAN Monitoring Report 2025\n\nCategory: Reports\n\nDepartment: Dept of School Education\n\nDescription:\nA comprehensive progress report on the PM-POSHAN (Mid-Day Meal) scheme across all Indian states. This report analyzes the reach of the hot cooked meal program, the nutritional impact on children, and the efficiency of the direct benefit transfer (DBT) mechanisms. It includes case studies of best practices from high-performing districts and identifies areas requiring infrastructure upgrades for better hygiene.\n\nEligibility:\n- District Collectors and Education Officers\n- School Management Committees (SMCs)\n- Health and Nutrition Researchers\n\nBenefits:\n- Data-backed insights into child nutrition outcomes\n- Assessment of scheme delivery efficiency\n- Identification of resource gaps in primary education', '2026-03-30 20:58:48'),
(141, 10, 'DOC19', 'National Fellowship for ST Students', 'Schemes', '2025-03-13', 'TXT', 'Ministry of Education', 'This scheme provides financial support to students belonging to Scheduled Tribes (ST) for pursuing higher studies leading to M.Phil and Ph.D degrees in all disciplines. The initiative is part of the government\'s commitment to social justice and empowerment. It ensures that tribal students have the financial means to attain the highest levels of academic excellence in premier institutions both within India and abroad through specialized support modules.', 'Document ID: DOC19\n\nTitle: National Fellowship for ST Students\n\nCategory: Schemes\n\nDepartment: Ministry of Education / Tribal Affairs\n\nDescription:\nThis scheme provides financial support to students belonging to Scheduled Tribes (ST) for pursuing higher studies leading to M.Phil and Ph.D degrees in all disciplines. The initiative is part of the government\'s commitment to social justice and empowerment. It ensures that tribal students have the financial means to attain the highest levels of academic excellence in premier institutions both within India and abroad through specialized support modules.\n\nEligibility:\n- Candidates belonging to the Scheduled Tribe community\n- Qualified in UGC-NET or CSIR-NET exams\n- Admitted to recognized Universities/Institutions\n\nBenefits:\n- Full fellowship covering living and research expenses\n- Support for purchasing computers and books\n- Travel grants for participating in international conferences', '2026-03-30 10:41:16'),
(143, 10, 'DOC9', 'Mid-Day Meal (PM-POSHAN) Rules', 'Schemes', '2025-03-13', 'TXT', 'Ministry of Education', 'The PM-POSHAN (Pradhan Mantri Poshan Shakti Nirman) Scheme provides a hot cooked meal to children in government and government-aided schools. These updated 2025 rules focus on the nutritional quality of the meals, emphasizing the inclusion of millets, fresh vegetables, and fortifying ingredients. The policy also mandates regular social audits and the involvement of School Management Committees (SMCs) in monitoring the daily cooking process and hygiene standards.', 'Document ID: DOC9\n\nTitle: Mid-Day Meal (PM-POSHAN) Rules\n\nCategory: Schemes\n\nDepartment: Department of School Education\n\nDescription:\nThe PM-POSHAN (Pradhan Mantri Poshan Shakti Nirman) Scheme provides a hot cooked meal to children in government and government-aided schools. These updated 2025 rules focus on the nutritional quality of the meals, emphasizing the inclusion of millets, fresh vegetables, and fortifying ingredients. The policy also mandates regular social audits and the involvement of School Management Committees (SMCs) in monitoring the daily cooking process and hygiene standards.\n\nEligibility:\n- Children in Classes I-VIII in government schools\n- Specific focus on Aspirational Districts\n- Implementation through local self-help groups (SHGs)\n\nBenefits:\n- Improved nutritional status and health of school-going children\n- Increased enrollment and retention rates in primary schools\n- Employment creation for local women in cooking centers', '2026-03-30 10:41:25');

-- --------------------------------------------------------

--
-- Table structure for table `saved_docs`
--

CREATE TABLE `saved_docs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `doc_id` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `format` varchar(100) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `saved_docs`
--

INSERT INTO `saved_docs` (`id`, `user_id`, `doc_id`, `title`, `category`, `date`, `format`, `source`, `description`, `content`, `created_at`) VALUES
(31, 1, 'DOC12', 'AICTE Approval Handbook 2024-27', 'Circulars', '2025-03-13', 'TXT', 'Ministry of Education', 'ï¿½ï¿½hï¿½(This handbook provides the comprehensive procedures and requirements for establishing new technical institutions or for getting approval for extension/variation in courses. It sets the minimum standards for infrastructure, faculty-student ratio, library resources, and laboratory equipment. The new 2024-27 cycle emphasizes industry-academia collaboration and the introduction of vocational or skill-based courses in technical domains to improve student employabi', 'lity.Document ID: DOC12\n\nTitle: AICTE Approval Handbook 2024-27\n\nCategory: Circulars\n\nDepartment: AICTE\n\nDescription:\nThis handbook provides the comprehensive procedures and requirements for establishing new technical institutions or for getting approval for extension/variation in courses. It sets the minimum standards for infrastructure, faculty-student ratio, library resources, and laboratory equipment. The new 2024-27 cycle emphasizes industry-academia collaboration and the introduction of vocational or skill-based courses in technical domains to improve student employability.\n\nEligibility:\n- Trusts, Societies, or Companies managing colleges\n- Government-run technical institutions\n- Universities seeking AICTE validation for technical courses\n\nBenefits:\n- National recognition and validity of technical degrees\n- Eligibility for central funding and faculty development programs\n- Enhanced credibility for student place', '2026-03-31 09:43:50'),
(39, 1, 'DOC26', 'NPTEL Course Recognition Rules', 'Notifications', '2025-03-13', 'TXT', 'Ministry of Education', 'National Programme on Technology Enhanced Learning (NPTEL) is a project of MHRD initiated by seven Indian Institutes of Technology (IITs). This notification formalizes the recognition of NPTEL certificates for credit transfer and for faculty recruitment in engineering and science colleges. It specifies the examination process, the proctored nature of tests, and how the results are verified by the host IITs to ensure high standards of academic rigor equivalent to on-campus courses.', 'Document ID: DOC26\n\nTitle: NPTEL Course Recognition Rules\n\nCategory: Notifications\n\nDepartment: Ministry of Education\n\nDescription:\nNational Programme on Technology Enhanced Learning (NPTEL) is a project of MHRD initiated by seven Indian Institutes of Technology (IITs). This notification formalizes the recognition of NPTEL certificates for credit transfer and for faculty recruitment in engineering and science colleges. It specifies the examination process, the proctored nature of tests, and how the results are verified by the host IITs to ensure high standards of academic rigor equivalent to on-campus courses.\n\nEligibility:\n- Students and faculty in technical institutions\n- Working professionals seeking specialized certifications\n- Institutions seeking to augment their course offerings\n\nBenefits:\n- High-quality video lectures from IIT faculty\n- Industry-recognized certificates for career advancement\n- Credit transfer into university records upon successful completion', '2026-04-01 09:32:07'),
(40, 1, 'DOC7', 'CBSE Assessment Circular 2026', 'Circulars', '2025-03-13', 'TXT', 'Ministry of Education', 'ï¿½ï¿½fï¿½This official circular outlines the new assessment and evaluation pattern for Class X and XII Board examinations scheduled for the academic session 2025-26. It introduces more competency-based questions that test the application of concepts in real-life situations. The weightage for traditional rote-learning based questions has been reduced in favor of case-study and assertion-reasoning type questions to align with NEP 2020 g', 'oals.Document ID: DOC7\n\nTitle: CBSE Assessment Circular 2026\n\nCategory: Circulars\n\nDepartment: CBSE\n\nDescription:\nThis official circular outlines the new assessment and evaluation pattern for Class X and XII Board examinations scheduled for the academic session 2025-26. It introduces more competency-based questions that test the application of concepts in real-life situations. The weightage for traditional rote-learning based questions has been reduced in favor of case-study and assertion-reasoning type questions to align with NEP 2020 goals.\n\nEligibility:\n- All schools affiliated with CBSE\n- Students appearing for Board Exams in 2026\n- Teachers and examiners involved in school-based assessments\n\nBenefits:\n- Shift from rote learning to conceptual understanding\n- Better preparation for competitive entrance exams\n- Transparent and fair evaluation bench', '2026-04-01 09:32:34'),
(42, 1, 'DOC22', 'AICTE Idea Lab Establishment', 'Guidelines', '2025-03-13', 'TXT', 'Ministry of Education', 'ï¿½ï¿½hï¿½IThese guidelines explain the procedure for setting up an \'AICTE IDEA (Idea Development, Evaluation & Application) Lab\' in technical institutions. The lab is meant to encourage students to apply science, technology, engineering and mathematics (STEM) fundamentals towards solving real-life problems. It provides a platform for students to work on projects that lead to prototypes, patents, and startups. The document outlines the equipment list, space requirements, and the funding pattern from A', 'ICTE.Document ID: DOC22\n\nTitle: AICTE Idea Lab Establishment\n\nCategory: Guidelines\n\nDepartment: AICTE\n\nDescription:\nThese guidelines explain the procedure for setting up an \'AICTE IDEA (Idea Development, Evaluation & Application) Lab\' in technical institutions. The lab is meant to encourage students to apply science, technology, engineering and mathematics (STEM) fundamentals towards solving real-life problems. It provides a platform for students to work on projects that lead to prototypes, patents, and startups. The document outlines the equipment list, space requirements, and the funding pattern from AICTE.\n\nEligibility:\n- AICTE approved institutions with at least 10 years standing\n- Availability of 3000 sq ft space for the lab\n- Commitment of matching funds from the institution\n\nBenefits:\n- Grant of Rs. 15 Lakhs for lab equipment\n- Access to specialized training and mentorship programs\n- Recognition as a hub for innovation and entrepreneu', '2026-04-02 18:20:36'),
(43, 5, 'DOC9', 'Mid-Day Meal (PM-POSHAN) Rules', 'Schemes', '2025-03-13', 'TXT', 'Ministry of Education', 'The PM-POSHAN (Pradhan Mantri Poshan Shakti Nirman) Scheme provides a hot cooked meal to children in government and government-aided schools. These updated 2025 rules focus on the nutritional quality of the meals, emphasizing the inclusion of millets, fresh vegetables, and fortifying ingredients. The policy also mandates regular social audits and the involvement of School Management Committees (SMCs) in monitoring the daily cooking process and hygiene standards.', 'Document ID: DOC9\n\nTitle: Mid-Day Meal (PM-POSHAN) Rules\n\nCategory: Schemes\n\nDepartment: Department of School Education\n\nDescription:\nThe PM-POSHAN (Pradhan Mantri Poshan Shakti Nirman) Scheme provides a hot cooked meal to children in government and government-aided schools. These updated 2025 rules focus on the nutritional quality of the meals, emphasizing the inclusion of millets, fresh vegetables, and fortifying ingredients. The policy also mandates regular social audits and the involvement of School Management Committees (SMCs) in monitoring the daily cooking process and hygiene standards.\n\nEligibility:\n- Children in Classes I-VIII in government schools\n- Specific focus on Aspirational Districts\n- Implementation through local self-help groups (SHGs)\n\nBenefits:\n- Improved nutritional status and health of school-going children\n- Increased enrollment and retention rates in primary schools\n- Employment creation for local women in cooking centers', '2026-04-02 22:30:17'),
(44, 5, 'DOC11', 'Kendriya Vidyalaya Admission Policy', 'Policies', '2025-03-13', 'TXT', 'Ministry of Education', 'The KVS Admission Guidelines govern the entrance of students into Kendriya Vidyalayas across India and abroad. It prioritizes the children of transferable central government employees, defense personnel, and employees of autonomous bodies. The policy outlines the quota system, including SC/ST/OBC and Single Girl Child reservations. It also specifies the age criteria for Class I and the procedure for lateral entry in higher classes based on availability of seats.', 'Document ID: DOC11\n\nTitle: Kendriya Vidyalaya Admission Policy\n\nCategory: Policies\n\nDepartment: KVS\n\nDescription:\nThe KVS Admission Guidelines govern the entrance of students into Kendriya Vidyalayas across India and abroad. It prioritizes the children of transferable central government employees, defense personnel, and employees of autonomous bodies. The policy outlines the quota system, including SC/ST/OBC and Single Girl Child reservations. It also specifies the age criteria for Class I and the procedure for lateral entry in higher classes based on availability of seats.\n\nEligibility:\n- Children of Central/State Govt. employees\n- Local residents under the specified distance criteria\n- Disadvantaged groups under Right to Education (RTE) Act\n\nBenefits:\n- Quality education at affordable fees across India\n- Common curriculum facilitating ease for transferable parents\n- Focus on holistic sports and cultural development', '2026-04-02 22:30:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `employee_id` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT 'Analyst',
  `is_2fa_enabled` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `employee_id`, `role`, `is_2fa_enabled`) VALUES
(1, 'Admin', 'admingoiretrieval@gmail.com', 'Admin@1234', 'EMP-2022-1234', 'Analyst', 0),
(2, 'Bhanu Latha', 'pbhanulatha@gmail.com', 'Pbhanulatha@123', 'EMP-2021-5678', 'Analyst', 0),
(4, 'Dharani', 'dharaninarasing25@gmail.com', 'Dharani@123', 'EMP-2020-9012', 'Analyst', 0),
(5, 'Devi Ramya', 'pokala.deviramya2713@gmail.com', 'Pokaladeviramya@1234', 'EMP-2023-2005', 'Analyst', 0),
(6, 'Sridhar', 'pokala.sridhar3241@gmail.com', 'Sridhar@123', 'EMP-2022-2317', 'Analyst', 0),
(7, 'Charitha', 'sscharithareddy@gmail.com', '1749138@S', 'EMP-2021-9138', 'Analyst', 0),
(10, 'lokesh', 'lokesh@gmail.com', 'Lokesh@123', 'EMP-2024-1234', 'Analyst', 0),
(11, 'Sunanda Vastrala', 'sunandavastrala@gmail.com', 'Sunanda@123', 'EMP-2022-7682', 'Analyst', 0),
(12, 'Tejaswini', 'mudesai09@gmail.com', 'Tejaswini@123', 'EMP-2020-6547', 'Analyst', 0),
(13, 'Sunita', 'sunithakagi291@gmail.com', 'Sunitha@1234', 'EMP-2021-2287', 'Analyst', 0),
(14, 'Test User', 'test@education.gov.in', 'password', 'GOI-123', 'Admin', 0),
(15, 'Cherry', 'saddaeaswaricharitha29@gmail.com', 'Cherry@1234', 'EMP-2020-4853', 'Senior Administrator', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_activities`
--

CREATE TABLE `user_activities` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activity_type` varchar(50) NOT NULL,
  `detail` text NOT NULL,
  `doc_id` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_activities`
--

INSERT INTO `user_activities` (`id`, `user_id`, `activity_type`, `detail`, `doc_id`, `created_at`) VALUES
(1, 1, 'View', 'Viewed \"National Fellowship for ST Students\"', 'DOC19', '2026-03-13 22:57:38'),
(2, 1, 'View', 'Viewed \"Mid-Day Meal (PM-POSHAN) Rules\"', 'DOC9', '2026-03-13 22:57:41'),
(3, 1, 'Download', 'Downloaded \"UGC Annual Accountability Report\"', 'DOC28', '2026-03-13 23:01:25'),
(4, 1, 'View', 'Viewed \"National Fellowship for ST Students\"', 'DOC19', '2026-03-14 20:54:26'),
(5, 1, 'View', 'Viewed \"National Education Policy 2020\"', 'DOC1', '2026-03-14 20:54:29'),
(6, 1, 'Download', 'Downloaded: Internal Research Report_Draft.pdf', NULL, '2026-03-15 14:33:03'),
(7, 1, 'AI Audit', 'Started audit for https://www.education.gov.in', NULL, '2026-03-15 14:42:09'),
(8, 1, 'Download', 'Full Organized PDF Downloaded: Internal Research Report_Draft.pdf', NULL, '2026-03-15 14:43:11'),
(9, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-23 09:30:09'),
(10, 1, 'AI Chat', 'Asked: hi !\nCan you please some rating to SIMATS Engineer...', NULL, '2026-03-23 09:31:01'),
(11, 1, 'AI Chat', 'Asked: How was hyderabad \'s Anirudh Concert night om Satu...', NULL, '2026-03-23 09:31:51'),
(12, 1, 'AI Chat', 'Asked: ok thank you\nI will ping you later ! Byee...', NULL, '2026-03-23 09:32:55'),
(22, 1, 'AI Audit', 'Started audit for https://www.education.gov.in', NULL, '2026-03-15 15:34:21'),
(23, 1, 'AI Audit', 'Started audit for https://www.education.gov.in', NULL, '2026-03-15 16:55:59'),
(24, 1, 'AI Audit', 'Started audit for https://www.education.gov.in', NULL, '2026-03-15 16:56:17'),
(25, 1, 'AI Audit', 'Started audit for https://www.scholarships.gov.in', NULL, '2026-03-15 19:49:58'),
(26, 1, 'AI Audit', 'Started audit for https://www.scholarships.gov.in', NULL, '2026-03-15 19:50:55'),
(27, 1, 'AI Audit', 'Started audit for https://www.scholarships.gov.in', NULL, '2026-03-15 19:50:58'),
(28, 1, 'AI Audit', 'Started audit for https://scholarships.gov.in', NULL, '2026-03-15 20:41:53'),
(29, 1, 'AI Audit', 'Started audit for https://scholarships.gov.in', NULL, '2026-03-15 20:45:30'),
(30, 1, 'AI Audit', 'Started audit for https://scholarships.gov.in', NULL, '2026-03-15 21:07:27'),
(31, 1, 'AI Chat', 'Started new chat session', NULL, '2026-03-15 21:08:54'),
(32, 1, 'AI Audit', 'Started audit for https://scholarships.gov.in', NULL, '2026-03-15 21:15:31'),
(33, 1, 'AI Audit', 'Started audit for www.scholarships.gov.in', NULL, '2026-03-15 21:27:16'),
(34, 1, 'AI Audit', 'Started audit for www.scholarships.gov.in', NULL, '2026-03-15 21:30:12'),
(35, 1, 'AI Audit', 'Started audit for www.scholarships.gov.in', NULL, '2026-03-15 21:33:57'),
(36, 1, 'AI Audit', 'Started audit for www.scholarships.gov.in', NULL, '2026-03-15 21:39:06'),
(37, 1, 'AI Audit', 'Started audit for www.scholarships.gov.in', NULL, '2026-03-15 21:55:50'),
(38, 1, 'AI Audit', 'Started audit for www.scholarships.gov.in', NULL, '2026-03-15 22:09:40'),
(39, 1, 'AI Audit', 'Started audit for www.scholarships.gov.in', NULL, '2026-03-15 23:03:58'),
(40, 1, 'AI Audit', 'Started audit for www.scholarships.gov.in', NULL, '2026-03-15 23:12:48'),
(41, 1, 'AI Audit', 'Started audit for www.scholarships.gov.in', NULL, '2026-03-15 23:16:17'),
(42, 1, 'AI Audit', 'Started audit for www.scholarships.gov.in', NULL, '2026-03-15 23:16:28'),
(43, 1, 'AI Audit', 'Started audit for www.scholarships.gov.in', NULL, '2026-03-15 23:17:11'),
(44, 1, 'Download', 'Downloaded \"Prime Minister\'s Research Fellowship\"', 'DOC8', '2026-03-15 23:24:57'),
(45, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 09:39:17'),
(46, 1, 'AI Audit Success', 'Processed 0 files', NULL, '2026-03-16 09:39:19'),
(47, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 09:50:30'),
(48, 1, 'AI Audit Success', 'Processed 0 files', NULL, '2026-03-16 09:50:32'),
(49, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 09:59:10'),
(50, 1, 'AI Audit Success', 'Processed 0 files', NULL, '2026-03-16 09:59:15'),
(51, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 09:59:38'),
(52, 1, 'AI Audit Success', 'Processed 0 files', NULL, '2026-03-16 09:59:39'),
(53, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 10:12:38'),
(54, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 10:13:19'),
(55, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 10:15:39'),
(56, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 10:19:32'),
(57, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 10:20:06'),
(58, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 10:22:53'),
(59, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 10:43:17'),
(60, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-16 10:43:31'),
(61, 1, 'Download', 'Downloaded PDF: Ministry of Education Digital Infrastructure Grant Guidelines - Phase 3 (Presumed)', 'MOE_GRANT_SCHEME_PHASE3', '2026-03-16 10:44:41'),
(62, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 10:48:35'),
(63, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-16 10:48:42'),
(64, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 10:52:35'),
(65, 1, 'AI Audit Success', 'Processed 4 files', NULL, '2026-03-16 10:53:03'),
(66, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 12:42:30'),
(67, 1, 'AI Audit Success', 'Processed 0 files', NULL, '2026-03-16 12:42:40'),
(68, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 12:42:57'),
(69, 1, 'AI Audit Success', 'Processed 4 files', NULL, '2026-03-16 12:43:16'),
(70, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 12:46:53'),
(71, 1, 'AI Audit Success', 'Processed 4 files', NULL, '2026-03-16 12:47:03'),
(72, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 12:49:00'),
(73, 1, 'AI Audit Success', 'Processed 4 files', NULL, '2026-03-16 12:49:08'),
(74, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-16 12:55:59'),
(75, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 13:03:54'),
(76, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-16 13:04:04'),
(77, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 13:06:21'),
(78, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-16 13:06:38'),
(79, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 13:11:32'),
(80, 1, 'AI Audit Success', 'Processed 2 files', NULL, '2026-03-16 13:11:42'),
(81, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-16 13:19:08'),
(82, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-16 13:19:21'),
(83, 1, 'Download', 'Downloaded PDF: Samagra Shiksha Abhiyan - Infrastructure Grant Guidelines', 'UNPACKED_DOC_1', '2026-03-16 13:20:08'),
(84, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-03-16 13:37:46'),
(85, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-16 13:37:57'),
(86, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-16 13:54:38'),
(87, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-16 13:54:55'),
(88, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-17 10:15:25'),
(89, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-17 10:15:41'),
(90, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-17 10:16:44'),
(91, 1, 'AI Audit Success', 'Processed 2 files', NULL, '2026-03-17 10:16:52'),
(92, 1, 'AI Chat', 'Asked: What is the National Education Policy 2020?...', NULL, '2026-03-18 08:48:42'),
(93, 1, 'AI Chat', 'Asked: whare the key pillars of NEP 2020...', NULL, '2026-03-18 09:26:39'),
(94, 1, 'AI Chat', 'Asked: Is there any scholarship for Sports quota ?...', NULL, '2026-03-18 09:27:40'),
(95, 1, 'AI Chat', 'Asked: Hello! Who are you and what can you do?...', NULL, '2026-03-18 09:29:53'),
(96, 1, 'AI Chat', 'Asked: Hello! Who are you and what can you do?...', NULL, '2026-03-18 09:30:43'),
(97, 1, 'AI Chat', 'Asked: what are the key points of NEP 2020?...', NULL, '2026-03-18 09:32:56'),
(98, 1, 'AI Chat', 'Asked: Is there any scholarship for OC category students ...', NULL, '2026-03-18 09:44:34'),
(99, 1, 'AI Chat', 'Asked: How can I register for NPTEL ?...', NULL, '2026-03-18 09:45:54'),
(100, 1, 'AI Chat', 'Asked: What to do if I fail in my JEE Mains 2026 1st phas...', NULL, '2026-03-18 09:51:12'),
(101, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-18 09:53:27'),
(102, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-18 09:53:45'),
(103, 1, 'View', 'Viewed Student Innovation Scheme DOC301', '6', '2026-03-19 12:29:10'),
(104, 1, 'Unsave', 'Unsaved document 6', '6', '2026-03-19 12:29:12'),
(105, 1, 'Unsave', 'Unsaved document 5', '5', '2026-03-19 12:29:13'),
(106, 1, 'Unsave', 'Unsaved document 4', '4', '2026-03-19 12:29:15'),
(107, 1, 'Unsave', 'Unsaved document 4', '4', '2026-03-19 12:29:21'),
(108, 1, 'Unsave', 'Unsaved document 5', '5', '2026-03-19 12:29:22'),
(109, 1, 'Unsave', 'Unsaved document 6', '6', '2026-03-19 12:29:23'),
(110, 1, 'View', 'Viewed Higher Education Infrastructure Project DOC503', '4', '2026-03-19 12:34:39'),
(111, 1, 'Unsave', 'Unsaved document 4', '4', '2026-03-19 12:34:42'),
(112, 1, 'View', 'Viewed Faculty Development Program DOC313', '5', '2026-03-19 12:34:43'),
(113, 1, 'Unsave', 'Unsaved document 5', '5', '2026-03-19 12:34:44'),
(114, 1, 'Unsave', 'Unsaved document 6', '6', '2026-03-19 12:34:46'),
(115, 1, 'Unsave', 'Unsaved document 6', '6', '2026-03-19 12:34:52'),
(116, 1, 'Unsave', 'Unsaved document 5', '5', '2026-03-19 12:34:53'),
(117, 1, 'Unsave', 'Unsaved document 4', '4', '2026-03-19 12:34:54'),
(118, 1, 'Unsave', 'Unsaved document 6', '6', '2026-03-19 12:39:10'),
(119, 1, 'Save', 'Saved UGC Quality Mandate Circular', 'DOC25', '2026-03-19 12:46:48'),
(120, 1, 'View', 'Viewed National Education Policy 2020', 'DOC1', '2026-03-19 12:46:52'),
(121, 1, 'View', 'Viewed Research Grant Policy', 'DOC2', '2026-03-19 12:46:55'),
(122, 1, 'Unsave', 'Unsaved document 6', '6', '2026-03-19 13:02:52'),
(123, 1, 'Unsave', 'Unsaved document 5', '5', '2026-03-19 13:02:53'),
(124, 1, 'Unsave', 'Unsaved document 4', '4', '2026-03-19 13:02:54'),
(125, 1, 'Unsave', 'Unsaved document 6', '6', '2026-03-19 13:03:00'),
(126, 1, 'Unsave', 'Unsaved document 5', '5', '2026-03-19 13:03:01'),
(127, 1, 'Unsave', 'Unsaved document 4', '4', '2026-03-19 13:03:02'),
(128, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(129, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(130, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(131, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(132, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(133, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(134, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(135, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(136, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(137, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(138, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(139, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(140, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(141, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(142, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(143, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(144, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(145, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(146, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(147, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(148, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-16 10:00:00'),
(149, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(150, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(151, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(152, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(153, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(154, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(155, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-19 13:34:56'),
(177, 2, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(178, 2, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(179, 2, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(180, 2, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(181, 2, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(182, 2, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(204, 4, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(205, 4, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(206, 4, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(207, 4, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(208, 4, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(209, 4, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(231, 5, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(232, 5, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(233, 5, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(234, 5, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(235, 5, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(236, 5, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(258, 6, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(259, 6, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(260, 6, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(261, 6, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(262, 6, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(263, 6, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(285, 7, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(286, 7, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(287, 7, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-17 10:00:00'),
(288, 7, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(289, 7, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(290, 7, 'AI Audit', 'Performed AI Audit analysis', NULL, '2026-03-18 10:00:00'),
(318, 1, 'Unsave', 'Unsaved document 5', '5', '2026-03-19 14:01:15'),
(319, 1, 'Unsave', 'Unsaved document 5', '5', '2026-03-19 14:01:20'),
(320, 1, 'AI Chat', 'Asked: hey do you know which grade does SIMATS Engineerin...', NULL, '2026-03-19 14:15:11'),
(321, 1, 'Save', 'Saved Anti-Ragging Guidelines 2025', 'DOC3', '2026-03-19 14:34:42'),
(322, 1, 'Save', 'Saved Anti-Ragging Guidelines 2025', 'DOC3', '2026-03-19 14:34:42'),
(323, 1, 'View', 'Viewed PM-SHRI Schools Framework', 'DOC5', '2026-03-19 14:34:44'),
(324, 1, 'Save', 'Saved Pragati Scholarship for Girls', 'DOC4', '2026-03-19 14:34:46'),
(325, 1, 'Save', 'Saved Pragati Scholarship for Girls', 'DOC4', '2026-03-19 14:34:46'),
(326, 1, 'Unsave', 'Unsaved document DOC3', 'DOC3', '2026-03-19 14:34:49'),
(327, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-19 14:35:00'),
(328, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-19 14:35:00'),
(329, 1, 'View', 'Viewed Prime Minister\'s Research Fellowship', 'DOC8', '2026-03-19 14:36:22'),
(330, 1, 'View', 'Viewed CBSE Assessment Circular 2026', 'DOC7', '2026-03-19 14:43:33'),
(331, 1, 'Save', 'Saved NPTEL Course Recognition Rules', 'DOC26', '2026-03-19 14:47:55'),
(332, 1, 'Save', 'Saved NPTEL Course Recognition Rules', 'DOC26', '2026-03-19 14:47:55'),
(333, 1, 'View', 'Viewed NPTEL Course Recognition Rules', 'DOC26', '2026-03-19 14:47:55'),
(334, 1, 'View', 'Viewed AICTE Approval Handbook 2024-27', 'DOC12', '2026-03-19 14:47:58'),
(335, 1, 'View', 'Viewed KV Teacher Transfer Policy 2026', 'DOC20', '2026-03-19 14:48:00'),
(336, 1, 'View', 'Viewed CBSE Assessment Circular 2026', 'DOC7', '2026-03-19 14:48:03'),
(337, 1, 'Save', 'Saved CBSE Assessment Circular 2026', 'DOC7', '2026-03-19 14:48:06'),
(338, 1, 'Save', 'Saved CBSE Assessment Circular 2026', 'DOC7', '2026-03-19 14:48:06'),
(339, 1, 'Save', 'Saved National Fellowship for ST Students', 'DOC19', '2026-03-20 08:33:01'),
(340, 1, 'Save', 'Saved National Fellowship for ST Students', 'DOC19', '2026-03-20 08:33:01'),
(341, 1, 'View', 'Viewed AICTE Idea Lab Establishment', 'DOC22', '2026-03-20 08:33:08'),
(342, 1, 'View', 'Viewed AICTE Idea Lab Establishment', 'DOC22', '2026-03-20 08:33:09'),
(343, 1, 'Save', 'Saved AICTE Idea Lab Establishment', 'DOC22', '2026-03-20 08:33:11'),
(344, 1, 'Save', 'Saved AICTE Idea Lab Establishment', 'DOC22', '2026-03-20 08:33:11'),
(345, 1, 'AI Chat', 'Asked: Hey!\nWhen JEE Mains results 2026 released ?...', NULL, '2026-03-20 08:34:36'),
(346, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-20 08:37:14'),
(347, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-20 08:37:24'),
(348, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-20 08:37:38'),
(349, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-20 08:54:14'),
(350, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 08:54:35'),
(351, 1, 'AI Audit Success', 'Processed 5 files', NULL, '2026-03-20 08:54:36'),
(352, 1, 'Download', 'Downloaded PDF: NEP Digital Infrastructure Funding Guidelines 2025', 'DOC_1', '2026-03-20 08:55:21'),
(353, 1, 'AI Audit', 'Started CONFLICT audit for 2 files', NULL, '2026-03-20 09:01:05'),
(354, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 09:01:24'),
(355, 1, 'AI Audit Success', 'Processed 2 files', NULL, '2026-03-20 09:01:24'),
(356, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-20 09:06:08'),
(357, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 09:06:24'),
(358, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-20 09:06:25'),
(359, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 09:09:52'),
(360, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-20 09:09:53'),
(361, 1, 'AI Chat', 'Asked: hey !\nHow are placements in SSN college tamilnadu ...', NULL, '2026-03-20 09:18:20'),
(362, 1, 'AI Chat', 'Asked: I think this college closed admissions for 2026 ba...', NULL, '2026-03-20 09:19:17'),
(367, 1, 'View', 'Viewed Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-20 12:40:37'),
(368, 1, 'View', 'Viewed AICTE Approval Handbook 2024-27', 'DOC12', '2026-03-20 12:40:40'),
(369, 1, 'View', 'Viewed Anti-Ragging Guidelines 2025', 'DOC3', '2026-03-20 12:40:43'),
(370, 1, 'Save', 'Saved Anti-Ragging Guidelines 2025', 'DOC3', '2026-03-20 12:40:46'),
(371, 1, 'Save', 'Saved Anti-Ragging Guidelines 2025', 'DOC3', '2026-03-20 12:40:46'),
(372, 1, 'Unsave', 'Unsaved document DOC22', 'DOC22', '2026-03-20 12:40:53'),
(373, 1, 'Unsave', 'Unsaved document DOC19', 'DOC19', '2026-03-20 12:40:54'),
(374, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-20 12:42:01'),
(375, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 12:42:18'),
(376, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-20 12:42:18'),
(377, 1, 'AI Audit', 'Started CONFLICT audit for 2 files', NULL, '2026-03-20 12:42:52'),
(378, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 12:43:09'),
(379, 1, 'AI Audit Success', 'Processed 2 files', NULL, '2026-03-20 12:43:09'),
(380, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 13:31:47'),
(381, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 13:32:02'),
(382, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 13:32:32'),
(383, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 13:32:48'),
(384, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 13:33:04'),
(385, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 13:33:20'),
(386, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 13:33:35'),
(387, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 13:33:52'),
(388, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 13:34:07'),
(389, 1, 'AI Chat', 'Asked: Tell me aout NEP 2020...', NULL, '2026-03-20 13:35:27'),
(390, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 13:58:22'),
(391, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 13:58:38'),
(392, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 14:01:11'),
(393, 1, 'Audit', 'Performed AI Audit analysis', NULL, '2026-03-20 14:01:26'),
(394, 1, 'AI Chat', 'Asked: Tell me about NEP 2020?...', NULL, '2026-03-20 14:02:15'),
(395, 1, 'AI Chat', 'Asked: whats the publics review on simats engineering...', NULL, '2026-03-20 14:09:13'),
(396, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-28 20:59:57'),
(397, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-28 20:59:57'),
(398, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-28 20:59:57'),
(399, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-28 20:59:57'),
(400, 1, 'View', 'Viewed National Fellowship for ST Students', 'DOC19', '2026-03-28 21:29:54'),
(401, 1, 'Save', 'Saved National Fellowship for ST Students', 'DOC19', '2026-03-28 21:29:56'),
(402, 1, 'Unsave', 'Unsaved document DOC19', 'DOC19', '2026-03-28 21:30:03'),
(403, 1, 'View', 'Viewed Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-28 21:30:03'),
(404, 1, 'Unsave', 'Unsaved document DOC9', 'DOC9', '2026-03-28 21:30:05'),
(405, 1, 'Unsave', 'Unsaved document DOC3', 'DOC3', '2026-03-28 21:30:06'),
(406, 1, 'Unsave', 'Unsaved document DOC7', 'DOC7', '2026-03-28 21:30:06'),
(407, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-28 21:33:28'),
(408, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-28 21:48:26'),
(409, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-28 21:56:22'),
(410, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-28 22:04:05'),
(411, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-28 22:11:19'),
(412, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-28 22:20:48'),
(413, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-28 22:24:12'),
(414, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-28 22:31:17'),
(415, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-28 22:31:53'),
(416, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-28 22:54:11'),
(417, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-28 22:54:56'),
(418, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-03-28 22:55:40'),
(419, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-28 22:56:19'),
(420, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-28 22:57:37'),
(421, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-28 22:58:09'),
(422, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-29 14:20:23'),
(423, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-29 14:20:56'),
(424, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-03-29 14:23:09'),
(425, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-29 14:23:43'),
(426, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-29 14:28:00'),
(427, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-29 14:28:31'),
(428, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-03-29 14:31:16'),
(429, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-29 14:31:48'),
(430, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-29 14:33:03'),
(431, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-29 14:33:35'),
(432, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-29 15:12:39'),
(433, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-29 15:12:54'),
(434, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-29 15:13:08'),
(435, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-29 15:20:31'),
(436, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-29 15:36:39'),
(437, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-29 15:37:13'),
(438, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-03-29 15:38:25'),
(439, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-29 15:39:01'),
(440, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-03-29 15:39:58'),
(441, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-29 15:40:42'),
(442, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-29 15:41:05'),
(443, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-29 15:41:40'),
(444, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-29 15:41:54'),
(445, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-29 15:42:31'),
(446, 1, 'AI Chat', 'Asked: hey how is prabhudevas performance at rec chennai ...', NULL, '2026-03-29 15:44:07'),
(447, 1, 'AI Chat', 'Asked: then how is anirudh\'s concert on march 21st in hyd...', NULL, '2026-03-29 15:45:08'),
(448, 1, 'AI Chat', 'Asked: whats the fee structure of SIMATS Engineering 2026...', NULL, '2026-03-29 16:50:08'),
(449, 1, 'AI Chat', 'Asked: What is the fee structure of SIMATS Engineering fo...', NULL, '2026-03-29 17:00:24'),
(450, 1, 'AI Chat', 'Asked: i got 83 percentile as OC  student inn JEE Mains 2...', NULL, '2026-03-29 17:01:37'),
(451, 1, 'AI Chat', 'Asked: hi...', NULL, '2026-03-29 17:02:02'),
(452, 1, 'AI Chat', 'Asked: i am devi ramya...', NULL, '2026-03-29 17:02:22'),
(453, 1, 'AI Chat', 'Asked: i got 83 percentile as OC student in JEE Mains 202...', NULL, '2026-03-29 17:06:45'),
(454, 1, 'AI Chat', 'Asked: can you please provide eligibility information for...', NULL, '2026-03-29 17:07:48'),
(455, 1, 'AI Chat', 'Asked: how to join in SIMATS Engineering? is there any ex...', NULL, '2026-03-29 17:08:52'),
(456, 1, 'AI Chat', 'Asked: ok thank you...', NULL, '2026-03-29 17:09:39'),
(457, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-29 22:53:50'),
(458, 1, 'AI Audit Success', 'Processed 3 files', NULL, '2026-03-29 22:54:16'),
(459, 1, 'AI Audit', 'Started CONFLICT audit for 2 files', NULL, '2026-03-29 23:05:59'),
(460, 1, 'AI Audit Success', 'Processed 2 files', NULL, '2026-03-29 23:07:01'),
(461, 1, 'AI Audit', 'Started CONFLICT audit for 2 files', NULL, '2026-03-29 23:07:45'),
(462, 1, 'AI Audit Success', 'Processed 2 files', NULL, '2026-03-29 23:08:48'),
(463, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-29 23:14:41'),
(464, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-29 23:15:42'),
(465, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-30 09:29:41'),
(466, 1, 'View', 'Viewed PM-POSHAN Monitoring Report 2025', 'DOC27', '2026-03-30 09:29:47'),
(467, 1, 'AI Audit', 'Started CONFLICT audit for 2 files', NULL, '2026-03-30 09:33:01'),
(468, 1, 'AI Audit Success', 'Processed 2 files', NULL, '2026-03-30 09:33:24'),
(469, 1, 'AI Audit', 'Started CONFLICT audit for 2 files', NULL, '2026-03-30 10:21:08'),
(470, 1, 'AI Audit Success', 'Processed 2 files', NULL, '2026-03-30 10:21:37'),
(471, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-30 10:22:36'),
(472, 1, 'AI Audit Success', 'Processed 1 files', NULL, '2026-03-30 10:23:31'),
(473, 1, 'Save', 'Saved National Fellowship for ST Students', 'DOC19', '2026-03-30 10:24:19'),
(474, 1, 'View', 'Viewed PM-POSHAN Monitoring Report 2025', 'DOC27', '2026-03-30 10:24:24'),
(475, 1, 'View', 'Viewed NPTEL Course Recognition Rules', 'DOC26', '2026-03-30 10:24:31'),
(476, 1, 'View', 'Viewed AICTE Approval Handbook 2024-27', 'DOC12', '2026-03-30 10:24:38'),
(477, 1, 'View', 'Viewed AICTE Idea Lab Establishment', 'DOC22', '2026-03-30 10:24:41'),
(478, 1, 'Download', 'Downloaded \"National NIRF Rankings Summary 2024\"', 'DOC15', '2026-03-30 10:24:58'),
(479, 10, 'View', 'Viewed National Fellowship for ST Students', 'DOC19', '2026-03-30 10:40:58'),
(480, 10, 'View', 'Viewed National Fellowship for ST Students', 'DOC19', '2026-03-30 10:41:16'),
(481, 10, 'View', 'Viewed Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-30 10:41:25'),
(482, 1, 'View', 'Viewed AICTE Idea Lab Establishment', 'DOC22', '2026-03-30 20:58:45'),
(483, 1, 'View', 'Viewed PM-POSHAN Monitoring Report 2025', 'DOC27', '2026-03-30 20:58:48'),
(484, 1, 'View', 'Viewed AICTE Idea Lab Establishment', 'DOC22', '2026-03-30 22:58:19'),
(485, 1, 'Save', 'Saved CBSE Assessment Circular 2026', 'DOC7', '2026-03-30 22:58:25'),
(486, 1, 'Save', 'Saved PM-POSHAN Monitoring Report 2025', 'DOC27', '2026-03-31 08:41:07'),
(487, 1, 'Unsave', 'Unsaved document DOC9', 'DOC9', '2026-03-31 08:41:11'),
(488, 1, 'Unsave', 'Unsaved document DOC26', 'DOC26', '2026-03-31 08:41:12'),
(489, 1, 'Search', 'Searched for \"UGC\"', NULL, '2026-03-31 09:30:11'),
(490, 1, 'Save', 'Saved National Fellowship for ST Students', 'DOC19', '2026-03-31 09:36:57'),
(491, 1, 'Save', 'Saved National Fellowship for ST Students', 'DOC19', '2026-03-31 09:37:08'),
(492, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-31 09:43:29'),
(493, 1, 'Unsave', 'Unsaved document DOC22', 'DOC22', '2026-03-31 09:43:34'),
(494, 1, 'Unsave', 'Unsaved document DOC27', 'DOC27', '2026-03-31 09:43:37'),
(495, 1, 'Unsave', 'Unsaved document DOC9', 'DOC9', '2026-03-31 09:43:41'),
(496, 1, 'Unsave', 'Unsaved document DOC19', 'DOC19', '2026-03-31 09:43:42'),
(497, 1, 'View', 'Viewed CBSE Assessment Circular 2026', 'DOC7', '2026-03-31 09:43:45'),
(498, 1, 'Unsave', 'Unsaved document DOC7', 'DOC7', '2026-03-31 09:43:48'),
(499, 1, 'Save', 'Saved AICTE Approval Handbook 2024-27', 'DOC12', '2026-03-31 09:43:50'),
(500, 1, 'Save', 'Saved Anti-Ragging Guidelines 2025', 'DOC3', '2026-03-31 09:43:52'),
(501, 1, 'Search', 'Searched for \"anti \"', NULL, '2026-03-31 09:43:58'),
(502, 1, 'Search', 'Searched for \"anti\"', NULL, '2026-03-31 09:44:00'),
(503, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-31 09:47:15'),
(504, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-31 09:47:15'),
(505, 1, 'Download', 'Downloaded \"National NIRF Rankings Summary 2024\"', 'DOC15', '2026-03-31 09:48:49'),
(506, 1, 'View', 'Viewed Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-31 10:19:43'),
(507, 1, 'AI Audit', 'Started CONFLICT audit for 2 files', NULL, '2026-03-31 10:20:11'),
(508, 1, 'AI Audit', 'Completed audit for 2 files with 83% avg. score', NULL, '2026-03-31 10:20:14'),
(509, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-31 10:20:59'),
(510, 1, 'AI Audit', 'Completed audit for 1 files with 72% avg. score', NULL, '2026-03-31 10:21:02'),
(511, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-31 10:28:51'),
(512, 1, 'AI Audit', 'Completed audit for 1 files with 81% avg. score', NULL, '2026-03-31 10:28:54'),
(513, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-31 10:42:51'),
(514, 1, 'AI Audit', 'Completed audit for 1 files with 75% avg. score', NULL, '2026-03-31 10:42:54'),
(515, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-31 12:16:08'),
(516, 1, 'AI Audit', 'Audited 1 regulatory segments (SCENARIO Mode)', NULL, '2026-03-31 12:16:50'),
(517, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-31 12:16:50'),
(518, 1, 'AI Audit', 'Completed SCENARIO audit for 1 segments', NULL, '2026-03-31 12:17:22'),
(519, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-03-31 15:33:48'),
(520, 1, 'AI Audit', 'Audited 3 regulatory segments (CONFLICT Mode)', NULL, '2026-03-31 15:34:24'),
(521, 1, 'AI Audit', 'Completed CONFLICT audit for 3 segments', NULL, '2026-03-31 15:34:25'),
(522, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-31 15:40:11'),
(523, 1, 'AI Audit', 'Audited 3 regulatory segments (GAP Mode)', NULL, '2026-03-31 15:40:43'),
(524, 1, 'AI Audit', 'Completed GAP audit for 3 segments', NULL, '2026-03-31 15:40:43'),
(525, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-03-31 15:41:00'),
(526, 1, 'AI Audit', 'Audited 3 regulatory segments (CONFLICT Mode)', NULL, '2026-03-31 15:41:33'),
(527, 1, 'AI Audit', 'Completed CONFLICT audit for 3 segments', NULL, '2026-03-31 15:41:33'),
(528, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-31 15:49:12'),
(529, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-03-31 15:49:33'),
(530, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-03-31 15:49:33'),
(531, 1, 'Download', 'Generated Audit PDF: NEW SCHEME ON RURAL EDUCATION (2025)', 'DOC_1', '2026-03-31 15:50:00'),
(532, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-03-31 15:51:27'),
(533, 1, 'AI Audit', 'Audited 1 regulatory segments (CONFLICT Mode)', NULL, '2026-03-31 15:51:56'),
(534, 1, 'AI Audit', 'Completed CONFLICT audit for 1 segments', NULL, '2026-03-31 15:51:56'),
(535, 1, 'Download', 'Generated Audit PDF: HOSTEL ADMISSION RULES 2024', 'DOC_1', '2026-03-31 15:52:13'),
(536, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-31 15:55:47'),
(537, 1, 'AI Audit', 'Audited 1 regulatory segments (GAP Mode)', NULL, '2026-03-31 15:56:22'),
(538, 1, 'AI Audit', 'Completed GAP audit for 1 segments', NULL, '2026-03-31 15:56:22'),
(539, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-31 15:59:11'),
(540, 1, 'AI Audit', 'Audited 1 regulatory segments (GAP Mode)', NULL, '2026-03-31 15:59:38'),
(541, 1, 'AI Audit', 'Completed GAP audit for 1 segments', NULL, '2026-03-31 15:59:39'),
(542, 1, 'Download', 'Generated Audit PDF: Laboratory Safety Protocols (Draft)', 'DOC_1', '2026-03-31 15:59:55'),
(543, 1, 'Save', 'Saved NPTEL Course Recognition Rules', 'DOC26', '2026-03-31 16:03:13'),
(544, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-03-31 16:03:33'),
(545, 1, 'AI Audit', 'Audited 1 regulatory segments (GAP Mode)', NULL, '2026-03-31 16:04:07'),
(546, 1, 'AI Audit', 'Completed GAP audit for 1 segments', NULL, '2026-03-31 16:04:08'),
(547, 1, 'Download', 'Generated Audit PDF: Laboratory Safety Protocols (Draft)', 'DOC_1', '2026-03-31 16:06:44'),
(548, 1, 'Download', 'Downloaded \"NIRF 2024 Ranking Report\"', 'DOC2', '2026-03-31 20:20:17'),
(549, 1, 'View', 'Opened official report: NIRF 2024 Ranking Report', NULL, '2026-03-31 20:30:32'),
(550, 1, 'View', 'Opened official report: AISHE 2021-22 Final Report', NULL, '2026-03-31 20:30:49'),
(551, 1, 'View', 'Opened official report: NIRF 2024 Ranking Report', NULL, '2026-03-31 20:33:16'),
(552, 1, 'View', 'Opened official report: PM-POSHAN Annual Report 2023', NULL, '2026-03-31 20:33:20'),
(553, 1, 'View', 'Opened official report: NIRF 2024 Ranking Report', NULL, '2026-03-31 20:34:25'),
(554, 1, 'View', 'Opened official report: NIRF 2024: National Ranking Report', 'DOC2', '2026-03-31 20:58:11'),
(555, 1, 'View', 'Opened official report: UGC Annual Accountability Report 2022-23', 'DOC28', '2026-03-31 20:59:03'),
(556, 1, 'View', 'Opened official report: PM-POSHAN (Mid-Day Meal) Report 2023', 'DOC27', '2026-03-31 20:59:19'),
(557, 1, 'View', 'Opened official report: NILP Adult Education Official Guidelines', 'DOC30', '2026-03-31 20:59:22'),
(558, 1, 'View', 'Opened official report: NIRF 2024: National Ranking Report', 'DOC2', '2026-03-31 21:14:49'),
(559, 1, 'View', 'Opened official report: PM-POSHAN (Mid-Day Meal) Report 2023', 'DOC27', '2026-03-31 21:14:59'),
(560, 1, 'View', 'Opened official report: NIRF 2024: Consolidated Official Report', 'DOC15', '2026-03-31 21:15:58'),
(561, 1, 'View', 'Opened official report: NIRF 2024: National Ranking Report', 'DOC2', '2026-03-31 21:16:16'),
(562, 1, 'View', 'Opened official report: NIRF 2024: National Ranking Report', 'DOC2', '2026-03-31 21:18:12'),
(563, 1, 'View', 'Opened official report: UGC Annual Accountability Report 2022-23', 'DOC28', '2026-03-31 21:22:26'),
(564, 1, 'View', 'Opened official report: NILP Adult Education Official Guidelines', 'DOC30', '2026-03-31 21:23:06'),
(565, 1, 'View', 'Opened official report: NIRF 2024: National Ranking Report', 'DOC2', '2026-03-31 21:29:23'),
(566, 1, 'View', 'Opened official report: AISHE 2021-22: Final Statistical Report', 'DOC8', '2026-03-31 21:29:41'),
(567, 1, 'View', 'Opened official report: NIRF 2024: Consolidated Official Report', 'DOC15', '2026-03-31 21:30:04'),
(568, 1, 'View', 'Opened official report: PM-POSHAN (Mid-Day Meal) Report 2023', 'DOC27', '2026-03-31 21:30:29'),
(569, 1, 'AI Chat', 'Asked: hey i got 99 percentile in jee mains 2026..can you...', NULL, '2026-03-31 21:37:18'),
(570, 1, 'AI Chat', 'Asked: how was anirudh concert on march 21st...', NULL, '2026-03-31 21:38:12'),
(571, 1, 'Unsave', 'Unsaved document DOC26', 'DOC26', '2026-03-31 23:34:21'),
(572, 1, 'Save', 'Saved NPTEL Course Recognition Rules', 'DOC26', '2026-03-31 23:39:45'),
(573, 1, 'Unsave', 'Unsaved document DOC26', 'DOC26', '2026-03-31 23:40:08'),
(574, 1, 'Unsave', 'Unsaved document DOC9', 'DOC9', '2026-03-31 23:40:09'),
(575, 1, 'Unsave', 'Unsaved document DOC3', 'DOC3', '2026-03-31 23:40:10'),
(576, 1, 'Save', 'Saved National Fellowship for ST Students', 'DOC19', '2026-03-31 23:40:16'),
(577, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-03-31 23:40:17'),
(578, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-03-31 23:40:45'),
(579, 1, 'AI Audit', 'Audited 1 regulatory segments (SCENARIO Mode)', NULL, '2026-03-31 23:41:18'),
(580, 1, 'AI Audit', 'Completed SCENARIO audit for 1 segments', NULL, '2026-03-31 23:41:18'),
(581, 1, 'AI Chat', 'Asked: hey i am Btech graduate...i would like to to mtech...', NULL, '2026-03-31 23:42:10'),
(582, 1, 'User', 'Updated profile information', NULL, '2026-03-31 23:52:30'),
(583, 1, 'User', 'Updated profile information', NULL, '2026-03-31 23:52:38'),
(584, 1, 'Unsave', 'Unsaved document DOC9', 'DOC9', '2026-04-01 09:09:57'),
(585, 1, 'Save', 'Saved NPTEL Course Recognition Rules', 'DOC26', '2026-04-01 09:32:08'),
(586, 1, 'View', 'Viewed CBSE Assessment Circular 2026', 'DOC7', '2026-04-01 09:32:32'),
(587, 1, 'Save', 'Saved CBSE Assessment Circular 2026', 'DOC7', '2026-04-01 09:32:34'),
(588, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-01 09:33:03'),
(589, 1, 'AI Audit', 'Audited 1 regulatory segments (SCENARIO Mode)', NULL, '2026-04-01 09:33:21'),
(590, 1, 'AI Audit', 'Completed SCENARIO audit for 1 segments', NULL, '2026-04-01 09:33:22'),
(591, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-01 09:33:44'),
(592, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-04-01 09:34:04'),
(593, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-04-01 09:34:04'),
(594, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-04-01 09:34:42'),
(595, 1, 'AI Audit', 'Audited 1 regulatory segments (CONFLICT Mode)', NULL, '2026-04-01 09:35:10'),
(596, 1, 'AI Audit', 'Completed CONFLICT audit for 1 segments', NULL, '2026-04-01 09:35:10'),
(597, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-04-01 09:35:33'),
(598, 1, 'AI Audit', 'Audited 1 regulatory segments (GAP Mode)', NULL, '2026-04-01 09:36:04'),
(599, 1, 'AI Audit', 'Completed GAP audit for 1 segments', NULL, '2026-04-01 09:36:04'),
(600, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-04-01 09:36:13'),
(601, 1, 'AI Audit', 'Audited 1 regulatory segments (GAP Mode)', NULL, '2026-04-01 09:36:41'),
(602, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-04-01 09:36:41'),
(603, 1, 'AI Audit', 'Audited 1 regulatory segments (GAP Mode)', NULL, '2026-04-01 09:37:07'),
(604, 1, 'AI Audit', 'Completed GAP audit for 1 segments', NULL, '2026-04-01 09:37:07'),
(605, 1, 'AI Audit', 'Completed GAP audit for 1 segments', NULL, '2026-04-01 09:37:07'),
(606, 1, 'AI Chat', 'Asked: Please rate SIMATS Engineering...', NULL, '2026-04-01 09:44:50'),
(607, 1, 'AI Chat', 'Asked: How is anirudh\'s concert on march 21st...', NULL, '2026-04-01 09:45:18'),
(608, 1, 'AI Chat', 'Asked: how e u buddy...', NULL, '2026-04-01 14:58:11'),
(609, 1, 'AI Chat', 'Asked: what day is today...', NULL, '2026-04-01 14:58:24'),
(610, 1, 'AI Chat', 'Asked: what is AI...', NULL, '2026-04-01 14:59:00'),
(611, 1, 'AI Chat', 'Asked: Please rate SIMATS Engineering college ?...', NULL, '2026-04-01 15:00:48'),
(612, 1, 'AI Chat', 'Asked: rate Alagappa University agriculture department...', NULL, '2026-04-01 15:01:26'),
(613, 1, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-04-02 15:25:14'),
(614, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-02 15:25:48'),
(615, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-04-02 15:26:12'),
(616, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-04-02 15:26:13'),
(617, 1, 'Download', 'Generated Audit PDF: NEW SCHEME ON RURAL EDUCATION (2025)', 'DOC_1', '2026-04-02 15:26:17'),
(618, 1, 'Download', 'Generated Audit PDF: URBAN LITERACY DRIVE - FAQ', 'DOC_2', '2026-04-02 15:26:26'),
(619, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-04-02 15:27:08'),
(620, 1, 'AI Audit', 'Audited 1 regulatory segments (CONFLICT Mode)', NULL, '2026-04-02 15:27:36'),
(621, 1, 'AI Audit', 'Completed CONFLICT audit for 1 segments', NULL, '2026-04-02 15:27:37'),
(622, 1, 'Download', 'Generated Audit PDF: HOSTEL ADMISSION RULES 2024', 'DOC_1', '2026-04-02 15:27:39'),
(623, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-04-02 15:28:03'),
(624, 1, 'AI Audit', 'Audited 1 regulatory segments (CONFLICT Mode)', NULL, '2026-04-02 15:28:34'),
(625, 1, 'AI Audit', 'Completed CONFLICT audit for 1 segments', NULL, '2026-04-02 15:28:34'),
(626, 1, 'Download', 'Generated Audit PDF: Hostel Admission Rules 2024', 'DOC_1', '2026-04-02 15:28:36'),
(627, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-04-02 15:29:00'),
(628, 1, 'AI Audit', 'Audited 1 regulatory segments (GAP Mode)', NULL, '2026-04-02 15:29:25'),
(629, 1, 'AI Audit', 'Completed GAP audit for 1 segments', NULL, '2026-04-02 15:29:25'),
(630, 1, 'Download', 'Generated Audit PDF: Laboratory Safety Protocols (Draft)', 'DOC_1', '2026-04-02 15:29:28'),
(631, 1, 'AI Chat', 'Asked: hey hi\nhow are you...', NULL, '2026-04-02 15:29:59'),
(632, 1, 'AI Chat', 'Asked: hi how are you...', NULL, '2026-04-02 15:35:44'),
(633, 1, 'AI Chat', 'Asked: tell.me about the National Education Policy 2020...', NULL, '2026-04-02 15:36:25'),
(634, 1, 'AI Chat', 'Asked: thank you\ni will ping you later...', NULL, '2026-04-02 15:36:56'),
(635, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-02 18:17:46'),
(636, 1, 'AI Audit', 'Audited 1 regulatory segments (SCENARIO Mode)', NULL, '2026-04-02 18:18:04'),
(637, 1, 'AI Audit', 'Completed SCENARIO audit for 1 segments', NULL, '2026-04-02 18:18:05'),
(638, 1, 'Download', 'Generated Audit PDF: NEW SCHEME ON RURAL EDUCATION (2025)', 'DOC_1', '2026-04-02 18:18:26'),
(639, 1, 'View', 'Viewed Anti-Ragging Guidelines 2025', 'DOC3', '2026-04-02 18:20:32'),
(640, 1, 'Save', 'Saved AICTE Idea Lab Establishment', 'DOC22', '2026-04-02 18:20:36'),
(641, 5, 'Save', 'Saved Mid-Day Meal (PM-POSHAN) Rules', 'DOC9', '2026-04-02 22:30:17'),
(642, 5, 'Save', 'Saved Kendriya Vidyalaya Admission Policy', 'DOC11', '2026-04-02 22:30:20'),
(643, 1, 'Unsave', 'Unsaved document DOC19', 'DOC19', '2026-04-03 13:12:12'),
(644, 1, 'Unsave', 'Unsaved document DOC9', 'DOC9', '2026-04-03 13:12:14'),
(645, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-03 13:13:14'),
(646, 1, 'AI Audit', 'Audited 1 regulatory segments (SCENARIO Mode)', NULL, '2026-04-03 13:13:38'),
(647, 1, 'AI Audit', 'Completed SCENARIO audit for 1 segments', NULL, '2026-04-03 13:13:38'),
(648, 1, 'Download', 'Generated Audit PDF: NEW SCHEME ON RURAL EDUCATION (2025)', 'DOC_1', '2026-04-03 13:13:55'),
(649, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-04-03 13:14:33'),
(650, 1, 'AI Audit', 'Audited 1 regulatory segments (CONFLICT Mode)', NULL, '2026-04-03 13:15:06'),
(651, 1, 'AI Audit', 'Completed CONFLICT audit for 1 segments', NULL, '2026-04-03 13:15:06'),
(652, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-04-03 13:15:58'),
(653, 1, 'AI Audit', 'Audited 1 regulatory segments (GAP Mode)', NULL, '2026-04-03 13:16:26'),
(654, 1, 'AI Audit', 'Completed GAP audit for 1 segments', NULL, '2026-04-03 13:16:26'),
(655, 1, 'User', 'Updated profile information', NULL, '2026-04-03 13:16:55'),
(662, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 10:30:16'),
(663, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 10:30:39'),
(664, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-04-04 10:30:39'),
(665, 1, 'Download', 'Generated Audit PDF: NEW SCHEME ON RURAL EDUCATION (2025)', 'DOC_1', '2026-04-04 10:30:48'),
(666, 1, 'Download', 'Generated Audit PDF: URBAN LITERACY DRIVE - FAQ', 'DOC_2', '2026-04-04 10:30:53'),
(667, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 10:38:33'),
(668, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 10:38:55'),
(669, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-04-04 10:38:55'),
(670, 1, 'View', 'Opened official report: Audit Briefing (04/04 10:38)', 'GOI_Audit_Briefing_20260404103857', '2026-04-04 10:39:31'),
(671, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 10:46:57'),
(672, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 10:47:19'),
(673, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-04-04 10:47:19'),
(674, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-04-04 13:15:15'),
(675, 1, 'AI Audit', 'Audited 3 regulatory segments (CONFLICT Mode)', NULL, '2026-04-04 13:15:48'),
(676, 1, 'AI Audit', 'Completed CONFLICT audit for 3 segments', NULL, '2026-04-04 13:15:48'),
(677, 1, 'View', 'Opened official report: NIRF 2024: National Ranking Report', 'DOC2', '2026-04-04 13:17:19'),
(678, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 13:58:25'),
(679, 1, 'AI Audit', 'Audited 3 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 13:58:55'),
(680, 1, 'AI Audit', 'Completed SCENARIO audit for 3 segments', NULL, '2026-04-04 13:58:55'),
(681, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 14:02:24'),
(682, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 14:02:44'),
(683, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-04-04 14:02:45'),
(684, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 14:09:14'),
(685, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 14:09:38'),
(686, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-04-04 14:09:38'),
(687, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 14:16:59'),
(688, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 14:17:25'),
(689, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-04-04 14:17:25'),
(690, 1, 'View', 'Opened official report: AISHE 2021-22 Final Report', 'DOC8', '2026-04-04 14:21:15'),
(691, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 14:30:36'),
(692, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 14:30:59'),
(693, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-04-04 14:30:59'),
(694, 1, 'View', 'Opened official report: NIRF 2024: National Ranking Report', 'DOC2', '2026-04-04 14:52:27'),
(695, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 14:57:12'),
(696, 1, 'AI Audit', 'Audited 3 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 14:57:40'),
(697, 1, 'AI Audit', 'Completed SCENARIO audit for 3 segments', NULL, '2026-04-04 14:57:40'),
(698, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 15:09:28'),
(699, 1, 'AI Audit', 'Audited 3 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 15:09:53'),
(700, 1, 'AI Audit', 'Completed SCENARIO audit for 3 segments', NULL, '2026-04-04 15:09:54'),
(701, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 15:14:01'),
(702, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 15:14:23'),
(703, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-04-04 15:14:23'),
(704, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 15:20:21'),
(705, 1, 'AI Audit', 'Audited 2 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 15:20:45'),
(706, 1, 'AI Audit', 'Completed SCENARIO audit for 2 segments', NULL, '2026-04-04 15:20:45'),
(707, 1, 'AI Audit', 'Started GAP audit for 1 files', NULL, '2026-04-04 15:25:03'),
(708, 1, 'AI Audit', 'Audited 1 regulatory segments (GAP Mode)', NULL, '2026-04-04 15:25:33'),
(709, 1, 'AI Audit', 'Completed GAP audit for 1 segments', NULL, '2026-04-04 15:25:33'),
(710, 1, 'View', 'Opened official report: user 1 Audit 1775296536992', 'user_1_Audit_1775296536992', '2026-04-04 15:26:01'),
(711, 1, 'View', 'Opened official report: Audit 1775296536992', 'user_1_Audit_1775296536992', '2026-04-04 15:28:46'),
(712, 1, 'View', 'Opened official report: Audit 1775296536992', 'user_1_Audit_1775296536992', '2026-04-04 15:42:47'),
(713, 1, 'Download', 'Downloaded \"Audit 1775296536992\"', 'user_1_Audit_1775296536992', '2026-04-04 15:43:06'),
(714, 1, 'Download', 'Downloaded \"Audit 1775296536992\"', 'user_1_Audit_1775296536992', '2026-04-04 15:43:11'),
(715, 1, 'Download', 'Downloaded \"Audit 1775296536992\"', 'user_1_Audit_1775296536992', '2026-04-04 16:20:42');
INSERT INTO `user_activities` (`id`, `user_id`, `activity_type`, `detail`, `doc_id`, `created_at`) VALUES
(716, 1, 'View', 'Opened official report: Audit 1775296536992', 'user_1_Audit_1775296536992', '2026-04-04 16:20:53'),
(717, 1, 'View', 'Opened official report: Audit 1775295868458', 'user_1_Audit_1775295868458', '2026-04-04 16:21:00'),
(718, 1, 'AI Audit', 'Started CONFLICT audit for 1 files', NULL, '2026-04-04 16:21:26'),
(719, 1, 'AI Audit', 'Audited 1 regulatory segments (CONFLICT Mode)', NULL, '2026-04-04 16:21:59'),
(720, 1, 'AI Audit', 'Completed CONFLICT audit for 1 segments', NULL, '2026-04-04 16:21:59'),
(721, 1, 'View', 'Opened official report: Audit 1775300202414', 'user_1_Audit_1775300202414', '2026-04-04 16:27:47'),
(722, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 17:09:09'),
(723, 1, 'AI Audit', 'Audited 1 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 17:09:35'),
(724, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-04 17:09:35'),
(725, 1, 'AI Audit', 'Audited 1 regulatory segments (SCENARIO Mode)', NULL, '2026-04-04 17:10:06'),
(726, 1, 'AI Audit', 'Completed SCENARIO audit for 1 segments', NULL, '2026-04-04 17:10:06'),
(727, 1, 'AI Audit', 'Completed SCENARIO audit for 1 segments', NULL, '2026-04-04 17:10:06'),
(728, 1, 'AI Audit', 'Started SCENARIO audit for 1 files', NULL, '2026-04-05 08:55:56'),
(729, 1, 'AI Audit', 'Audited 1 regulatory segments (SCENARIO Mode)', NULL, '2026-04-05 08:56:20'),
(730, 1, 'AI Audit', 'Completed SCENARIO audit for 1 segments', NULL, '2026-04-05 08:56:20'),
(731, 1, 'View', 'Opened official report: Audit 1775359584423', 'user_1_Audit_1775359584423', '2026-04-05 08:56:43'),
(732, 1, 'View', 'Viewed AICTE Idea Lab Establishment', 'DOC22', '2026-04-05 09:04:09'),
(733, 1, 'View', 'Viewed Anti-Ragging Guidelines 2025', 'DOC3', '2026-04-05 09:04:12'),
(734, 1, 'View', 'Viewed NPTEL Course Recognition Rules', 'DOC26', '2026-04-05 09:04:15'),
(735, 1, 'AI Chat', 'Asked: Hello, who are you?...', NULL, '2026-04-05 18:15:16'),
(736, 1, 'AI Chat', 'Asked: What is the main goal of NEP 2020?...', NULL, '2026-04-05 18:15:59'),
(737, 1, 'AI Chat', 'Asked: hii how are you...', NULL, '2026-04-05 18:17:28'),
(738, 1, 'AI Chat', 'Asked: what is the fee structure of Amity University Mumb...', NULL, '2026-04-05 18:19:12'),
(739, 1, 'AI Audit', 'Audited 1 regulatory segments (GAP Mode)', NULL, '2026-04-05 18:38:20'),
(740, 1, 'AI Audit', 'Audited 1 regulatory segments (CONFLICT Mode)', NULL, '2026-04-05 19:52:44'),
(741, 1, 'User', 'Updated profile information', NULL, '2026-04-05 20:34:58'),
(742, 1, 'User', 'Updated profile information', NULL, '2026-04-05 20:43:17'),
(743, 1, 'User', 'Updated profile information', NULL, '2026-04-05 20:43:47'),
(744, 1, 'AI Chat', 'Asked: Hi...', NULL, '2026-04-05 21:04:49'),
(745, 1, 'AI Chat', 'Asked: What is the fee structure of parul university...', NULL, '2026-04-05 21:06:15'),
(746, 1, 'AI Chat', 'Asked: Is there anything else I can assist you with conce...', NULL, '2026-04-05 21:06:58'),
(747, 1, 'AI Chat', 'Asked: Topper you are so musuko...', NULL, '2026-04-05 21:07:43'),
(748, 1, 'User', 'Updated profile information', NULL, '2026-04-05 21:08:02'),
(749, 1, 'User', 'Updated profile information', NULL, '2026-04-05 21:14:29'),
(750, 1, 'User', 'Updated profile information', NULL, '2026-04-05 21:17:10'),
(751, 1, 'User', 'Updated profile information', NULL, '2026-04-05 21:39:27');

-- --------------------------------------------------------

--
-- Table structure for table `user_devices`
--

CREATE TABLE `user_devices` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `device_name` varchar(255) NOT NULL,
  `os_version` varchar(100) DEFAULT NULL,
  `last_login` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_devices`
--

INSERT INTO `user_devices` (`id`, `user_id`, `device_name`, `os_version`, `last_login`, `is_active`) VALUES
(1, 1, 'Redmi Note 9 Pro', 'Android 12', '2026-04-06 10:48:16', 1),
(5, 12, 'Redmi Note 9 Pro', 'Android 12', '2026-04-03 14:25:01', 1),
(11, 13, 'Redmi Note 9 Pro', 'Android 12', '2026-04-05 10:27:00', 1),
(12, 5, 'Web Portal', 'Windows/Web', '2026-04-05 22:54:00', 1),
(13, 1, 'Web Portal', 'Windows/Web', '2026-04-05 22:57:41', 1),
(16, 15, 'Web Portal', 'Windows/Web', '2026-04-06 10:08:47', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_notif_user` (`user_id`);

--
-- Indexes for table `otps`
--
ALTER TABLE `otps`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `recent_views`
--
ALTER TABLE `recent_views`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_view` (`user_id`,`doc_id`);

--
-- Indexes for table `saved_docs`
--
ALTER TABLE `saved_docs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_doc` (`user_id`,`doc_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_activities`
--
ALTER TABLE `user_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_act_user` (`user_id`);

--
-- Indexes for table `user_devices`
--
ALTER TABLE `user_devices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_device` (`user_id`,`device_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `recent_views`
--
ALTER TABLE `recent_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT for table `saved_docs`
--
ALTER TABLE `saved_docs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `user_activities`
--
ALTER TABLE `user_activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=752;

--
-- AUTO_INCREMENT for table `user_devices`
--
ALTER TABLE `user_devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notif_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `recent_views`
--
ALTER TABLE `recent_views`
  ADD CONSTRAINT `fk_view_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `saved_docs`
--
ALTER TABLE `saved_docs`
  ADD CONSTRAINT `fk_saved_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_activities`
--
ALTER TABLE `user_activities`
  ADD CONSTRAINT `fk_act_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_devices`
--
ALTER TABLE `user_devices`
  ADD CONSTRAINT `user_devices_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
