-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 03, 2026 at 02:37 PM
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
-- Database: `micro_components`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `part_number` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `status` enum('Pending','In Production','Shipped') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `part_number`, `description`, `quantity`, `status`, `created_at`) VALUES
(2, 'MC-GEAR-05M', '0.5 Modulus Brass Spur Pinion Gear (12-Tooth)', 2500, 'In Production', '2026-06-03 12:31:19'),
(3, 'MP-HEX-M3-10', 'M3 Stainless Steel Hexagonal Female Standoff (10mm)', 10000, 'Shipped', '2026-06-03 12:31:19'),
(4, 'SNS-TE-SMD04', 'Micro SMD Digital Ambient Temperature Sensor Module', 450, 'Pending', '2026-06-03 12:31:19'),
(5, 'CON-FPC-08P', '8-Pin 0.5mm Pitch Right-Angle FPC/FFC Connector', 1200, 'In Production', '2026-06-03 12:31:19'),
(6, 'SCR-PH-M2-06', 'M2 Pan Head Carbon Steel Machine Screw (6mm)', 25000, 'Shipped', '2026-06-03 12:31:19'),
(7, 'BRG-FLG-MF63', 'Flanged Miniature Shielded Ball Bearing (3x6x2.5mm)', 800, 'Pending', '2026-06-03 12:31:19'),
(8, 'LED-RGB-0404', 'Ultra-Miniature 0404 RGB Surface Mount LED Array', 5000, 'In Production', '2026-06-03 12:31:19'),
(9, 'OPTO-ISO-4N', 'High-Speed Micro-Isolation Optocoupler SOP-4', 3100, 'Shipped', '2026-06-03 12:31:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
