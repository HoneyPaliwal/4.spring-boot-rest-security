CREATE DATABASE IF NOT EXISTS `employee_directory`;
USE `employee_directory`;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS `authorities`;
DROP TABLE IF EXISTS `employee`;

-- ✅ Table structure for `employee`
CREATE TABLE `employee` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(50) UNIQUE NOT NULL, -- ✅ Added username for authentication
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) UNIQUE NOT NULL,
  `password` CHAR(68) NOT NULL, -- ✅ BCrypt encrypted password
  `enabled` TINYINT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ✅ Inserting data for `employee`
-- NOTE: The passwords are encrypted using BCrypt
-- Default password for all users: fun123
INSERT INTO `employee`
(`username`, `first_name`, `last_name`, `email`, `password`, `enabled`)
VALUES
('john', 'John', 'Doe', 'john@example.com', '$2y$16$1XTrBofArUKne1DaJkWAQ.NE7V5IvbG0o71XQHuDlxMtb8Rp1wi0q', 1),
('mary', 'Mary', 'Smith', 'mary@example.com', '$2y$16$7Bj6UwjE9eZ8LASVSrM8L.LR4enT/SK7xytqy9QT96RIKNMG0Iyzy', 1),
('susan', 'Susan', 'Brown', 'susan@example.com', '$2y$16$87wmyK7W7G9Z/k0wyVtfPOzZg7zDHGMblsLWZijk4QHUl03ZU79jK', 1);

-- ✅ Table structure for `authorities`
CREATE TABLE `authorities` (
  `employee_id` INT NOT NULL,
  `authority` VARCHAR(50) NOT NULL,
  UNIQUE KEY `authorities_idx_1` (`employee_id`,`authority`),
  CONSTRAINT `authorities_fk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ✅ Inserting data for `authorities`
INSERT INTO `authorities`
(`employee_id`, `authority`)
VALUES
(1, 'ROLE_EMPLOYEE'),
(2, 'ROLE_EMPLOYEE'),
(2, 'ROLE_MANAGER'),
(3, 'ROLE_EMPLOYEE'),
(3, 'ROLE_MANAGER'),
(3, 'ROLE_ADMIN');
