CREATE DATABASE IF NOT EXISTS `employee_directory`;
USE `employee_directory`;
CREATE TABLE employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO employee (first_name, last_name, email)
VALUES
('David', 'Williams', 'david.williams@example.com'),
('Emma', 'Brown', 'emma.brown@example.com'),
('Michael', 'Taylor', 'michael.taylor@example.com'),
('Olivia', 'Anderson', 'olivia.anderson@example.com'),
('James', 'Thomas', 'james.thomas@example.com');
