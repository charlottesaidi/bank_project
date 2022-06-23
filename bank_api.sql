-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 23 juin 2022 à 22:30
-- Version du serveur :  10.4.18-MariaDB
-- Version de PHP : 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bank_api`
--

CREATE DATABASE IF NOT EXISTS `bank_api` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bank_api`;

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `throwExceptionIfWeekend` ()  BEGIN
    SET @today = DAYOFWEEK(NOW());
    SET @current_hour = DATE_FORMAT(NOW(), "%T");
    SET @error_message = 'Vous ne pouvez pas enregistrer de client ou de compte en dehors des jours ouvrés';
    IF (@today = 7 AND @current_hour > '12:00:00')
    OR @today = 1
    OR (@today = 2 AND @current_hour < '12:00:00') THEN
        signal sqlstate '42000' set MESSAGE_TEXT = @error_message;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `accounts`
--

CREATE TABLE `accounts` (
  `id_account` int(11) NOT NULL,
  `balance` float NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `hashid` varchar(255) DEFAULT NULL,
  `overdraft` float NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id_account_type` int(11) DEFAULT NULL,
  `id_customer` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `accounts`
--

INSERT INTO `accounts` (`id_account`, `balance`, `created_at`, `hashid`, `overdraft`, `updated_at`, `id_account_type`, `id_customer`) VALUES
(8, -320.25, '2022-06-23 11:55:14', 'CUR2768957', -1000, NULL, 1, 7),
(15, 1182.32, '2022-06-23 11:55:15', 'CUR8485583', -1000, '2022-06-23 22:26:49', 1, 14),
(20, -10.36, '2022-06-23 11:55:16', 'CUR2091208', -1000, NULL, 1, 19),
(25, 2488, '2022-06-23 11:55:16', 'CUR6033326', -1000, NULL, 1, 24),
(30, 2063, '2022-06-23 11:55:17', 'CUR8692462', -1000, NULL, 1, 29),
(35, -134.97, '2022-06-23 11:55:18', 'CUR8779639', -1000, NULL, 1, 34),
(40, 534, '2022-06-23 11:55:19', 'CUR2715144', -1000, NULL, 1, 39),
(45, 741, '2021-06-23 11:55:19', 'CUR0709146', -1000, NULL, 1, 44),
(50, 181, '2022-06-23 11:55:20', 'CUR2876131', -1000, NULL, 1, 49),
(55, 2799, '2022-06-23 11:55:21', 'CUR6834339', -1000, NULL, 1, 54),
(60, 2879, '2022-06-23 11:55:22', 'CUR4469784', -1000, NULL, 1, 59),
(65, 1591, '2022-06-23 11:55:22', 'CUR6018134', -1000, NULL, 1, 64),
(70, 2951, '2022-06-23 11:55:23', 'CUR0157006', -1000, NULL, 1, 69),
(75, 2335, '2022-06-23 11:55:24', 'CUR0683560', -1000, NULL, 1, 74),
(80, 2413, '2022-06-23 11:55:24', 'CUR9325712', -1000, NULL, 1, 79),
(85, 794, '2022-06-23 11:55:25', 'CUR2576784', -1000, NULL, 1, 84),
(90, 608, '2022-06-23 11:55:26', 'CUR9022865', -1000, NULL, 1, 89),
(95, 1511, '2022-06-23 11:55:27', 'CUR7692981', -1000, NULL, 1, 94),
(100, 2556, '2022-06-23 11:55:28', 'CUR8082368', -1000, NULL, 1, 99),
(105, 969, '2022-06-23 11:55:28', 'CUR8918390', -1000, NULL, 1, 104),
(110, 2590, '2022-06-23 11:55:29', 'CUR9408155', -1000, NULL, 1, 109),
(115, 2517, '2022-06-23 11:55:30', 'CUR7156033', -1000, NULL, 1, 114),
(120, 1019, '2022-06-23 11:55:30', 'CUR6219965', -1000, NULL, 1, 119),
(125, 1760, '2022-06-23 11:55:31', 'CUR0758241', -1000, NULL, 1, 124),
(130, 790, '2022-06-23 11:55:32', 'CUR1483372', -1000, NULL, 1, 129),
(135, 482, '2022-06-23 11:55:33', 'CUR3685609', -1000, NULL, 1, 134),
(140, 2029, '2022-06-23 11:55:33', 'CUR8983207', -1000, NULL, 1, 139),
(145, 2522, '2022-06-23 11:55:34', 'CUR8345576', -1000, NULL, 1, 144),
(150, 1153, '2022-06-23 11:55:35', 'CUR7207029', -1000, NULL, 1, 149),
(155, 481, '2022-06-23 11:55:36', 'CUR8318332', -1000, NULL, 1, 154),
(160, 1229, '2022-06-23 11:55:36', 'CUR0098009', -1000, NULL, 1, 159),
(163, 800, '2022-06-23 14:38:31', 'LVA1653275', -100, NULL, 3, 7),
(166, -50, '2022-06-23 18:31:32', 'LDD3265044', -100, NULL, 2, 7),
(169, 280, '2022-06-23 18:34:23', 'LDD7434479', -500, '2022-06-23 22:28:20', 2, 14),
(172, -5, '2022-06-23 18:37:37', 'LVA1950260', -300, NULL, 3, 19);

-- --------------------------------------------------------

--
-- Structure de la table `account_balances`
--

CREATE TABLE `account_balances` (
  `id_account_balance` int(11) NOT NULL,
  `balance` float NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id_account` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `account_balances`
--

INSERT INTO `account_balances` (`id_account_balance`, `balance`, `created_at`, `updated_at`, `id_account`) VALUES
(10, -320.25, '2022-06-23 11:55:14', NULL, 8),
(17, 1182.32, '2022-06-23 11:55:15', '2022-06-23 22:26:49', 15),
(22, -10.36, '2022-06-23 11:55:16', NULL, 20),
(27, 2488, '2022-06-23 11:55:16', NULL, 25),
(32, 2063, '2022-06-23 11:55:17', NULL, 30),
(37, -134.97, '2022-06-23 11:55:18', NULL, 35),
(42, 534, '2022-06-23 11:55:19', NULL, 40),
(47, 741, '2022-06-23 11:55:19', NULL, 45),
(52, 181, '2022-06-23 11:55:20', NULL, 50),
(57, 2799, '2022-06-23 11:55:21', NULL, 55),
(62, 2879, '2022-06-23 11:55:22', NULL, 60),
(67, 1591, '2022-06-23 11:55:22', NULL, 65),
(72, 2951, '2022-06-23 11:55:23', NULL, 70),
(77, 2335, '2022-06-23 11:55:24', NULL, 75),
(82, 2413, '2022-06-23 11:55:24', NULL, 80),
(87, 794, '2022-06-23 11:55:25', NULL, 85),
(92, 608, '2022-06-23 11:55:26', NULL, 90),
(97, 1511, '2022-06-23 11:55:27', NULL, 95),
(102, 2556, '2022-06-23 11:55:28', NULL, 100),
(107, 969, '2022-06-23 11:55:28', NULL, 105),
(112, 2590, '2022-06-23 11:55:29', NULL, 110),
(117, 2517, '2022-06-23 11:55:30', NULL, 115),
(122, 1019, '2022-06-23 11:55:30', NULL, 120),
(127, 1760, '2022-06-23 11:55:31', NULL, 125),
(132, 790, '2022-06-23 11:55:32', NULL, 130),
(137, 482, '2022-06-23 11:55:33', NULL, 135),
(142, 2029, '2022-06-23 11:55:33', NULL, 140),
(147, 2522, '2022-06-23 11:55:34', NULL, 145),
(152, 1153, '2022-06-23 11:55:35', NULL, 150),
(157, 481, '2022-06-23 11:55:36', NULL, 155),
(162, 1229, '2022-06-23 11:55:36', NULL, 160),
(165, 800, '2022-06-23 14:38:31', NULL, 163),
(168, -50, '2022-06-23 18:31:32', NULL, 166),
(171, 280, '2022-06-23 18:34:23', '2022-06-23 22:28:20', 169),
(174, -5, '2022-06-23 18:37:37', NULL, 172);

-- --------------------------------------------------------

--
-- Structure de la table `account_types`
--

CREATE TABLE `account_types` (
  `id_account_type` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `rate` float NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `account_types`
--

INSERT INTO `account_types` (`id_account_type`, `created_at`, `name`, `rate`, `updated_at`) VALUES
(1, '2022-06-23 11:55:11', 'CPT_COURANT', 0, NULL),
(2, '2022-06-23 11:55:12', 'LIVRET_DEVELOPPEMENT_DURABLE', 0.6, NULL),
(3, '2022-06-23 11:55:12', 'LIVRET_A', 0.3, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `bankers`
--

CREATE TABLE `bankers` (
  `id_banker` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `hashid` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `bankers`
--

INSERT INTO `bankers` (`id_banker`, `created_at`, `hashid`, `updated_at`, `id_user`) VALUES
(5, '2022-06-23 11:55:14', '9284513410', NULL, 4),
(12, '2022-06-23 11:55:14', '2149611413', NULL, 11);

-- --------------------------------------------------------

--
-- Structure de la table `cards`
--

CREATE TABLE `cards` (
  `id_card` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `cvc` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `validity_date` datetime DEFAULT NULL,
  `id_account` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `cards`
--

INSERT INTO `cards` (`id_card`, `created_at`, `cvc`, `number`, `updated_at`, `validity_date`, `id_account`) VALUES
(9, '2022-06-23 11:55:14', '816', '1607276454663450', NULL, '2024-06-23 11:55:14', 8),
(16, '2022-06-23 11:55:15', '244', '4043235419787982', NULL, '2024-06-23 11:55:15', 15),
(21, '2022-06-23 11:55:16', '101', '6030331349822552', NULL, '2024-06-23 11:55:16', 20),
(26, '2022-06-23 11:55:16', '751', '0216262633377042', NULL, '2024-06-23 11:55:16', 25),
(31, '2022-06-23 11:55:17', '894', '8730664736910616', NULL, '2024-06-23 11:55:17', 30),
(36, '2022-06-23 11:55:18', '269', '9223687038894708', NULL, '2024-06-23 11:55:18', 35),
(41, '2022-06-23 11:55:19', '065', '9408361394675970', NULL, '2024-06-23 11:55:19', 40),
(46, '2022-06-23 11:55:19', '101', '9297038560878235', NULL, '2024-06-23 11:55:19', 45),
(51, '2022-06-23 11:55:20', '859', '6936242366624018', NULL, '2024-06-23 11:55:20', 50),
(56, '2022-06-23 11:55:21', '890', '7617285671882042', NULL, '2024-06-23 11:55:21', 55),
(61, '2022-06-23 11:55:22', '413', '3384249848301493', NULL, '2024-06-23 11:55:22', 60),
(66, '2022-06-23 11:55:22', '985', '4295289222703790', NULL, '2024-06-23 11:55:22', 65),
(71, '2022-06-23 11:55:23', '537', '3326439390519277', NULL, '2024-06-23 11:55:23', 70),
(76, '2022-06-23 11:55:24', '753', '1339674964934610', NULL, '2024-06-23 11:55:24', 75),
(81, '2022-06-23 11:55:24', '054', '3797575016969235', NULL, '2024-06-23 11:55:24', 80),
(86, '2022-06-23 11:55:25', '978', '7359692482139523', NULL, '2024-06-23 11:55:25', 85),
(91, '2022-06-23 11:55:26', '016', '2798071809858716', NULL, '2024-06-23 11:55:26', 90),
(96, '2022-06-23 11:55:27', '087', '7644648485240018', NULL, '2024-06-23 11:55:27', 95),
(101, '2022-06-23 11:55:28', '417', '0479470397823572', NULL, '2024-06-23 11:55:28', 100),
(106, '2022-06-23 11:55:28', '126', '7668217438257515', NULL, '2024-06-23 11:55:28', 105),
(111, '2022-06-23 11:55:29', '303', '0596219261612731', NULL, '2024-06-23 11:55:29', 110),
(116, '2022-06-23 11:55:30', '520', '1033055780708356', NULL, '2024-06-23 11:55:30', 115),
(121, '2022-06-23 11:55:30', '295', '5576740704324570', NULL, '2024-06-23 11:55:30', 120),
(126, '2022-06-23 11:55:31', '504', '0500024967599877', NULL, '2024-06-23 11:55:31', 125),
(131, '2022-06-23 11:55:32', '616', '9382368513507699', NULL, '2024-06-23 11:55:32', 130),
(136, '2022-06-23 11:55:33', '863', '2533536795067502', NULL, '2024-06-23 11:55:33', 135),
(141, '2022-06-23 11:55:33', '298', '9701118900570322', NULL, '2024-06-23 11:55:33', 140),
(146, '2022-06-23 11:55:34', '321', '9083016881001482', NULL, '2024-06-23 11:55:34', 145),
(151, '2022-06-23 11:55:35', '089', '2958268844155213', NULL, '2024-06-23 11:55:35', 150),
(156, '2022-06-23 11:55:36', '953', '4109507636944370', NULL, '2024-06-23 11:55:36', 155),
(161, '2022-06-23 11:55:36', '186', '6903819550103018', NULL, '2024-06-23 11:55:36', 160),
(164, '2022-06-23 14:38:31', '918', '3777884487329686', NULL, '2024-06-23 14:38:31', 163),
(167, '2022-06-23 18:31:32', '471', '1932657466281218', NULL, '2024-06-23 18:31:32', 166),
(170, '2022-06-23 18:34:23', '563', '0506017672923643', NULL, '2024-06-23 18:34:23', 169),
(173, '2022-06-23 18:37:37', '129', '4678322450535144', NULL, '2024-06-23 18:37:37', 172);

-- --------------------------------------------------------

--
-- Structure de la table `changing_rate_dates`
--

CREATE TABLE `changing_rate_dates` (
  `id_changing_rate_date` int(11) NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `start_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `changing_rate_dates`
--

INSERT INTO `changing_rate_dates` (`id_changing_rate_date`, `end_date`, `start_date`) VALUES
(178, '2022-12-06 01:00:00', '2022-12-01 01:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `customers`
--

CREATE TABLE `customers` (
  `id_customer` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `document_date` datetime DEFAULT NULL,
  `hashid` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id_banker` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `customers`
--

INSERT INTO `customers` (`id_customer`, `created_at`, `document_date`, `hashid`, `updated_at`, `id_banker`, `id_user`) VALUES
(7, '2022-06-23 11:55:14', NULL, '6935929946', NULL, 5, 6),
(14, '2022-06-23 11:55:15', NULL, '1767424448', NULL, 5, 13),
(19, '2022-06-23 11:55:16', NULL, '5046105078', NULL, 5, 18),
(24, '2022-06-23 11:55:16', NULL, '3946569098', NULL, 5, 23),
(29, '2022-06-23 11:55:17', NULL, '2285547680', NULL, 5, 28),
(34, '2022-06-23 11:55:18', NULL, '8924847955', NULL, 5, 33),
(39, '2022-06-23 11:55:19', NULL, '0770106123', NULL, 5, 38),
(44, '2022-06-23 11:55:19', NULL, '6479509757', NULL, 5, 43),
(49, '2022-06-23 11:55:20', NULL, '7039217898', NULL, 5, 48),
(54, '2022-06-23 11:55:21', NULL, '1154757017', NULL, 5, 53),
(59, '2022-06-23 11:55:22', NULL, '8639065037', NULL, 5, 58),
(64, '2022-06-23 11:55:22', NULL, '3657976142', NULL, 5, 63),
(69, '2022-06-23 11:55:23', NULL, '2390257579', NULL, 5, 68),
(74, '2022-06-23 11:55:24', NULL, '3660623358', NULL, 5, 73),
(79, '2022-06-23 11:55:24', NULL, '1590869739', NULL, 5, 78),
(84, '2022-06-23 11:55:25', NULL, '2228646481', NULL, 5, 83),
(89, '2022-06-23 11:55:26', NULL, '3187629114', NULL, 5, 88),
(94, '2022-06-23 11:55:27', NULL, '2693871211', NULL, 5, 93),
(99, '2022-06-23 11:55:28', NULL, '2298802442', NULL, 5, 98),
(104, '2022-06-23 11:55:28', NULL, '8415278309', NULL, 5, 103),
(109, '2022-06-23 11:55:29', NULL, '1710942759', NULL, 5, 108),
(114, '2022-06-23 11:55:30', NULL, '4580748725', NULL, 5, 113),
(119, '2022-06-23 11:55:30', NULL, '3792273044', NULL, 5, 118),
(124, '2022-06-23 11:55:31', NULL, '7196790637', NULL, 5, 123),
(129, '2022-06-23 11:55:32', NULL, '3740956873', NULL, 5, 128),
(134, '2022-06-23 11:55:33', NULL, '5983596433', NULL, 5, 133),
(139, '2022-06-23 11:55:33', NULL, '1918863673', NULL, 5, 138),
(144, '2022-06-23 11:55:34', NULL, '5682081085', NULL, 5, 143),
(149, '2022-06-23 11:55:35', NULL, '0148600435', NULL, 5, 148),
(154, '2022-06-23 11:55:36', NULL, '4048517678', NULL, 5, 153),
(159, '2022-06-23 11:55:36', NULL, '7663141353', NULL, 5, 158);

-- --------------------------------------------------------

--
-- Structure de la table `customer_document_type`
--

CREATE TABLE `customer_document_type` (
  `customer_id_customer` int(11) NOT NULL,
  `document_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `customer_document_type`
--

INSERT INTO `customer_document_type` (`customer_id_customer`, `document_type`) VALUES
(7, 'attestation_domicile'),
(7, 'piece_id'),
(7, 'avis_impots'),
(14, 'attestation_domicile'),
(14, 'piece_id'),
(14, 'avis_impots'),
(19, 'attestation_domicile'),
(19, 'piece_id'),
(19, 'avis_impots'),
(24, 'attestation_domicile'),
(24, 'piece_id'),
(24, 'avis_impots'),
(29, 'attestation_domicile'),
(29, 'piece_id'),
(29, 'avis_impots'),
(34, 'attestation_domicile'),
(34, 'piece_id'),
(34, 'avis_impots'),
(39, 'attestation_domicile'),
(39, 'piece_id'),
(39, 'avis_impots'),
(44, 'attestation_domicile'),
(44, 'piece_id'),
(44, 'avis_impots'),
(49, 'attestation_domicile'),
(49, 'piece_id'),
(49, 'avis_impots'),
(54, 'attestation_domicile'),
(54, 'piece_id'),
(54, 'avis_impots'),
(59, 'attestation_domicile'),
(59, 'piece_id'),
(59, 'avis_impots'),
(64, 'attestation_domicile'),
(64, 'piece_id'),
(64, 'avis_impots'),
(69, 'attestation_domicile'),
(69, 'piece_id'),
(69, 'avis_impots'),
(74, 'attestation_domicile'),
(74, 'piece_id'),
(74, 'avis_impots'),
(79, 'attestation_domicile'),
(79, 'piece_id'),
(79, 'avis_impots'),
(84, 'attestation_domicile'),
(84, 'piece_id'),
(84, 'avis_impots'),
(89, 'attestation_domicile'),
(89, 'piece_id'),
(89, 'avis_impots'),
(94, 'attestation_domicile'),
(94, 'piece_id'),
(94, 'avis_impots'),
(99, 'attestation_domicile'),
(99, 'piece_id'),
(99, 'avis_impots'),
(104, 'attestation_domicile'),
(104, 'piece_id'),
(104, 'avis_impots'),
(109, 'attestation_domicile'),
(109, 'piece_id'),
(109, 'avis_impots'),
(114, 'attestation_domicile'),
(114, 'piece_id'),
(114, 'avis_impots'),
(119, 'attestation_domicile'),
(119, 'piece_id'),
(119, 'avis_impots'),
(124, 'attestation_domicile'),
(124, 'piece_id'),
(124, 'avis_impots'),
(129, 'attestation_domicile'),
(129, 'piece_id'),
(129, 'avis_impots'),
(134, 'attestation_domicile'),
(134, 'piece_id'),
(134, 'avis_impots'),
(139, 'attestation_domicile'),
(139, 'piece_id'),
(139, 'avis_impots'),
(144, 'attestation_domicile'),
(144, 'piece_id'),
(144, 'avis_impots'),
(149, 'attestation_domicile'),
(149, 'piece_id'),
(149, 'avis_impots'),
(154, 'attestation_domicile'),
(154, 'piece_id'),
(154, 'avis_impots'),
(159, 'attestation_domicile'),
(159, 'piece_id'),
(159, 'avis_impots');

-- --------------------------------------------------------

--
-- Structure de la table `hibernate_sequence`
--

CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `hibernate_sequence`
--

INSERT INTO `hibernate_sequence` (`next_val`) VALUES
(179);

-- --------------------------------------------------------

--
-- Structure de la table `transactions`
--

CREATE TABLE `transactions` (
  `id_transaction` int(11) NOT NULL,
  `amount` float NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id_account_credit` int(11) DEFAULT NULL,
  `id_account_debit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `transactions`
--

INSERT INTO `transactions` (`id_transaction`, `amount`, `created_at`, `label`, `updated_at`, `id_account_credit`, `id_account_debit`) VALUES
(175, 250, '2022-06-23 22:26:49', 'Retrait CB', NULL, NULL, 15),
(176, 53.68, '2022-06-23 22:27:08', 'Carrefour Market', NULL, NULL, 15),
(177, 300, '2022-06-23 22:28:20', 'Epargne', NULL, 169, 15);

-- --------------------------------------------------------

--
-- Structure de la table `transaction_description`
--

CREATE TABLE `transaction_description` (
  `transaction_id_transaction` int(11) NOT NULL,
  `description` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `transaction_description`
--

INSERT INTO `transaction_description` (`transaction_id_transaction`, `description`) VALUES
(175, 1),
(176, 1),
(177, 0);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `address_city` varchar(255) DEFAULT NULL,
  `address_country` varchar(255) DEFAULT NULL,
  `address_street` varchar(255) DEFAULT NULL,
  `address_zipcode` varchar(255) DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `address_city`, `address_country`, `address_street`, `address_zipcode`, `birthdate`, `created_at`, `email`, `first_name`, `last_name`, `password`, `phone`, `updated_at`, `username`) VALUES
(4, 'Mulhouse', 'France', '69 Allée, Voie Pierre Charron', '86346', '1990-01-01 00:00:00', '2022-06-23 11:55:14', 'romain.moreau@banker.fr', 'Romain', 'Moreau', '$2a$12$XUH2jyuUkNS/cmTSi2oem.5ZmsDjG82gPZx5Ip.XWvYP3gPnzDiZ6', '0378184582', NULL, '9284513410'),
(6, 'Amiens', 'France', '94 Allée, Voie d Alésia', '36589', '1990-01-01 00:00:00', '2022-06-23 11:55:14', 'julie.giraud@customer.fr', 'Julie', 'Giraud', '$2a$12$eUct5VDJk8gyfuOeFmbjG.0/t7MU.wxeIuAAgwaHzziixJq1Q54CC', '0496222764', NULL, '6935929946'),
(11, 'Villeneuve-d Ascq', 'France', '28 Rue Mouffetard', '95147', '1990-01-01 00:00:00', '2022-06-23 11:55:14', 'lena.masson@director.fr', 'Lena', 'Masson', '$2a$12$jJsUueEIuFfjkBPmCkjCLO4z0lOYYHOwRZe.GR1xG8E8szLm62zGa', '0278995066', NULL, '2149611413'),
(13, 'La Seyne-sur-Mer', 'France', '4 Impasse de Seine', '07603', '1990-01-01 00:00:00', '2022-06-23 11:55:15', 'mathéo.louis@examplemail.fr', 'Pauline', 'Gerard', '$2a$12$IVec5boZ.p6/CNb8WaXGTuHOGws4hg5pZmxg.uRzDn7qKZaONnu5y', '0099164083', NULL, '1767424448'),
(18, 'Nancy', 'France', '217 Passage des Rosiers', '17101', '1990-01-01 00:00:00', '2022-06-23 11:55:16', 'tom.rousseau@examplemail.fr', 'Raphaël', 'David', '$2a$12$H6WXlmi7En7JlZAWH7nW3.X.shOReq4Mk3DaJ2gO6D4rIbCc0365O', '0997208372', NULL, '5046105078'),
(23, 'Champigny-sur-Marne', 'France', '310 Quai Mouffetard', '39603', '1990-01-01 00:00:00', '2022-06-23 11:55:16', 'ambre.da silva@examplemail.fr', 'Enzo', 'Rousseau', '$2a$12$McmokVRdK1dSlMBoyGoXJOEtFhjMJ3I74dUi4l4c/ObJ47Oh80Guu', '0541824052', NULL, '3946569098'),
(28, 'Saint-Nazaire', 'France', '8 Rue de la Harpe', '08418', '1990-01-01 00:00:00', '2022-06-23 11:55:17', 'marie.schneider@examplemail.fr', 'Emilie', 'Moreau', '$2a$12$q4VCJcccCq9k263KTmkjSuVfEyqhs5q7Taol56vDTHgLowXKYHSSy', '0921228439', NULL, '2285547680'),
(33, 'Le Tampon', 'France', '8726 Avenue de Provence', '52608', '1990-01-01 00:00:00', '2022-06-23 11:55:18', 'ethan.renault@examplemail.fr', 'Maxime', 'Dumont', '$2a$12$dbA2n/cEjhEKGrq7sWxzYuCdJsMGOBO3XKz5HUeR4tPhwBXElngYW', '0333385081', NULL, '8924847955'),
(38, 'Antibes', 'France', '83 Boulevard d Alésia', '56910', '1990-01-01 00:00:00', '2022-06-23 11:55:19', 'lou.marchand@examplemail.fr', 'Clémence', 'Morin', '$2a$12$snJnc11pQNBeiwGBpEy.NObQ5N.wkb5Ry5M5s0sBEI/4rJL2KTV.O', '0643249569', NULL, '0770106123'),
(43, 'Argenteuil', 'France', '188 Allée, Voie de l Odéon', '33486', '1990-01-01 00:00:00', '2022-06-23 11:55:19', 'océane.fleury@examplemail.fr', 'Gabriel', 'Gauthier', '$2a$12$8lPlm6O1tV4vPctMH7mDue80hrpdKuY6bGs3BjutGzEIkZDZIzA0K', '0648689784', NULL, '6479509757'),
(48, 'Colombes', 'France', '17 Avenue Dauphine', '37230', '1990-01-01 00:00:00', '2022-06-23 11:55:20', 'yanis.morin@examplemail.fr', 'Elisa', 'Renard', '$2a$12$ZQdLWTdIjGryy1FQxCleu.o2gBcx1Q0iNpnmPJnvpCzsCTEROkiHS', '0969277025', NULL, '7039217898'),
(53, 'Toulouse', 'France', '28 Impasse Saint-Dominique', '70471', '1990-01-01 00:00:00', '2022-06-23 11:55:21', 'adrien.boyer@examplemail.fr', 'Louna', 'Muller', '$2a$12$5wVO7ZXBrH6jy6TuYVzpZuy2OBCdkKuT45pasYD3asZMg3Ixfb4Zi', '0840800063', NULL, '1154757017'),
(58, 'Pessac', 'France', '29 Passage du Bac', '48587', '1990-01-01 00:00:00', '2022-06-23 11:55:22', 'mael.michel@examplemail.fr', 'Pierre', 'Bernard', '$2a$12$khAhnro.14F1ytGl4RuKyuHWirlMyNl6DKnM91sc6DzzAUtqwqRT6', '0381111907', NULL, '8639065037'),
(63, 'Tours', 'France', '05 Rue Marcadet', '01011', '1990-01-01 00:00:00', '2022-06-23 11:55:22', 'juliette.berger@examplemail.fr', 'Julie', 'Rodriguez', '$2a$12$ZcemUI6YA26FtS8mIp0Uo.bpkrKDxdEdnu7K05j6pMFBnvchBEwjO', '0445092054', NULL, '3657976142'),
(68, 'Montreuil', 'France', '8630 Quai Zadkine', '01349', '1990-01-01 00:00:00', '2022-06-23 11:55:23', 'nathan.colin@examplemail.fr', 'Gabriel', 'Gonzalez', '$2a$12$026.DWWvmC8uaxDM9fzeQOzsBV473x661puClZL9Axcc.M.M6eKHa', '0784557845', NULL, '2390257579'),
(73, 'Aix-en-Provence', 'France', '7 Rue d Assas', '30444', '1990-01-01 00:00:00', '2022-06-23 11:55:24', 'lou.dubois@examplemail.fr', 'Victor', 'Gerard', '$2a$12$Pno5UlD.h8q6wUfolPmBLO25N0i285nfKKOpakqJt48bKl389msRC', '0947985914', NULL, '3660623358'),
(78, 'Ivry-sur-Seine', 'France', '7221 Place du Faubourg Saint-Honoré', '79541', '1990-01-01 00:00:00', '2022-06-23 11:55:24', 'alice.deschamps@examplemail.fr', 'Nathan', 'Brunet', '$2a$12$21TTCAGqn53bo78G6ExGS.AQ8sa/cT6dCVwVUneJFcljGrfrpYzc2', '0340305964', NULL, '1590869739'),
(83, 'Noisy-le-Grand', 'France', '910 Impasse des Grands Augustins', '60945', '1990-01-01 00:00:00', '2022-06-23 11:55:25', 'yanis.masson@examplemail.fr', 'Raphaël', 'Cousin', '$2a$12$.oLXTuN5JA5YBKtZmnrXjuMz88aU2ecccufbOzFGUb.POVyBZRfRm', '0146853582', NULL, '2228646481'),
(88, 'Orléans', 'France', '2740 Boulevard Mouffetard', '38609', '1990-01-01 00:00:00', '2022-06-23 11:55:26', 'mathilde.rolland@examplemail.fr', 'Adam', 'Meunier', '$2a$12$saC2JqKtKUw60wPs/hRcPOcRSDmb/K/RF37s06.PgypbMWuBosEK.', '0249752995', NULL, '3187629114'),
(93, 'Lorient', 'France', '45 Place d Orsel', '63566', '1990-01-01 00:00:00', '2022-06-23 11:55:27', 'sacha.michel@examplemail.fr', 'Léa', 'Lambert', '$2a$12$KcpVVG7LpcRjuuiU5PMp8.hXAi5SP40d2SQQs6GcbiquWC9jVdjee', '0127488389', NULL, '2693871211'),
(98, 'Courbevoie', 'France', '040 Boulevard Saint-Séverin', '33590', '1990-01-01 00:00:00', '2022-06-23 11:55:28', 'zoe.robin@examplemail.fr', 'Justine', 'Blanchard', '$2a$12$vYoY.oZE3hkBm0zm.lgSFuYrGBdgB2Q0R2UKL0Vdgxy0MUg5eksUu', '0243061438', NULL, '2298802442'),
(103, 'Limoges', 'France', '44 Boulevard Monsieur-le-Prince', '82597', '1990-01-01 00:00:00', '2022-06-23 11:55:28', 'louise.pons@examplemail.fr', 'Océane', 'Gaillard', '$2a$12$NIwt8E8xUAbEkjJXlVPHRe4JC0i.c4NCwL/tj.62lTZimUT1pyaa6', '0120838785', NULL, '8415278309'),
(108, 'Argenteuil', 'France', '980 Rue Saint-Honoré', '72062', '1990-01-01 00:00:00', '2022-06-23 11:55:29', 'alice.olivier@examplemail.fr', 'Juliette', 'Rousseau', '$2a$12$Bw3BT5emsHdbnzhiwkFN1.qpyGoWIuQ41hCy52w0qnTFKC.YvKFSq', '0190493700', NULL, '1710942759'),
(113, 'Strasbourg', 'France', '40 Rue de la Harpe', '59179', '1990-01-01 00:00:00', '2022-06-23 11:55:30', 'chloé.vidal@examplemail.fr', 'Kylian', 'Da silva', '$2a$12$HlKdsNTXhemOx0sbj0ieyeFQAd00/EAfHvV7ImmQ/MO4pKcJVUJki', '0862577747', NULL, '4580748725'),
(118, 'Lorient', 'France', '70 Quai du Faubourg Saint-Honoré', '75549', '1990-01-01 00:00:00', '2022-06-23 11:55:30', 'noah.roche@examplemail.fr', 'Pauline', 'Jacquet', '$2a$12$JtbYoso4f.rhScZAoXMvEOCjDlrRD9CUD1qhMBzJtOxUxRIdSEbOW', '0102672876', NULL, '3792273044'),
(123, 'Cannes', 'France', '4 Passage d Assas', '92924', '1990-01-01 00:00:00', '2022-06-23 11:55:31', 'chloé.fontaine@examplemail.fr', 'Noa', 'Schmitt', '$2a$12$e/wyyPag0NsTrJsi7dGKHeevpsAwhpIaiIR33vp9b016ANovWZii2', '0892294474', NULL, '7196790637'),
(128, 'Troyes', 'France', '4 Quai du Faubourg-Saint-Denis', '06586', '1990-01-01 00:00:00', '2022-06-23 11:55:32', 'pauline.brunet@examplemail.fr', 'Chloé', 'Thomas', '$2a$12$0YerB.f4EsjfuKhMVkFi3.v065E1LQOczO7WHJdNg.lRSVrxU.4TO', '0476228814', NULL, '3740956873'),
(133, 'Nice', 'France', '0 Place du Faubourg-Saint-Denis', '53859', '1990-01-01 00:00:00', '2022-06-23 11:55:33', 'paul.robert@examplemail.fr', 'Jules', 'Brun', '$2a$12$SSI26sBsPuJz3DwAq/oHM.EJnViTq6sPWo81kbGM4n7lyAiV8TXsm', '0246426437', NULL, '5983596433'),
(138, 'Saint-Denis', 'France', '9118 Impasse Molière', '49654', '1990-01-01 00:00:00', '2022-06-23 11:55:33', 'justine.blanc@examplemail.fr', 'Mattéo', 'Lefebvre', '$2a$12$2Jhz3uRG.T6hf/9JMZ0lZ.y9CrQd3hk5RFoy8Xh9haGAcud6K7qhu', '0252757985', NULL, '1918863673'),
(143, 'Montpellier', 'France', '0 Passage Monsieur-le-Prince', '41107', '1990-01-01 00:00:00', '2022-06-23 11:55:34', 'lucie.perez@examplemail.fr', 'Mathéo', 'Mathieu', '$2a$12$gW/dJfmn72RTJeBUhPIL2uvicCMGxIEN/Qmp5QiEGQb.vUvpkQqqa', '0344396380', NULL, '5682081085'),
(148, 'Vénissieux', 'France', '8110 Quai de la Chaussée-d Antin', '81273', '1990-01-01 00:00:00', '2022-06-23 11:55:35', 'ines.renault@examplemail.fr', 'Mattéo', 'Lambert', '$2a$12$4zu/3OaIXdu2vEydai20sughGgirAnJBFCmLiZHkAylgCalwWENHq', '0211990792', NULL, '0148600435'),
(153, 'Ajaccio', 'France', '87 Passage Saint-Jacques', '81899', '1990-01-01 00:00:00', '2022-06-23 11:55:36', 'eva.garnier@examplemail.fr', 'Noa', 'Royer', '$2a$12$jFdrQs4zogn8U3wLQJ.Q8OfdwROGUVAQWgB9540soZzVMwm0CDT4a', '0152457726', NULL, '4048517678'),
(158, 'Pessac', 'France', '26 Boulevard du Faubourg Saint-Honoré', '28984', '1990-01-01 00:00:00', '2022-06-23 11:55:36', 'maxence.benoit@examplemail.fr', 'Hugo', 'Joly', '$2a$12$2cNBj/eTjp6/MuWdDXRvg.zilM1UfDX1RljIQvaSM5vEkm0DgWTRe', '0829404961', NULL, '7663141353');

-- --------------------------------------------------------

--
-- Structure de la table `user_role`
--

CREATE TABLE `user_role` (
  `user_id_user` int(11) NOT NULL,
  `role` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `user_role`
--

INSERT INTO `user_role` (`user_id_user`, `role`) VALUES
(4, 1),
(6, 2),
(11, 0),
(13, 2),
(18, 2),
(23, 2),
(28, 2),
(33, 2),
(38, 2),
(43, 2),
(48, 2),
(53, 2),
(58, 2),
(63, 2),
(68, 2),
(73, 2),
(78, 2),
(83, 2),
(88, 2),
(93, 2),
(98, 2),
(103, 2),
(108, 2),
(113, 2),
(118, 2),
(123, 2),
(128, 2),
(133, 2),
(138, 2),
(143, 2),
(148, 2),
(153, 2),
(158, 2);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id_account`),
  ADD KEY `FKk9pbad67x08tteaec1pxpoxbe` (`id_account_type`),
  ADD KEY `FK19bqrtyxmk1iein1t2569bidx` (`id_customer`);

--
-- Index pour la table `account_balances`
--
ALTER TABLE `account_balances`
  ADD PRIMARY KEY (`id_account_balance`),
  ADD KEY `FKdtb63uf9ttjc4fbo287c9bfqo` (`id_account`);

--
-- Index pour la table `account_types`
--
ALTER TABLE `account_types`
  ADD PRIMARY KEY (`id_account_type`);

--
-- Index pour la table `bankers`
--
ALTER TABLE `bankers`
  ADD PRIMARY KEY (`id_banker`),
  ADD KEY `FKbtoja9jek17srktjoaow9hppn` (`id_user`);

--
-- Index pour la table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id_card`),
  ADD KEY `FK18qe1fdcdjm1vl4pgnrk3d9hf` (`id_account`);

--
-- Index pour la table `changing_rate_dates`
--
ALTER TABLE `changing_rate_dates`
  ADD PRIMARY KEY (`id_changing_rate_date`);

--
-- Index pour la table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id_customer`),
  ADD KEY `FKo02lpoy9749ke64mh4dm5e0lv` (`id_banker`),
  ADD KEY `FK95enng1a6ukx4icvcplxi4gox` (`id_user`);

--
-- Index pour la table `customer_document_type`
--
ALTER TABLE `customer_document_type`
  ADD KEY `FKl3l9tcie0gxqheobxkfsusng8` (`customer_id_customer`);

--
-- Index pour la table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id_transaction`),
  ADD KEY `FKshcyxexg3r6tgawfie14r08av` (`id_account_credit`),
  ADD KEY `FK1c8ral0o7csdhyopj4j2fb4wr` (`id_account_debit`);

--
-- Index pour la table `transaction_description`
--
ALTER TABLE `transaction_description`
  ADD KEY `FK69o1une0e7n3w5p2e8ng79ikf` (`transaction_id_transaction`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`),
  ADD UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`);

--
-- Index pour la table `user_role`
--
ALTER TABLE `user_role`
  ADD KEY `FKpco0tdcq7bgcr6u317axol86n` (`user_id_user`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `FK19bqrtyxmk1iein1t2569bidx` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id_customer`),
  ADD CONSTRAINT `FKk9pbad67x08tteaec1pxpoxbe` FOREIGN KEY (`id_account_type`) REFERENCES `account_types` (`id_account_type`);

--
-- Contraintes pour la table `account_balances`
--
ALTER TABLE `account_balances`
  ADD CONSTRAINT `FKdtb63uf9ttjc4fbo287c9bfqo` FOREIGN KEY (`id_account`) REFERENCES `accounts` (`id_account`);

--
-- Contraintes pour la table `bankers`
--
ALTER TABLE `bankers`
  ADD CONSTRAINT `FKbtoja9jek17srktjoaow9hppn` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Contraintes pour la table `cards`
--
ALTER TABLE `cards`
  ADD CONSTRAINT `FK18qe1fdcdjm1vl4pgnrk3d9hf` FOREIGN KEY (`id_account`) REFERENCES `accounts` (`id_account`);

--
-- Contraintes pour la table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `FK95enng1a6ukx4icvcplxi4gox` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `FKo02lpoy9749ke64mh4dm5e0lv` FOREIGN KEY (`id_banker`) REFERENCES `bankers` (`id_banker`);

--
-- Contraintes pour la table `customer_document_type`
--
ALTER TABLE `customer_document_type`
  ADD CONSTRAINT `FKl3l9tcie0gxqheobxkfsusng8` FOREIGN KEY (`customer_id_customer`) REFERENCES `customers` (`id_customer`);

--
-- Contraintes pour la table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `FK1c8ral0o7csdhyopj4j2fb4wr` FOREIGN KEY (`id_account_debit`) REFERENCES `accounts` (`id_account`),
  ADD CONSTRAINT `FKshcyxexg3r6tgawfie14r08av` FOREIGN KEY (`id_account_credit`) REFERENCES `accounts` (`id_account`);

--
-- Contraintes pour la table `transaction_description`
--
ALTER TABLE `transaction_description`
  ADD CONSTRAINT `FK69o1une0e7n3w5p2e8ng79ikf` FOREIGN KEY (`transaction_id_transaction`) REFERENCES `transactions` (`id_transaction`);

--
-- Contraintes pour la table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `FKpco0tdcq7bgcr6u317axol86n` FOREIGN KEY (`user_id_user`) REFERENCES `users` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
