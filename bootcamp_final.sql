-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2025 at 10:33 AM
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
-- Database: `bootcamp_final`
--

-- --------------------------------------------------------

--
-- Table structure for table `predictions`
--

CREATE TABLE `predictions` (
  `prediction_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `uploaded_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `predictions`
--

INSERT INTO `predictions` (`prediction_id`, `filename`, `uploaded_at`) VALUES
(1, '00006.png', '2025-07-09 16:26:43'),
(2, '00000.png', '2025-07-09 16:30:09');

-- --------------------------------------------------------

--
-- Table structure for table `prediction_results`
--

CREATE TABLE `prediction_results` (
  `result_id` int(11) NOT NULL,
  `prediction_id` int(11) NOT NULL,
  `sign_id` int(11) NOT NULL,
  `confidence` float NOT NULL,
  `rank` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prediction_results`
--

INSERT INTO `prediction_results` (`result_id`, `prediction_id`, `sign_id`, `confidence`, `rank`) VALUES
(1, 1, 18, 1, 1),
(2, 1, 26, 4.62851e-21, 2),
(3, 1, 27, 2.22048e-24, 3),
(4, 2, 16, 1, 1),
(5, 2, 31, 0.000000000000258932, 2),
(6, 2, 42, 0.0000000000000233502, 3);

-- --------------------------------------------------------

--
-- Table structure for table `traffic_signs`
--

CREATE TABLE `traffic_signs` (
  `sign_id` int(11) NOT NULL,
  `label` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `traffic_signs`
--

INSERT INTO `traffic_signs` (`sign_id`, `label`) VALUES
(0, '20 Speed Limit'),
(1, '30 Speed Limit'),
(2, '50 Speed Limit'),
(3, '60 Speed Limit'),
(4, '70 Speed Limit'),
(5, '80 Speed Limit'),
(6, 'no 80'),
(7, '100 Speed Limit'),
(8, '120 Speed Limit'),
(9, 'no overtaking'),
(10, 'no overtaking truck'),
(11, 'lane diversion'),
(12, 'warning'),
(13, 'do not enter'),
(14, 'stop'),
(15, 'no parking'),
(16, 'No Heavy Vehicles'),
(17, 'prohibitory traffic'),
(18, 'caution'),
(19, 'no left turn'),
(20, 'no right turn'),
(21, 'high voltage hazard'),
(22, 'bumpy road'),
(23, 'slippery road'),
(24, 'merging traffic'),
(25, 'men at work'),
(26, 'traffic light'),
(27, 'people crossing'),
(28, 'children crossing'),
(29, 'bike'),
(30, 'snowy road'),
(31, 'careful for deer'),
(32, 'stop lang'),
(33, 'right turn'),
(34, 'left turn'),
(35, 'go now'),
(36, 'forward and right'),
(37, 'forward and left'),
(38, 'slow right'),
(39, 'slow left'),
(40, 'circling arrow'),
(41, 'no double parking'),
(42, 'no truck parking');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `predictions`
--
ALTER TABLE `predictions`
  ADD PRIMARY KEY (`prediction_id`);

--
-- Indexes for table `prediction_results`
--
ALTER TABLE `prediction_results`
  ADD PRIMARY KEY (`result_id`),
  ADD KEY `prediction_id` (`prediction_id`),
  ADD KEY `sign_id` (`sign_id`);

--
-- Indexes for table `traffic_signs`
--
ALTER TABLE `traffic_signs`
  ADD PRIMARY KEY (`sign_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `predictions`
--
ALTER TABLE `predictions`
  MODIFY `prediction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `prediction_results`
--
ALTER TABLE `prediction_results`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `prediction_results`
--
ALTER TABLE `prediction_results`
  ADD CONSTRAINT `prediction_results_ibfk_1` FOREIGN KEY (`prediction_id`) REFERENCES `predictions` (`prediction_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `prediction_results_ibfk_2` FOREIGN KEY (`sign_id`) REFERENCES `traffic_signs` (`sign_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
