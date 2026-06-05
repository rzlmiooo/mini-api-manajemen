-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for mini_api_manajemen
CREATE DATABASE IF NOT EXISTS `mini_api_manajemen` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mini_api_manajemen`;

-- Dumping structure for table mini_api_manajemen.deployments
CREATE TABLE IF NOT EXISTS `deployments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint unsigned NOT NULL,
  `server_id` bigint unsigned NOT NULL,
  `deploy_date` datetime NOT NULL,
  `status` enum('success','failed','pending') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deployments_project_id_foreign` (`project_id`),
  KEY `deployments_server_id_foreign` (`server_id`),
  CONSTRAINT `deployments_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `deployments_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_api_manajemen.deployments: ~0 rows (approximately)

-- Dumping structure for table mini_api_manajemen.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_api_manajemen.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table mini_api_manajemen.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_api_manajemen.migrations: ~0 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(5, '2026_05_19_004549_add_role_to_users_table', 1),
	(6, '2026_05_19_004556_create_projects_table', 1),
	(7, '2026_05_19_004557_create_tasks_table', 1),
	(8, '2026_05_19_004558_create_servers_table', 1),
	(9, '2026_05_19_004559_create_deployments_table', 1);

-- Dumping structure for table mini_api_manajemen.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_api_manajemen.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table mini_api_manajemen.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_api_manajemen.personal_access_tokens: ~3 rows (approximately)
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
	(2, 'App\\Models\\User', 1, 'auth_token', 'e3f31ab2ce601c365f81d48f2d7adf78726331793e829d7945a1a30df15c77c3', '["*"]', '2026-05-18 18:32:28', NULL, '2026-05-18 18:06:31', '2026-05-18 18:32:28'),
	(3, 'App\\Models\\User', 1, 'auth_token', 'f6d8dda7a1ec601a72f28f8a4dda00ba501ceb9142c221905c9ca4af1335c147', '["*"]', NULL, NULL, '2026-05-24 18:04:11', '2026-05-24 18:04:11'),
	(4, 'App\\Models\\User', 1, 'auth_token', '8d275892d6b19bdd4ac96a38dadf99d0d7e79b366aa6cc990c7942a758bbfc4c', '["*"]', NULL, NULL, '2026-05-24 18:04:33', '2026-05-24 18:04:33'),
	(5, 'App\\Models\\User', 1, 'auth_token', 'a0f85b6071a037c455c0ef21e884b6d42b3e1f648cbb4d7f7e101918dcf96472', '["*"]', NULL, NULL, '2026-06-05 08:48:20', '2026-06-05 08:48:20'),
	(6, 'App\\Models\\User', 1, 'auth_token', '8c854e258dd8bbd028f60ea02d9fbe8c499e335f91ee1db4af994021ca9b16eb', '["*"]', NULL, NULL, '2026-06-05 09:23:44', '2026-06-05 09:23:44'),
	(8, 'App\\Models\\User', 1, 'auth_token', '7af98de852584f4dab6c5ac3c3f5663fb83ef1e85d068d658e04a93a42c8a89a', '["*"]', '2026-06-05 09:46:21', NULL, '2026-06-05 09:25:53', '2026-06-05 09:46:21');

-- Dumping structure for table mini_api_manajemen.projects
CREATE TABLE IF NOT EXISTS `projects` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('planning','ongoing','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'planning',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_api_manajemen.projects: ~2 rows (approximately)
INSERT INTO `projects` (`id`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
	(2, 'CRM Migration', 'Migrate old CRM to Salesforce', 'planning', '2026-05-18 17:55:18', '2026-05-18 17:55:18'),
	(4, 'New Project', 'Project description', 'planning', '2026-06-05 09:26:30', '2026-06-05 09:26:30');

-- Dumping structure for table mini_api_manajemen.servers
CREATE TABLE IF NOT EXISTS `servers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `os` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_api_manajemen.servers: ~2 rows (approximately)
INSERT INTO `servers` (`id`, `name`, `ip_address`, `os`, `is_active`, `created_at`, `updated_at`) VALUES
	(2, 'Database Server', '192.168.1.20', 'CentOS 8', 1, '2026-05-18 17:55:18', '2026-05-18 17:55:18'),
	(3, 'New Server', '127.0.0.1', 'Ubuntu', 1, '2026-06-05 09:40:36', '2026-06-05 09:40:36');

-- Dumping structure for table mini_api_manajemen.tasks
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('todo','in_progress','done') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'todo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_project_id_foreign` (`project_id`),
  KEY `tasks_user_id_foreign` (`user_id`),
  CONSTRAINT `tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_api_manajemen.tasks: ~0 rows (approximately)

-- Dumping structure for table mini_api_manajemen.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','manager','developer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'developer',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_api_manajemen.users: ~4 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `role`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Admin User', 'admin@example.com', 'admin', NULL, '$2y$12$IM8m5MlYB8jRMFKPT/nlY.y1dzOWSLJf.j/oZyexTiudhS/H7SoNa', NULL, '2026-05-18 17:55:15', '2026-05-18 17:55:15'),
	(2, 'Manager User', 'manager@example.com', 'manager', NULL, '$2y$12$ETpod64dnqE6z9qMfEhere09VDxkQHW2KveipTmY7mgNc4ar278ba', NULL, '2026-05-18 17:55:16', '2026-05-18 17:55:16'),
	(3, 'Developer 1', 'dev1@example.com', 'developer', NULL, '$2y$12$yRcleNYVlkO6C9Y8LPe2aOgscVa/fnZYwXIg.IxRUecenxu2EZJLS', NULL, '2026-05-18 17:55:17', '2026-05-18 17:55:17'),
	(4, 'Developer 2', 'dev2@example.com', 'developer', NULL, '$2y$12$HKKtdeZjt8FzykVdFfO1FOgWi5C96WCvOKQBj3q4CzeJA10diFnQO', NULL, '2026-05-18 17:55:17', '2026-05-18 17:55:17'),
	(6, 'New User', 'user@example.com', 'developer', NULL, '$2y$12$y8.7oqE//Vx1Dd9SRhHI2O9yOc2SmVu3X64M2W2JoeKJ17s4AZR.i', NULL, '2026-06-05 09:22:38', '2026-06-05 09:22:38');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
