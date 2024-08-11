-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 02, 2023 at 01:21 AM
-- Server version: 8.0.29-0ubuntu0.20.04.3
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fuel_filling`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `names` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `email`, `names`, `phone`, `address`, `password`, `time`) VALUES
(1, 'admin@gmail.com', 'Rukundo', '0788750979', 'Huye, Rwanda', '3b081fd5426c134088a9b1466ff4c224', '2022-06-17 13:58:07');

-- --------------------------------------------------------

--
-- Table structure for table `consume`
--

CREATE TABLE `consume` (
  `id` int NOT NULL,
  `user` int NOT NULL,
  `amount` int NOT NULL,
  `total` int NOT NULL DEFAULT '0',
  `seller` int NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Dumping data for table `consume`
--

INSERT INTO `consume` (`id`, `user`, `amount`, `total`, `seller`, `time`) VALUES
(24, 1, 1000, 1000, 1, '2022-11-25 10:01:53'),
(25, 1, 1000, 2000, 1, '2022-11-25 10:09:29'),
(26, 1, 200, 1800, 1, '2022-11-29 19:52:54'),
(27, 1, 200, 1600, 1, '2022-11-29 19:54:36'),
(28, 1, 1000, 2600, 1, '2022-11-29 20:09:24'),
(29, 1, 1000, 3600, 1, '2022-11-29 20:09:46'),
(30, 1, 2000, 5600, 1, '2022-12-06 08:34:19'),
(31, 1, 3000, 8600, 1, '2022-12-06 08:37:23'),
(32, 1, 2000, 10600, 1, '2022-12-06 08:45:33');

-- --------------------------------------------------------

--
-- Table structure for table `consume_allowed`
--

CREATE TABLE `consume_allowed` (
  `id` int NOT NULL,
  `consume` int NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Dumping data for table `consume_allowed`
--

INSERT INTO `consume_allowed` (`id`, `consume`, `time`) VALUES
(1, 0, '2022-11-20 00:31:46');

-- --------------------------------------------------------

--
-- Table structure for table `momotr`
--

CREATE TABLE `momotr` (
  `id` int NOT NULL,
  `amount` int NOT NULL,
  `number` varchar(255) NOT NULL,
  `user` varchar(255) NOT NULL,
  `status` enum('pending','fail','succeed') NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Dumping data for table `momotr`
--

INSERT INTO `momotr` (`id`, `amount`, `number`, `user`, `status`, `time`) VALUES
(1, 100, '0788750979', '1', 'pending', '2022-10-09 04:30:54');

-- --------------------------------------------------------

--
-- Table structure for table `pending_withdraw`
--

CREATE TABLE `pending_withdraw` (
  `id` int NOT NULL,
  `seller` int NOT NULL,
  `amount` int NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Dumping data for table `pending_withdraw`
--

INSERT INTO `pending_withdraw` (`id`, `seller`, `amount`, `time`) VALUES
(1, 1, 500, '2022-06-25 21:35:43');

-- --------------------------------------------------------

--
-- Table structure for table `price`
--

CREATE TABLE `price` (
  `id` int NOT NULL,
  `price` int NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Dumping data for table `price`
--

INSERT INTO `price` (`id`, `price`, `time`) VALUES
(1, 100, '2022-07-20 23:19:59');

-- --------------------------------------------------------

--
-- Table structure for table `seller`
--

CREATE TABLE `seller` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `names` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `machine_id` varchar(255) DEFAULT NULL,
  `balance` varchar(255) NOT NULL,
  `ml` varchar(255) NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Dumping data for table `seller`
--

INSERT INTO `seller` (`id`, `email`, `names`, `phone`, `address`, `machine_id`, `balance`, `ml`, `password`, `time`) VALUES
(1, 'seller@gmail.com', 'Fabiola', '0788750979', 'Huye, Rwanda', '202203256', '20803', '0', '3b081fd5426c134088a9b1466ff4c224', '2022-06-17 13:17:29');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int NOT NULL,
  `debit` int DEFAULT NULL,
  `credit` int DEFAULT NULL,
  `seller` int DEFAULT NULL,
  `user` int DEFAULT NULL,
  `admin` int DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `debit`, `credit`, `seller`, `user`, `admin`, `time`) VALUES
(1, 1000, 0, 1, 1, 1, '2022-07-17 20:40:03'),
(2, NULL, 1, 1, NULL, NULL, '2022-07-20 14:15:31'),
(3, NULL, NULL, NULL, 1, NULL, '2022-07-20 20:40:31'),
(4, NULL, NULL, NULL, 1, NULL, '2022-07-20 21:34:09'),
(6, 6000, NULL, NULL, 1, NULL, '2022-07-20 21:42:24');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `names` varchar(255) NOT NULL,
  `card` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL DEFAULT '0',
  `balance` int NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `names`, `card`, `email`, `phone`, `balance`, `time`) VALUES
(1, 'Rukundo', '13 13 BD AB', 'aimedidiermugisha@gmail.com', '0788750979', 0, '2022-06-25 22:23:06');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `consume`
--
ALTER TABLE `consume`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`),
  ADD KEY `seller` (`seller`);

--
-- Indexes for table `consume_allowed`
--
ALTER TABLE `consume_allowed`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `momotr`
--
ALTER TABLE `momotr`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pending_withdraw`
--
ALTER TABLE `pending_withdraw`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller` (`seller`);

--
-- Indexes for table `price`
--
ALTER TABLE `price`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seller`
--
ALTER TABLE `seller`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller` (`seller`),
  ADD KEY `user` (`user`),
  ADD KEY `admin` (`admin`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `card` (`card`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `consume`
--
ALTER TABLE `consume`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `consume_allowed`
--
ALTER TABLE `consume_allowed`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `momotr`
--
ALTER TABLE `momotr`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=353;

--
-- AUTO_INCREMENT for table `pending_withdraw`
--
ALTER TABLE `pending_withdraw`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `price`
--
ALTER TABLE `price`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `seller`
--
ALTER TABLE `seller`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
