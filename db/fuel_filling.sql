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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `momotr`
--

INSERT INTO `momotr` (`id`, `amount`, `number`, `user`, `status`, `time`) VALUES
(1, 100, '0788750979', '1', 'pending', '2022-10-09 04:30:54'),
(2, 100, '\'0788750979\'', '0', 'pending', '2022-11-19 22:33:17'),
(3, 100, '\'0788750979\'', '0', 'pending', '2022-11-19 22:34:10'),
(4, 100, '\'0788750979\'', '0', 'pending', '2022-11-19 22:34:23'),
(5, 100, '0788750979', '0', 'pending', '2022-11-19 22:38:20'),
(6, 100, '0788750979', '0', 'pending', '2022-11-19 22:41:35'),
(7, 100, '0788750979', '1', 'pending', '2022-11-19 23:18:59'),
(8, 100, '0788750979', '0', 'pending', '2022-11-25 09:38:56'),
(9, 100, '0788750979', '0', 'pending', '2022-11-25 09:41:31'),
(10, 100, '0788750979', '0', 'pending', '2022-11-25 09:47:05'),
(11, 100, '0788750979', '0', 'pending', '2022-11-25 09:47:55'),
(12, 100, '0788750979', '0', 'pending', '2022-11-25 09:49:09'),
(13, 100, '0788750979', '0', 'pending', '2022-11-25 09:49:42'),
(14, 100, '0788750979', '0', 'pending', '2022-11-25 09:50:46'),
(119, 1, '1', '0', 'pending', '2022-11-29 19:33:59'),
(120, 1, '1', '0', 'pending', '2022-11-29 19:34:19'),
(121, 1, '1', '0', 'pending', '2022-11-29 19:44:24'),
(122, 1, '1', '0', 'pending', '2022-11-29 19:44:25'),
(123, 1, '1', '0', 'pending', '2022-11-29 19:44:25'),
(124, 1, '1', '0', 'pending', '2022-11-29 19:44:26'),
(125, 1, '1', '0', 'pending', '2022-11-29 19:44:26'),
(126, 1, '1', '0', 'pending', '2022-11-29 19:44:26'),
(127, 1, '1', '0', 'pending', '2022-11-29 19:44:26'),
(128, 1, '1', '0', 'pending', '2022-11-29 19:44:26'),
(129, 1, '1', '0', 'pending', '2022-11-29 19:44:27'),
(130, 1, '1', '0', 'pending', '2022-11-29 19:44:27'),
(131, 1, '1', '0', 'pending', '2022-11-29 19:44:27'),
(132, 1, '1', '0', 'pending', '2022-11-29 19:44:27'),
(133, 1, '1', '0', 'pending', '2022-11-29 19:44:27'),
(134, 1, '1', '0', 'pending', '2022-11-29 19:44:27'),
(135, 1, '1', '0', 'pending', '2022-11-29 19:44:27'),
(136, 1, '1', '0', 'pending', '2022-11-29 19:44:27'),
(137, 1, '1', '0', 'pending', '2022-11-29 19:44:28'),
(138, 1, '1', '0', 'pending', '2022-11-29 19:44:28'),
(139, 1, '1', '0', 'pending', '2022-11-29 19:44:28'),
(140, 1, '1', '0', 'pending', '2022-11-29 19:44:28'),
(141, 1, '1', '0', 'pending', '2022-11-29 19:44:28'),
(142, 1, '1', '0', 'pending', '2022-11-29 19:44:28'),
(143, 1, '1', '0', 'pending', '2022-11-29 19:44:28'),
(144, 1, '1', '0', 'pending', '2022-11-29 19:44:29'),
(145, 1, '1', '0', 'pending', '2022-11-29 19:44:29'),
(146, 1, '1', '0', 'pending', '2022-11-29 19:44:29'),
(147, 1, '1', '0', 'pending', '2022-11-29 19:44:29'),
(148, 1, '1', '0', 'pending', '2022-11-29 19:44:29'),
(149, 1, '1', '0', 'pending', '2022-11-29 19:44:29'),
(150, 1, '1', '0', 'pending', '2022-11-29 19:44:29'),
(151, 1, '1', '0', 'pending', '2022-11-29 19:44:30'),
(152, 1, '1', '0', 'pending', '2022-11-29 19:44:30'),
(153, 1, '1', '0', 'pending', '2022-11-29 19:44:30'),
(154, 1, '1', '0', 'pending', '2022-11-29 19:44:30'),
(155, 1, '1', '0', 'pending', '2022-11-29 19:44:31'),
(156, 1, '1', '0', 'pending', '2022-11-29 19:44:31'),
(157, 1, '1', '0', 'pending', '2022-11-29 19:44:31'),
(158, 1, '1', '0', 'pending', '2022-11-29 19:44:31'),
(159, 1, '1', '0', 'pending', '2022-11-29 19:44:31'),
(160, 1, '1', '0', 'pending', '2022-11-29 19:44:31'),
(161, 1, '1', '0', 'pending', '2022-11-29 19:44:31'),
(162, 1, '1', '0', 'pending', '2022-11-29 19:44:32'),
(163, 1, '1', '0', 'pending', '2022-11-29 19:44:32'),
(164, 1, '1', '0', 'pending', '2022-11-29 19:44:32'),
(165, 1, '1', '0', 'pending', '2022-11-29 19:44:32'),
(166, 1, '1', '0', 'pending', '2022-11-29 19:44:32'),
(167, 1, '1', '0', 'pending', '2022-11-29 19:44:32'),
(168, 1, '1', '0', 'pending', '2022-11-29 19:44:33'),
(169, 1, '1', '0', 'pending', '2022-11-29 19:44:33'),
(170, 1, '1', '0', 'pending', '2022-11-29 19:44:33'),
(171, 1, '1', '0', 'pending', '2022-11-29 19:44:33'),
(172, 1, '1', '0', 'pending', '2022-11-29 19:44:33'),
(173, 1, '1', '0', 'pending', '2022-11-29 19:44:33'),
(174, 1, '1', '0', 'pending', '2022-11-29 19:44:33'),
(175, 1, '1', '0', 'pending', '2022-11-29 19:44:33'),
(176, 1, '1', '0', 'pending', '2022-11-29 19:44:33'),
(177, 1, '1', '0', 'pending', '2022-11-29 19:44:34'),
(178, 1, '1', '0', 'pending', '2022-11-29 19:44:34'),
(179, 1, '1', '0', 'pending', '2022-11-29 19:44:34'),
(180, 1, '1', '0', 'pending', '2022-11-29 19:44:34'),
(181, 1, '1', '0', 'pending', '2022-11-29 19:44:34'),
(182, 1, '1', '0', 'pending', '2022-11-29 19:44:34'),
(183, 1, '1', '0', 'pending', '2022-11-29 19:44:34'),
(184, 1, '1', '0', 'pending', '2022-11-29 19:44:34'),
(185, 1, '1', '0', 'pending', '2022-11-29 19:44:35'),
(186, 1, '1', '0', 'pending', '2022-11-29 19:44:35'),
(187, 1, '1', '0', 'pending', '2022-11-29 19:44:35'),
(188, 1, '1', '0', 'pending', '2022-11-29 19:44:35'),
(189, 1, '1', '0', 'pending', '2022-11-29 19:44:35'),
(190, 1, '1', '0', 'pending', '2022-11-29 19:44:35'),
(191, 1, '1', '0', 'pending', '2022-11-29 19:44:36'),
(192, 1, '1', '0', 'pending', '2022-11-29 19:44:36'),
(193, 1, '1', '0', 'pending', '2022-11-29 19:44:36'),
(194, 1, '1', '0', 'pending', '2022-11-29 19:44:36'),
(195, 1, '1', '0', 'pending', '2022-11-29 19:44:36'),
(196, 1, '1', '0', 'pending', '2022-11-29 19:44:36'),
(197, 1, '1', '0', 'pending', '2022-11-29 19:44:36'),
(198, 1, '1', '0', 'pending', '2022-11-29 19:44:37'),
(199, 1, '1', '0', 'pending', '2022-11-29 19:44:37'),
(200, 1, '1', '0', 'pending', '2022-11-29 19:44:37'),
(201, 1, '1', '0', 'pending', '2022-11-29 19:44:37'),
(202, 1, '1', '0', 'pending', '2022-11-29 19:44:37'),
(203, 1, '1', '0', 'pending', '2022-11-29 19:44:37'),
(204, 1, '1', '0', 'pending', '2022-11-29 19:44:37'),
(205, 1, '1', '0', 'pending', '2022-11-29 19:44:37'),
(206, 1, '1', '0', 'pending', '2022-11-29 19:44:38'),
(207, 1, '1', '0', 'pending', '2022-11-29 19:44:38'),
(208, 1, '1', '0', 'pending', '2022-11-29 19:44:38'),
(209, 1, '1', '0', 'pending', '2022-11-29 19:44:38'),
(210, 1, '1', '0', 'pending', '2022-11-29 19:44:38'),
(211, 1, '1', '0', 'pending', '2022-11-29 19:44:39'),
(212, 1, '1', '0', 'pending', '2022-11-29 19:44:39'),
(213, 1, '1', '0', 'pending', '2022-11-29 19:44:39'),
(214, 1, '1', '0', 'pending', '2022-11-29 19:44:39'),
(215, 1, '1', '0', 'pending', '2022-11-29 19:44:39'),
(216, 1, '1', '0', 'pending', '2022-11-29 19:44:39'),
(217, 1, '1', '0', 'pending', '2022-11-29 19:44:40'),
(218, 1, '1', '0', 'pending', '2022-11-29 19:44:40'),
(219, 1, '1', '0', 'pending', '2022-11-29 19:44:40'),
(220, 1, '1', '0', 'pending', '2022-11-29 19:44:40'),
(221, 1, '1', '0', 'pending', '2022-11-29 19:44:40'),
(222, 1, '1', '0', 'pending', '2022-11-29 19:44:40'),
(223, 1, '1', '0', 'pending', '2022-11-29 19:44:40'),
(224, 1, '1', '0', 'pending', '2022-11-29 19:44:40'),
(225, 1, '1', '0', 'pending', '2022-11-29 19:44:41'),
(226, 1, '1', '0', 'pending', '2022-11-29 19:44:41'),
(227, 1, '1', '0', 'pending', '2022-11-29 19:44:41'),
(228, 1, '1', '0', 'pending', '2022-11-29 19:44:41'),
(229, 1, '1', '0', 'pending', '2022-11-29 19:44:41'),
(230, 1, '1', '0', 'pending', '2022-11-29 19:44:41'),
(231, 1, '1', '0', 'pending', '2022-11-29 19:44:41'),
(232, 1, '1', '0', 'pending', '2022-11-29 19:44:41'),
(233, 1, '1', '0', 'pending', '2022-11-29 19:44:42'),
(234, 1, '1', '0', 'pending', '2022-11-29 19:44:42'),
(235, 1, '1', '0', 'pending', '2022-11-29 19:44:42'),
(236, 1, '1', '0', 'pending', '2022-11-29 19:44:42'),
(237, 1, '1', '0', 'pending', '2022-11-29 19:44:42'),
(238, 1, '1', '0', 'pending', '2022-11-29 19:44:42'),
(239, 1, '1', '0', 'pending', '2022-11-29 19:44:42'),
(240, 1, '1', '0', 'pending', '2022-11-29 19:44:42'),
(241, 1, '1', '0', 'pending', '2022-11-29 19:44:43'),
(242, 1, '1', '0', 'pending', '2022-11-29 19:44:43'),
(243, 1, '1', '0', 'pending', '2022-11-29 19:44:43'),
(244, 1, '1', '0', 'pending', '2022-11-29 19:44:43'),
(245, 1, '1', '0', 'pending', '2022-11-29 19:44:43'),
(246, 1, '1', '0', 'pending', '2022-11-29 19:44:43'),
(247, 1, '1', '0', 'pending', '2022-11-29 19:44:43'),
(248, 1, '1', '0', 'pending', '2022-11-29 19:44:44'),
(249, 1, '1', '0', 'pending', '2022-11-29 19:44:44'),
(250, 1, '1', '0', 'pending', '2022-11-29 19:44:44'),
(251, 1, '1', '0', 'pending', '2022-11-29 19:44:44'),
(252, 1, '1', '0', 'pending', '2022-11-29 19:44:44'),
(253, 1, '1', '0', 'pending', '2022-11-29 19:44:44'),
(254, 1, '1', '0', 'pending', '2022-11-29 19:44:44'),
(255, 1, '1', '0', 'pending', '2022-11-29 19:44:44'),
(256, 1, '1', '0', 'pending', '2022-11-29 19:44:44'),
(257, 1, '1', '0', 'pending', '2022-11-29 19:44:45'),
(258, 1, '1', '0', 'pending', '2022-11-29 19:44:45'),
(259, 1, '1', '0', 'pending', '2022-11-29 19:44:45'),
(260, 1, '1', '0', 'pending', '2022-11-29 19:44:45'),
(261, 1, '1', '0', 'pending', '2022-11-29 19:44:45'),
(262, 1, '1', '0', 'pending', '2022-11-29 19:44:45'),
(263, 1, '1', '0', 'pending', '2022-11-29 19:44:45'),
(264, 1, '1', '0', 'pending', '2022-11-29 19:44:45'),
(265, 1, '1', '0', 'pending', '2022-11-29 19:44:45'),
(266, 1, '1', '0', 'pending', '2022-11-29 19:44:46'),
(267, 1, '1', '0', 'pending', '2022-11-29 19:44:46'),
(268, 1, '1', '0', 'pending', '2022-11-29 19:44:46'),
(269, 1, '1', '0', 'pending', '2022-11-29 19:44:46'),
(270, 1, '1', '0', 'pending', '2022-11-29 19:44:46'),
(271, 1, '1', '0', 'pending', '2022-11-29 19:44:46'),
(272, 1, '1', '0', 'pending', '2022-11-29 19:44:46'),
(273, 1, '1', '0', 'pending', '2022-11-29 19:44:46'),
(274, 1, '1', '0', 'pending', '2022-11-29 19:44:47'),
(275, 1, '1', '0', 'pending', '2022-11-29 19:44:47'),
(276, 1, '1', '0', 'pending', '2022-11-29 19:44:47'),
(277, 1, '1', '0', 'pending', '2022-11-29 19:44:48'),
(278, 1, '1', '0', 'pending', '2022-11-29 19:44:48'),
(279, 1, '1', '0', 'pending', '2022-11-29 19:44:48'),
(280, 1, '1', '0', 'pending', '2022-11-29 19:44:49'),
(281, 1, '1', '0', 'pending', '2022-11-29 19:44:49'),
(282, 1, '1', '0', 'pending', '2022-11-29 19:44:49'),
(283, 1, '1', '0', 'pending', '2022-11-29 19:44:49'),
(284, 1, '1', '0', 'pending', '2022-11-29 19:44:49'),
(285, 1, '1', '0', 'pending', '2022-11-29 19:44:49'),
(286, 1, '1', '0', 'pending', '2022-11-29 19:44:49'),
(287, 1, '1', '0', 'pending', '2022-11-29 19:44:49'),
(288, 1, '1', '0', 'pending', '2022-11-29 19:44:49'),
(289, 1, '1', '0', 'pending', '2022-11-29 19:44:50'),
(290, 1, '1', '0', 'pending', '2022-11-29 19:44:50'),
(291, 1, '1', '0', 'pending', '2022-11-29 19:44:50'),
(292, 1, '1', '0', 'pending', '2022-11-29 19:44:50'),
(293, 1, '1', '0', 'pending', '2022-11-29 19:47:29'),
(294, 1, '1', '0', 'pending', '2022-11-29 19:47:36'),
(295, 100, '0788750979', '0', 'pending', '2022-11-29 20:48:13'),
(296, 100, '0788750979', '0', 'pending', '2022-11-29 20:49:17'),
(297, 150, '0788750979', '0', 'pending', '2022-11-29 20:52:44'),
(298, 200, '0788750979', '0', 'pending', '2022-11-29 20:54:18'),
(299, 150, '0788750979', '0', 'pending', '2022-11-29 21:06:00'),
(300, 150, '0788750979', '0', 'pending', '2022-11-29 21:24:36'),
(301, 200, '0788750979', '0', 'pending', '2022-11-29 21:25:57'),
(302, 100, '0788750979', '0', 'pending', '2022-11-29 21:32:03'),
(303, 150, '0788750979', '0', 'pending', '2022-11-29 21:37:05'),
(304, 150, '0788750979', '0', 'pending', '2022-11-29 22:00:19'),
(305, 150, '0788750979', '0', 'pending', '2022-11-29 22:30:47'),
(306, 150, '0788750979', '0', 'pending', '2022-11-29 23:05:29'),
(307, 255, '0788750979', '0', 'pending', '2022-11-29 23:35:37'),
(308, 588, '0788750979', '0', 'pending', '2022-11-29 23:38:25'),
(309, 588, '0788695', '0', 'pending', '2022-12-03 23:13:05'),
(310, 200, '0788216944', '0', 'pending', '2022-12-03 23:14:04'),
(311, 222, '5555', '0', 'pending', '2022-12-03 23:21:35'),
(312, 58, '888', '0', 'pending', '2022-12-03 23:29:17'),
(313, 200, '0788216944', '0', 'pending', '2022-12-03 23:35:10'),
(314, 555, '078875', '0', 'pending', '2022-12-03 23:43:41'),
(315, 200, '0788216944', '0', 'pending', '2022-12-03 23:55:03'),
(316, 200, '0788216944', '0', 'pending', '2022-12-03 23:59:05'),
(317, 200, '0788216944', '0', 'pending', '2022-12-04 00:13:51'),
(318, 200, '0788750979', '0', 'pending', '2022-12-06 01:52:00'),
(319, 200, '0788750979', '0', 'pending', '2022-12-06 01:56:25'),
(320, 200, '0788750979', '0', 'pending', '2022-12-06 01:57:33'),
(321, 200, '0788750979', '0', 'pending', '2022-12-06 02:09:01'),
(322, 200, '0788750979', '0', 'pending', '2022-12-06 02:19:02'),
(323, 200, '0788750979', '0', 'pending', '2022-12-06 02:24:27'),
(324, 200, '0788750979', '0', 'pending', '2022-12-06 02:37:09'),
(325, 200, '0788750979', '0', 'pending', '2022-12-06 02:46:38'),
(326, 200, '0788750979', '0', 'pending', '2022-12-06 02:49:20'),
(327, 200, '0788750979', '0', 'pending', '2022-12-06 02:53:41'),
(328, 200, '0788750979', '0', 'pending', '2022-12-06 02:56:45'),
(329, 5555, '07880985', '0', 'pending', '2022-12-06 02:59:25'),
(330, 200, '0788750979', '0', 'pending', '2022-12-06 03:01:16'),
(331, 300, '0788750979', '0', 'pending', '2022-12-06 03:06:20'),
(332, 2000, '0788750979', '0', 'pending', '2022-12-06 03:06:32'),
(333, 500, '0788750979', '0', 'pending', '2022-12-06 03:07:43'),
(334, 69, '055', '0', 'pending', '2022-12-06 03:08:20'),
(335, 588, '0788750979', '0', 'pending', '2022-12-06 03:10:30'),
(336, 555, '07880979', '0', 'pending', '2022-12-06 03:12:16'),
(337, 200, '0788750979', '0', 'pending', '2022-12-06 08:13:16'),
(338, 100, '0788750979', '0', 'pending', '2022-12-06 08:16:00'),
(339, 100, '0788750979', '0', 'pending', '2022-12-06 08:17:08'),
(340, 100, '0788750979', '0', 'pending', '2022-12-06 08:19:51'),
(341, 100, '0788750979', '0', 'pending', '2022-12-06 08:20:26'),
(342, 100, '0788750979', '0', 'pending', '2022-12-06 08:21:07'),
(343, 100, '0788750979', '0', 'pending', '2022-12-06 08:21:50'),
(344, 200, '0788750979', '0', 'pending', '2022-12-06 08:24:38'),
(345, 1000, '0788750979', '0', 'pending', '2022-12-06 08:26:17'),
(346, 150, '0788750979', '0', 'pending', '2022-12-06 08:30:21'),
(347, 200, '0788750979', '0', 'pending', '2022-12-06 08:52:34'),
(348, 100, '0788750979', '0', 'pending', '2022-12-06 11:54:55'),
(349, 100, '0788750979', '0', 'pending', '2022-12-19 21:12:04'),
(350, 100, '0788750979', '0', 'pending', '2022-12-19 21:13:55'),
(351, 100, '0788750979', '0', 'pending', '2022-12-19 21:17:04'),
(352, 70, '07887097', '0', 'pending', '2022-12-19 21:17:22');

-- --------------------------------------------------------

--
-- Table structure for table `pending_withdraw`
--

CREATE TABLE `pending_withdraw` (
  `id` int NOT NULL,
  `seller` int NOT NULL,
  `amount` int NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  `ml` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
