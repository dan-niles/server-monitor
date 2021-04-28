-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 01, 2020 at 11:33 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `servermonitor`
--

-- --------------------------------------------------------

--
-- Table structure for table `fail_logs`
--

CREATE TABLE `fail_logs` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `log_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fail_logs`
--

INSERT INTO `fail_logs` (`id`, `ip_address`, `alias`, `description`, `log_time`) VALUES
(2, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-08-30 11:04:10'),
(3, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-08-30 11:15:58'),
(4, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-08-30 11:18:18'),
(5, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-08-30 11:20:08'),
(6, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-08-30 14:09:49'),
(7, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-08-30 14:11:48'),
(8, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-08-30 14:20:04'),
(9, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-08-30 14:21:58'),
(10, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-08-30 14:27:19'),
(11, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-08-30 14:28:21'),
(12, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-09-01 12:03:51'),
(13, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-09-01 14:40:24'),
(14, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-09-01 14:41:02'),
(15, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-09-01 14:43:41'),
(16, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-09-01 14:51:24'),
(17, '192.168.1.3', 'Dan\'s Phone', 'Dan\'s Phone: 192.168.1.3 is down. Ping Unsuccessful.', '2020-09-01 14:52:19');

-- --------------------------------------------------------

--
-- Table structure for table `phone_numbers`
--

CREATE TABLE `phone_numbers` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `is_active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `phone_numbers`
--

INSERT INTO `phone_numbers` (`id`, `phone_number`, `alias`, `is_active`) VALUES
(1, '+94776365737', 'Dan Niles', 1);

-- --------------------------------------------------------

--
-- Table structure for table `run_logs`
--

CREATE TABLE `run_logs` (
  `id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `successful_pings` varchar(255) NOT NULL,
  `failed_pings` varchar(255) NOT NULL,
  `log_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `run_logs`
--

INSERT INTO `run_logs` (`id`, `description`, `successful_pings`, `failed_pings`, `log_time`) VALUES
(4, 'Script Execution Successful', '2/2', '0/2', '2020-08-29 20:33:36'),
(5, 'Script Execution Successful', '2/2', '0/2', '2020-08-29 21:24:57'),
(6, 'Script Execution Successful', '1/2', '1/2', '2020-08-29 21:47:36'),
(7, 'Script Execution Successful', '1/2', '1/2', '2020-08-29 21:53:50'),
(8, 'Script Execution Successful', '1/2', '1/2', '2020-08-29 21:55:31'),
(9, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 10:53:20'),
(10, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 10:57:23'),
(11, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 10:57:48'),
(12, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 11:03:18'),
(13, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 11:04:10'),
(14, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 11:15:58'),
(15, 'Script Execution Successful', '2/2', '0/2', '2020-08-30 11:17:34'),
(16, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 11:18:18'),
(17, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 11:20:08'),
(18, 'Script Execution Successful', '2/2', '0/2', '2020-08-30 12:07:09'),
(19, 'Script Execution Successful', '2/2', '0/2', '2020-08-30 13:43:20'),
(20, 'Script Execution Successful', '2/2', '0/2', '2020-08-30 13:54:46'),
(21, 'Script Execution Successful', '2/2', '0/2', '2020-08-30 13:56:32'),
(22, 'Script Execution Successful', '2/2', '0/2', '2020-08-30 14:08:57'),
(23, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 14:09:49'),
(24, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 14:11:48'),
(25, 'Script Execution Successful', '2/2', '0/2', '2020-08-30 14:13:44'),
(26, 'Script Execution Successful', '2/2', '0/2', '2020-08-30 14:15:50'),
(27, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 14:20:04'),
(28, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 14:21:58'),
(29, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 14:27:19'),
(30, 'Script Execution Successful', '1/2', '1/2', '2020-08-30 14:28:21'),
(31, 'Script Execution Successful', '2/2', '0/2', '2020-09-01 12:02:56'),
(32, 'Script Execution Successful', '1/2', '1/2', '2020-09-01 12:03:51'),
(33, 'Script Execution Successful', '2/2', '0/2', '2020-09-01 12:15:20'),
(34, 'Script Execution Successful', '2/2', '0/2', '2020-09-01 12:16:18'),
(35, 'Script Execution Successful', '2/2', '0/2', '2020-09-01 12:17:30'),
(36, 'Script Execution Successful', '2/2', '0/2', '2020-09-01 12:17:58'),
(37, 'Script Execution Successful', '2/2', '0/2', '2020-09-01 12:18:15'),
(38, 'Script Execution Successful', '2/2', '0/2', '2020-09-01 12:18:58');

-- --------------------------------------------------------

--
-- Table structure for table `servers`
--

CREATE TABLE `servers` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `port` int(11) NOT NULL,
  `connection` varchar(255) NOT NULL COMMENT '(plain, ssl, ping)',
  `is_active` int(11) NOT NULL,
  `priority` varchar(255) NOT NULL,
  `alert` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `servers`
--

INSERT INTO `servers` (`id`, `ip_address`, `alias`, `port`, `connection`, `is_active`, `priority`, `alert`) VALUES
(1, '192.168.1.1', 'Router', 0, 'ping', 0, 'low', 0),
(2, '192.168.1.2', 'Dan\'s PC', 0, 'ping', 1, 'high', 0),
(3, '192.168.1.3', 'Dan\'s Phone', 0, 'ping', 1, 'high', 0),
(4, 'mail.astron.lk', 'Mail Server', 80, 'plain', 0, 'high', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fail_logs`
--
ALTER TABLE `fail_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `phone_numbers`
--
ALTER TABLE `phone_numbers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `run_logs`
--
ALTER TABLE `run_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `servers`
--
ALTER TABLE `servers`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fail_logs`
--
ALTER TABLE `fail_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `phone_numbers`
--
ALTER TABLE `phone_numbers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `run_logs`
--
ALTER TABLE `run_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `servers`
--
ALTER TABLE `servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
