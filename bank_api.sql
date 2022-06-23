-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 23 juin 2022 à 09:36
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
(12, 470.01, '2022-06-22 16:56:01', 'CUR1160054', -100, '2022-06-23 09:28:07', 1, 11),
(17, 1001, '2022-06-22 16:56:02', 'CUR1328201', -101, NULL, 1, 16),
(22, 1002, '2022-06-22 16:56:03', 'CUR0093252', -102, NULL, 1, 21),
(27, 1003, '2022-06-22 16:56:04', 'CUR3647177', -103, NULL, 1, 26),
(32, 1004, '2022-06-22 16:56:05', 'CUR1209472', -104, NULL, 1, 31),
(37, 1005, '2022-06-22 16:56:05', 'CUR3285617', -105, NULL, 1, 36),
(42, 1006, '2022-06-22 16:56:06', 'CUR3835414', -106, NULL, 1, 41),
(47, 1007, '2022-06-22 16:56:07', 'CUR2130033', -107, NULL, 1, 46),
(52, 1008, '2022-06-22 16:56:08', 'CUR6938924', -108, NULL, 1, 51),
(57, 1009, '2022-06-22 16:56:08', 'CUR8205006', -109, NULL, 1, 56),
(62, 1010, '2022-06-22 16:56:09', 'CUR2804230', -110, NULL, 1, 61),
(67, 1011, '2022-06-22 16:56:10', 'CUR8002779', -111, NULL, 1, 66),
(72, 1012, '2022-06-22 16:56:11', 'CUR9228673', -112, NULL, 1, 71),
(77, 1013, '2022-06-22 16:56:11', 'CUR1196704', -113, NULL, 1, 76),
(82, 1014, '2022-06-22 16:56:12', 'CUR9797189', -114, NULL, 1, 81),
(87, 1015, '2022-06-22 16:56:13', 'CUR4945492', -115, NULL, 1, 86),
(92, 1016, '2022-06-22 16:56:14', 'CUR3437958', -116, NULL, 1, 91),
(97, 1017, '2022-06-22 16:56:14', 'CUR9798302', -117, NULL, 1, 96),
(102, 1018, '2022-06-22 16:56:15', 'CUR9759333', -118, NULL, 1, 101),
(107, 1019, '2022-06-22 16:56:16', 'CUR7822284', -119, NULL, 1, 106),
(112, 1020, '2022-06-22 16:56:17', 'CUR3065226', -120, NULL, 1, 111),
(117, 1021, '2022-06-22 16:56:17', 'CUR5862063', -121, NULL, 1, 116),
(122, 1022, '2022-06-22 16:56:19', 'CUR5245611', -122, NULL, 1, 121),
(127, 1023, '2022-06-22 16:56:19', 'CUR0603811', -123, NULL, 1, 126),
(132, 1024, '2022-06-22 16:56:21', 'CUR2325081', -124, NULL, 1, 131),
(137, 1025, '2022-06-22 16:56:22', 'CUR2845002', -125, NULL, 1, 136),
(142, 1026, '2022-06-22 16:56:22', 'CUR6726365', -126, NULL, 1, 141),
(147, 1027, '2022-06-22 16:56:23', 'CUR8521474', -127, NULL, 1, 146),
(152, 1028, '2022-06-22 16:56:24', 'CUR6574219', -128, NULL, 1, 151),
(157, 1029, '2022-06-22 16:56:25', 'CUR9812341', -129, NULL, 1, 156),
(160, 2000, '2022-06-23 09:24:54', 'LVA2825058', -100, NULL, 2, 7),
(163, 1973.66, '2022-06-23 09:25:49', 'LVA4135340', -200, '2022-06-23 09:27:13', 3, 11),
(166, 800, '2022-06-23 09:26:01', 'LVA1461491', -100, NULL, 3, 16);

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
(14, 470.01, '2022-06-22 16:56:01', '2022-06-23 09:28:07', 12),
(19, 1001, '2022-06-22 16:56:02', NULL, 17),
(24, 1002, '2022-06-22 16:56:03', NULL, 22),
(29, 1003, '2022-06-22 16:56:04', NULL, 27),
(34, 1004, '2022-06-22 16:56:05', NULL, 32),
(39, 1005, '2022-06-22 16:56:05', NULL, 37),
(44, 1006, '2022-06-22 16:56:06', NULL, 42),
(49, 1007, '2022-06-22 16:56:07', NULL, 47),
(54, 1008, '2022-06-22 16:56:08', NULL, 52),
(59, 1009, '2022-06-22 16:56:08', NULL, 57),
(64, 1010, '2022-06-22 16:56:09', NULL, 62),
(69, 1011, '2022-06-22 16:56:10', NULL, 67),
(74, 1012, '2022-06-22 16:56:11', NULL, 72),
(79, 1013, '2022-06-22 16:56:11', NULL, 77),
(84, 1014, '2022-06-22 16:56:12', NULL, 82),
(89, 1015, '2022-06-22 16:56:13', NULL, 87),
(94, 1016, '2022-06-22 16:56:14', NULL, 92),
(99, 1017, '2022-06-22 16:56:14', NULL, 97),
(104, 1018, '2022-06-22 16:56:15', NULL, 102),
(109, 1019, '2022-06-22 16:56:16', NULL, 107),
(114, 1020, '2022-06-22 16:56:17', NULL, 112),
(119, 1021, '2022-06-22 16:56:17', NULL, 117),
(124, 1022, '2022-06-22 16:56:19', NULL, 122),
(129, 1023, '2022-06-22 16:56:19', NULL, 127),
(134, 1024, '2022-06-22 16:56:21', NULL, 132),
(139, 1025, '2022-06-22 16:56:22', NULL, 137),
(144, 1026, '2022-06-22 16:56:22', NULL, 142),
(149, 1027, '2022-06-22 16:56:23', NULL, 147),
(154, 1028, '2022-06-22 16:56:24', NULL, 152),
(159, 1029, '2022-06-22 16:56:25', NULL, 157),
(162, 2000, '2022-06-23 09:24:55', NULL, 160),
(165, 1973.66, '2022-06-23 09:25:49', '2022-06-23 09:27:13', 163),
(168, 800, '2022-06-23 09:26:01', NULL, 166);

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
(1, '2022-06-22 16:55:57', 'CPT_COURANT', 0, NULL),
(2, '2022-06-22 16:55:58', 'LIVRET_DEVELOPPEMENT_DURABLE', 0.6, NULL),
(3, '2022-06-22 16:55:58', 'LIVRET_A', 0.3, NULL);

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
(5, '2022-06-22 16:56:00', '4446278241', NULL, 4),
(9, '2022-06-22 16:56:00', '9891532360', NULL, 8);

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
(13, '2022-06-22 16:56:01', '175', '9171001053886704', NULL, '2024-06-22 16:56:01', 12),
(18, '2022-06-22 16:56:02', '945', '1475988456389239', NULL, '2024-06-22 16:56:02', 17),
(23, '2022-06-22 16:56:03', '911', '9632023549924917', NULL, '2024-06-22 16:56:03', 22),
(28, '2022-06-22 16:56:04', '538', '6180258509940084', NULL, '2024-06-22 16:56:04', 27),
(33, '2022-06-22 16:56:05', '220', '4266427870755417', NULL, '2024-06-22 16:56:05', 32),
(38, '2022-06-22 16:56:05', '931', '0487611041100330', NULL, '2024-06-22 16:56:05', 37),
(43, '2022-06-22 16:56:06', '056', '8790599148597175', NULL, '2024-06-22 16:56:06', 42),
(48, '2022-06-22 16:56:07', '181', '3596108912483800', NULL, '2024-06-22 16:56:07', 47),
(53, '2022-06-22 16:56:08', '835', '1833732148980269', NULL, '2024-06-22 16:56:08', 52),
(58, '2022-06-22 16:56:08', '158', '2813835736970609', NULL, '2024-06-22 16:56:08', 57),
(63, '2022-06-22 16:56:09', '625', '0323642048545317', NULL, '2024-06-22 16:56:09', 62),
(68, '2022-06-22 16:56:10', '950', '2603188917471429', NULL, '2024-06-22 16:56:10', 67),
(73, '2022-06-22 16:56:11', '268', '1037190837816016', NULL, '2024-06-22 16:56:11', 72),
(78, '2022-06-22 16:56:11', '424', '2630287606702155', NULL, '2024-06-22 16:56:11', 77),
(83, '2022-06-22 16:56:12', '430', '2836369449007787', NULL, '2024-06-22 16:56:12', 82),
(88, '2022-06-22 16:56:13', '906', '4654364962285415', NULL, '2024-06-22 16:56:13', 87),
(93, '2022-06-22 16:56:14', '312', '2580420602348936', NULL, '2024-06-22 16:56:14', 92),
(98, '2022-06-22 16:56:14', '368', '9263768537679164', NULL, '2024-06-22 16:56:14', 97),
(103, '2022-06-22 16:56:15', '589', '3672727194248670', NULL, '2024-06-22 16:56:15', 102),
(108, '2022-06-22 16:56:16', '864', '1941931252316469', NULL, '2024-06-22 16:56:16', 107),
(113, '2022-06-22 16:56:17', '171', '5744625471463741', NULL, '2024-06-22 16:56:17', 112),
(118, '2022-06-22 16:56:17', '763', '9550677210279786', NULL, '2024-06-22 16:56:17', 117),
(123, '2022-06-22 16:56:19', '922', '8476610680395807', NULL, '2024-06-22 16:56:19', 122),
(128, '2022-06-22 16:56:19', '338', '0441980914754555', NULL, '2024-06-22 16:56:19', 127),
(133, '2022-06-22 16:56:21', '505', '6350751551462517', NULL, '2024-06-22 16:56:21', 132),
(138, '2022-06-22 16:56:22', '491', '2510950516266723', NULL, '2024-06-22 16:56:22', 137),
(143, '2022-06-22 16:56:22', '115', '3096921444355365', NULL, '2024-06-22 16:56:22', 142),
(148, '2022-06-22 16:56:23', '767', '7736540213960687', NULL, '2024-06-22 16:56:23', 147),
(153, '2022-06-22 16:56:24', '935', '9581349327806246', NULL, '2024-06-22 16:56:24', 152),
(158, '2022-06-22 16:56:25', '636', '7683756145272444', NULL, '2024-06-22 16:56:25', 157),
(161, '2022-06-23 09:24:55', '759', '4599088868606515', NULL, '2024-06-23 09:24:54', 160),
(164, '2022-06-23 09:25:49', '411', '0232744920219655', NULL, '2024-06-23 09:25:49', 163),
(167, '2022-06-23 09:26:01', '702', '1583750579272303', NULL, '2024-06-23 09:26:01', 166);

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
(173, '2022-12-06 01:00:00', '2022-12-01 01:00:00');

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
(7, '2022-06-22 16:56:00', NULL, '1461417618', NULL, 5, 6),
(11, '2022-06-22 16:56:01', NULL, '9832186783', NULL, 5, 10),
(16, '2022-06-22 16:56:02', NULL, '2814243184', NULL, 5, 15),
(21, '2022-06-22 16:56:03', NULL, '4202744790', NULL, 5, 20),
(26, '2022-06-22 16:56:04', NULL, '0460614075', NULL, 5, 25),
(31, '2022-06-22 16:56:05', NULL, '9637117955', NULL, 5, 30),
(36, '2022-06-22 16:56:05', NULL, '0356588845', NULL, 5, 35),
(41, '2022-06-22 16:56:06', NULL, '9892814082', NULL, 5, 40),
(46, '2022-06-22 16:56:07', NULL, '2880028937', NULL, 5, 45),
(51, '2022-06-22 16:56:08', NULL, '2356021837', NULL, 5, 50),
(56, '2022-06-22 16:56:08', NULL, '5035909983', NULL, 5, 55),
(61, '2022-06-22 16:56:09', NULL, '7558635015', NULL, 5, 60),
(66, '2022-06-22 16:56:10', NULL, '0041438539', NULL, 5, 65),
(71, '2022-06-22 16:56:11', NULL, '2932355487', NULL, 5, 70),
(76, '2022-06-22 16:56:11', NULL, '4169832230', NULL, 5, 75),
(81, '2022-06-22 16:56:12', NULL, '2171619921', NULL, 5, 80),
(86, '2022-06-22 16:56:13', NULL, '8905571089', NULL, 5, 85),
(91, '2022-06-22 16:56:14', NULL, '2130905924', NULL, 5, 90),
(96, '2022-06-22 16:56:14', NULL, '4184262276', NULL, 5, 95),
(101, '2022-06-22 16:56:15', NULL, '0848594153', NULL, 5, 100),
(106, '2022-06-22 16:56:16', NULL, '6449705802', NULL, 5, 105),
(111, '2022-06-22 16:56:17', NULL, '5822234602', NULL, 5, 110),
(116, '2022-06-22 16:56:17', NULL, '6652505055', NULL, 5, 115),
(121, '2022-06-22 16:56:19', NULL, '8527334184', NULL, 5, 120),
(126, '2022-06-22 16:56:19', NULL, '5358570685', NULL, 5, 125),
(131, '2022-06-22 16:56:21', NULL, '1680760239', NULL, 5, 130),
(136, '2022-06-22 16:56:21', NULL, '2190641423', NULL, 5, 135),
(141, '2022-06-22 16:56:22', NULL, '6370446396', NULL, 5, 140),
(146, '2022-06-22 16:56:23', NULL, '5396840112', NULL, 5, 145),
(151, '2022-06-22 16:56:24', NULL, '1542760473', NULL, 5, 150),
(156, '2022-06-22 16:56:25', NULL, '2868268422', NULL, 5, 155);

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
(11, 'attestation_domicile'),
(11, 'piece_id'),
(11, 'avis_impots'),
(16, 'attestation_domicile'),
(16, 'piece_id'),
(16, 'avis_impots'),
(21, 'attestation_domicile'),
(21, 'piece_id'),
(21, 'avis_impots'),
(26, 'attestation_domicile'),
(26, 'piece_id'),
(26, 'avis_impots'),
(31, 'attestation_domicile'),
(31, 'piece_id'),
(31, 'avis_impots'),
(36, 'attestation_domicile'),
(36, 'piece_id'),
(36, 'avis_impots'),
(41, 'attestation_domicile'),
(41, 'piece_id'),
(41, 'avis_impots'),
(46, 'attestation_domicile'),
(46, 'piece_id'),
(46, 'avis_impots'),
(51, 'attestation_domicile'),
(51, 'piece_id'),
(51, 'avis_impots'),
(56, 'attestation_domicile'),
(56, 'piece_id'),
(56, 'avis_impots'),
(61, 'attestation_domicile'),
(61, 'piece_id'),
(61, 'avis_impots'),
(66, 'attestation_domicile'),
(66, 'piece_id'),
(66, 'avis_impots'),
(71, 'attestation_domicile'),
(71, 'piece_id'),
(71, 'avis_impots'),
(76, 'attestation_domicile'),
(76, 'piece_id'),
(76, 'avis_impots'),
(81, 'attestation_domicile'),
(81, 'piece_id'),
(81, 'avis_impots'),
(86, 'attestation_domicile'),
(86, 'piece_id'),
(86, 'avis_impots'),
(91, 'attestation_domicile'),
(91, 'piece_id'),
(91, 'avis_impots'),
(96, 'attestation_domicile'),
(96, 'piece_id'),
(96, 'avis_impots'),
(101, 'attestation_domicile'),
(101, 'piece_id'),
(101, 'avis_impots'),
(106, 'attestation_domicile'),
(106, 'piece_id'),
(106, 'avis_impots'),
(111, 'attestation_domicile'),
(111, 'piece_id'),
(111, 'avis_impots'),
(116, 'attestation_domicile'),
(116, 'piece_id'),
(116, 'avis_impots'),
(121, 'attestation_domicile'),
(121, 'piece_id'),
(121, 'avis_impots'),
(126, 'attestation_domicile'),
(126, 'piece_id'),
(126, 'avis_impots'),
(131, 'attestation_domicile'),
(131, 'piece_id'),
(131, 'avis_impots'),
(136, 'attestation_domicile'),
(136, 'piece_id'),
(136, 'avis_impots'),
(141, 'attestation_domicile'),
(141, 'piece_id'),
(141, 'avis_impots'),
(146, 'attestation_domicile'),
(146, 'piece_id'),
(146, 'avis_impots'),
(151, 'attestation_domicile'),
(151, 'piece_id'),
(151, 'avis_impots'),
(156, 'attestation_domicile'),
(156, 'piece_id'),
(156, 'avis_impots');

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
(174);

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
(169, 26.34, '2022-06-23 09:27:13', 'Carrefour Market', NULL, NULL, 163),
(171, 500, '2022-06-23 09:29:42', 'Epargne', NULL, 163, 12),
(172, 29.99, '2022-06-23 09:32:10', 'Prélèvement Orange Mobile', NULL, NULL, 12);

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
(169, 1),
(171, 0),
(172, 1);

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
(4, 'Perpignan', 'France', '301 Quai de la Paix', '98668', '1990-01-01 00:00:00', '2022-06-22 16:56:00', 'banker@example.fr', 'Banker', 'Test', '$2a$12$4xoKMGAiMKmCzjJxr5uP0eiIRvprGtJf0XHVr1pQLr.UtWCdXdOPS', '0600000000', NULL, '4446278241'),
(6, 'Béziers', 'France', '998 Avenue de la Pompe', '50682', '1990-01-01 00:00:00', '2022-06-22 16:56:00', 'customer@example.fr', 'Customer', 'Test', '$2a$12$R8UIIIiIUI2FDErcWZa1a.BRiFO6tDXqVeL0pGAcUEhT4/rb5K6r2', '0600000000', NULL, '1461417618'),
(8, 'Cayenne', 'France', '9 Place des Grands Augustins', '26992', '1990-01-01 00:00:00', '2022-06-22 16:56:00', 'director@example.fr', 'Director', 'Test', '$2a$12$16uCV/vcR48M8vFiQNA6BOFZLVYNUXk1fFyUI0ixk3YQtr4YUgJ8G', '0600000000', NULL, '9891532360'),
(10, 'Lorient', 'France', '2323 Impasse Monsieur-le-Prince', '31507', '1990-01-01 00:00:00', '2022-06-22 16:56:01', 'léa.carre@examplemail.fr', 'Lucie', 'Prevost', '$2a$12$CuUa3svwSeMHwnfktwlzV.129xpFWriJPS0QvPY6eQvwnWL5inrBW', '0600000000', NULL, '9832186783'),
(15, 'Drancy', 'France', '6 Impasse de la Pompe', '45722', '1990-01-01 00:00:00', '2022-06-22 16:56:02', 'marie.fabre@examplemail.fr', 'Célia', 'Denis', '$2a$12$qQTvbjja/6phbImzyC2yleIz1zQZ3QHH6X6bFINtgKA8E4FBsGn.y', '0600000000', NULL, '2814243184'),
(20, 'Montreuil', 'France', '18 Boulevard Monsieur-le-Prince', '26325', '1990-01-01 00:00:00', '2022-06-22 16:56:03', 'alice.guillaume@examplemail.fr', 'Maeva', 'Marty', '$2a$12$slhRAaM2/5q9N8zfgeAOfeROAtvyFkvgFEDhvmyQdm972cTRyFaEe', '0600000000', NULL, '4202744790'),
(25, 'Argenteuil', 'France', '13 Place Pierre Charron', '83512', '1990-01-01 00:00:00', '2022-06-22 16:56:04', 'lucie.laurent@examplemail.fr', 'Océane', 'Perez', '$2a$12$Nj2717isW..sd3eKiI8QLO04sU71WMsg/upp2weDivSF0k2RRqJ5G', '0600000000', NULL, '0460614075'),
(30, 'Montreuil', 'France', '0469 Rue de la Pompe', '46651', '1990-01-01 00:00:00', '2022-06-22 16:56:05', 'lilou.dupuy@examplemail.fr', 'Alicia', 'Fernandez', '$2a$12$2c3cTPqt3sUlEgy8kcRApOY.81tteRUMdWyIy.TV7Os12lslTucPm', '0600000000', NULL, '9637117955'),
(35, 'Les Abymes', 'France', '715 Avenue Saint-Dominique', '35111', '1990-01-01 00:00:00', '2022-06-22 16:56:05', 'sarah.denis@examplemail.fr', 'Jules', 'Muller', '$2a$12$7Y5zic.MNjqnCSh1Ya7myeRJzVVe/e8XL/jCp/QN6Q/jbl0e2KMne', '0600000000', NULL, '0356588845'),
(40, 'Strasbourg', 'France', '417 Rue de l Abbaye', '08422', '1990-01-01 00:00:00', '2022-06-22 16:56:06', 'mael.marchand@examplemail.fr', 'Marie', 'Lefebvre', '$2a$12$eeY6gv.1vvgURY1C4GA2FeFDLiEAyFK6.DFnof6xG0teOtsj08xvq', '0600000000', NULL, '9892814082'),
(45, 'Aubervilliers', 'France', '014 Allée, Voie Montorgueil', '49163', '1990-01-01 00:00:00', '2022-06-22 16:56:07', 'lena.cousin@examplemail.fr', 'Adam', 'Guerin', '$2a$12$7UrPNmnHO8Gs66fWtt7s1.vDoGj59.4zKbF8xZ7ReZY7pVj9.DK7y', '0600000000', NULL, '2880028937'),
(50, 'Reims', 'France', '6515 Impasse Saint-Honoré', '13670', '1990-01-01 00:00:00', '2022-06-22 16:56:08', 'lucas.martinez@examplemail.fr', 'Alexis', 'Boyer', '$2a$12$9igS5sARTP.zwPHkjHc.Ue7u4jLvNdisjpaOUCkGzmDsEdrb4f4S.', '0600000000', NULL, '2356021837'),
(55, 'Créteil', 'France', '0 Quai de la Huchette', '26493', '1990-01-01 00:00:00', '2022-06-22 16:56:08', 'noémie.marie@examplemail.fr', 'Noah', 'Carre', '$2a$12$J3Ijb3jWRpZj3THabfpjvuqPRs5P08WeTcTc0ifAHgclu8ikdSN1i', '0600000000', NULL, '5035909983'),
(60, 'Montauban', 'France', '1994 Impasse de la Harpe', '71480', '1990-01-01 00:00:00', '2022-06-22 16:56:09', 'arthur.faure@examplemail.fr', 'Lilou', 'Jacquet', '$2a$12$G2XBKMsPVyf6edzMGEXVk./A0YXcByIW7hnVkdVSQt.AJ3Bw5JxWm', '0600000000', NULL, '7558635015'),
(65, 'Saint-Étienne', 'France', '78 Place de Provence', '29826', '1990-01-01 00:00:00', '2022-06-22 16:56:10', 'baptiste.denis@examplemail.fr', 'Jules', 'Da silva', '$2a$12$njRx/Ql8eQSUS3qLyWCcv.HsPm0gb.yVVv4AFK.zK45sI6Pz/hw9a', '0600000000', NULL, '0041438539'),
(70, 'Issy-les-Moulineaux', 'France', '97 Boulevard Monsieur-le-Prince', '61832', '1990-01-01 00:00:00', '2022-06-22 16:56:11', 'ambre.perrin@examplemail.fr', 'Juliette', 'Le roux', '$2a$12$c/PN1D9Yi3WLgjuZZ24CA.I1P8l2HniDZotwmQem93PJhYgFSsTra', '0600000000', NULL, '2932355487'),
(75, 'Cholet', 'France', '737 Place Joubert', '70909', '1990-01-01 00:00:00', '2022-06-22 16:56:11', 'alice.muller@examplemail.fr', 'Tom', 'Julien', '$2a$12$DPjZw/c9OXRdhKCBIv3rBe2pbUTgPXSW.Kh8HPQgm7n8S8LVtmw7i', '0600000000', NULL, '4169832230'),
(80, 'Poitiers', 'France', '2568 Impasse des Panoramas', '16309', '1990-01-01 00:00:00', '2022-06-22 16:56:12', 'jules.remy@examplemail.fr', 'Mathéo', 'Lopez', '$2a$12$Q0i.PmlwVYm9YIxfDwkSoe7fOH7YVG4MuPYoMpTKKQ6cs6mkfK4Iu', '0600000000', NULL, '2171619921'),
(85, 'Saint-Maur-des-Fossés', 'France', '5 Boulevard d Orsel', '06537', '1990-01-01 00:00:00', '2022-06-22 16:56:13', 'evan.julien@examplemail.fr', 'Alice', 'Leroy', '$2a$12$qA3A/uQQpxdsr1T7IIdpB.X1b27MwiOJy2XotjQhf5aeXyOtI4Xyq', '0600000000', NULL, '8905571089'),
(90, 'Montpellier', 'France', '6413 Avenue Oberkampf', '84539', '1990-01-01 00:00:00', '2022-06-22 16:56:14', 'chloé.muller@examplemail.fr', 'Ethan', 'Adam', '$2a$12$xwNvxZmmSN4t4eVMuv0HaOqLtSDvkADVq96F11hZT7pNjpr7dC1hO', '0600000000', NULL, '2130905924'),
(95, 'Vitry-sur-Seine', 'France', '129 Place Saint-Séverin', '01114', '1990-01-01 00:00:00', '2022-06-22 16:56:14', 'zoe.dumont@examplemail.fr', 'Pauline', 'Prevost', '$2a$12$9nNQWRHbdMfCR0o/sOYwyejj8VJtYbu6oFVvMxGyl5ho2Z/ynTpZi', '0600000000', NULL, '4184262276'),
(100, 'Calais', 'France', '358 Place Du Sommerard', '70031', '1990-01-01 00:00:00', '2022-06-22 16:56:15', 'mélissa.roussel@examplemail.fr', 'Tom', 'Morin', '$2a$12$UcMueBMme5SpFbURW.PKH.YSSZvbbBIBUDIwBoVGY2m01rZSNKqeW', '0600000000', NULL, '0848594153'),
(105, 'Metz', 'France', '3 Impasse Joubert', '23782', '1990-01-01 00:00:00', '2022-06-22 16:56:16', 'alice.petit@examplemail.fr', 'Léa', 'Colin', '$2a$12$3C2pEyQuPX7VzvyD6Cj1deokIWQW2q6RzKGGU8k9wYMsu7jVXcGMC', '0600000000', NULL, '6449705802'),
(110, 'Lille', 'France', '3 Passage des Grands Augustins', '73631', '1990-01-01 00:00:00', '2022-06-22 16:56:17', 'juliette.roger@examplemail.fr', 'Clément', 'Roger', '$2a$12$UU3CpeYN0mA2DDpn.lZRA.nE/kxiF.w7Ko5NIa4wVMWRiKJVZK2ui', '0600000000', NULL, '5822234602'),
(115, 'Aubervilliers', 'France', '396 Allée, Voie d Orsel', '52794', '1990-01-01 00:00:00', '2022-06-22 16:56:17', 'gabriel.picard@examplemail.fr', 'Axel', 'Durand', '$2a$12$ouabVxSP8wDCQ6dIgDnsYuWZa5T8178xcD4fGeNTNSvMCIwRVh7hS', '0600000000', NULL, '6652505055'),
(120, 'Angers', 'France', '3726 Passage des Panoramas', '84351', '1990-01-01 00:00:00', '2022-06-22 16:56:19', 'alice.robert@examplemail.fr', 'Chloé', 'Guerin', '$2a$12$wxEbP3.Hqtrx3upnUOJvfOF2568HHTf1mME3Rxb2Q.7Sls8BTR0ki', '0600000000', NULL, '8527334184'),
(125, 'Lille', 'France', '57 Avenue d Abbeville', '68790', '1990-01-01 00:00:00', '2022-06-22 16:56:19', 'mael.paris@examplemail.fr', 'Romain', 'Joly', '$2a$12$VJpEtZesHwrrFUJVUEKBJuVgzFC7cg8/pKDhgEm81zx4bKC7PD4RW', '0600000000', NULL, '5358570685'),
(130, 'Aix-en-Provence', 'France', '31 Allée, Voie Oberkampf', '96494', '1990-01-01 00:00:00', '2022-06-22 16:56:21', 'baptiste.mercier@examplemail.fr', 'Kylian', 'Faure', '$2a$12$k8dcDwEfJXraqXuqOP5cgu3HS91x49Wz2QUMutX59JZ4YDsgJ3292', '0600000000', NULL, '1680760239'),
(135, 'Saint-Nazaire', 'France', '81 Impasse Saint-Séverin', '80283', '1990-01-01 00:00:00', '2022-06-22 16:56:21', 'gabriel.rodriguez@examplemail.fr', 'Célia', 'Perrin', '$2a$12$q0JKrocPnx313tL4bb1AX.CFf1y.QN3UAli7a.Iz3iggh59lXiaTe', '0600000000', NULL, '2190641423'),
(140, 'Cergy', 'France', '4849 Boulevard d Assas', '75136', '1990-01-01 00:00:00', '2022-06-22 16:56:22', 'gabriel.mercier@examplemail.fr', 'Jade', 'Schneider', '$2a$12$znZeOPgOe9EpL8LGrXC2P.k1YQX1dwVVGLw/8g5.6r/NuePegYv8y', '0600000000', NULL, '6370446396'),
(145, 'Le Mans', 'France', '8 Avenue Saint-Bernard', '11120', '1990-01-01 00:00:00', '2022-06-22 16:56:23', 'hugo.dumas@examplemail.fr', 'Romain', 'Roger', '$2a$12$cQCMa/8c/cstJ8GAqUbIqOrZaE1wyIhi3BgwKSciYaoQujVwrqRA2', '0600000000', NULL, '5396840112'),
(150, 'Nanterre', 'France', '91 Boulevard Monsieur-le-Prince', '46435', '1990-01-01 00:00:00', '2022-06-22 16:56:24', 'axel.francois@examplemail.fr', 'Carla', 'Riviere', '$2a$12$2XyF8SxdpbBepratAWrgSuTENARCnaJrt6mW8GjEcAHkpLIczTvwu', '0600000000', NULL, '1542760473'),
(155, 'Bordeaux', 'France', '2884 Passage de Tilsitt', '81927', '1990-01-01 00:00:00', '2022-06-22 16:56:25', 'raphaël.lopez@examplemail.fr', 'Zoe', 'Lefevre', '$2a$12$ZgpKE4h6axEOYUyT5Ey6Be6I8SifFjvoi8rI53Zdc7SL8TSZ7hRi6', '0600000000', NULL, '2868268422');

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
(8, 0),
(10, 2),
(15, 2),
(20, 2),
(25, 2),
(30, 2),
(35, 2),
(40, 2),
(45, 2),
(50, 2),
(55, 2),
(60, 2),
(65, 2),
(70, 2),
(75, 2),
(80, 2),
(85, 2),
(90, 2),
(95, 2),
(100, 2),
(105, 2),
(110, 2),
(115, 2),
(120, 2),
(125, 2),
(130, 2),
(135, 2),
(140, 2),
(145, 2),
(150, 2),
(155, 2);

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
