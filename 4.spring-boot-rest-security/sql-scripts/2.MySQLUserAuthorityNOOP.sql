CREATE DATABASE IF NOT EXISTS `employee_directory`;
USE `employee_directory`;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS `authorities`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `employee`;

--
-- Table structure for table `users`
--
CREATE TABLE `users` (
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Inserting data for table `users`
--
INSERT INTO `users` VALUES
('john', '{noop}test123', 1),
('mary', '{noop}test123', 1),
('susan', '{noop}test123', 1);

--
-- Table structure for table `authorities`
--
CREATE TABLE `authorities` (
  `username` VARCHAR(50) NOT NULL,
  `authority` VARCHAR(50) NOT NULL,

  -- Below line ensures that the combination of username and authority is unique.
  -- User cannot have the same role (authority) assigned multiple times.
  UNIQUE KEY `authorities_idx_1` (`username`, `authority`),
  -- eg - INSERT INTO `authorities` VALUES ('john', 'ROLE_EMPLOYEE'); -- ✅ Allowed
  -- INSERT INTO `authorities` VALUES ('john', 'ROLE_MANAGER');  -- ✅ Allowed
  -- INSERT INTO `authorities` VALUES ('john', 'ROLE_EMPLOYEE'); -- ❌ ERROR (Duplicate entry)


  -- Below line username in the authorities table must exist in the users table.
  -- This ensures that a role cannot be assigned to a non-existent user.
  -- If you try to insert a role for a user that doesn’t exist, you’ll get an error.
  CONSTRAINT `authorities_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
  -- eg - INSERT INTO `authorities` VALUES ('alice', 'ROLE_ADMIN'); -- ❌ ERROR (alice is not in `users`)


) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Inserting data for table `authorities`
--
INSERT INTO `authorities` VALUES
('john', 'ROLE_EMPLOYEE'),
('mary', 'ROLE_EMPLOYEE'),
('mary', 'ROLE_MANAGER'),
('susan', 'ROLE_EMPLOYEE'),
('susan', 'ROLE_MANAGER'),
('susan', 'ROLE_ADMIN');

--
-- Table structure for table `employee`
--
CREATE TABLE `employee` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Inserting sample data for `employee`
--
INSERT INTO `employee` (`first_name`, `last_name`, `email`) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Mary', 'Smith', 'mary.smith@example.com'),
('Susan', 'Johnson', 'susan.johnson@example.com');
