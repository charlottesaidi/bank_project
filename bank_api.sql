-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 23 juin 2022 à 11:29
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
(5, 1056.47, '2022-06-23 11:09:30', 'CUR6782069', -1000, '2022-06-23 11:23:44', NULL, 4),
(12, 2019, '2022-06-23 11:09:31', 'CUR5712703', -1000, NULL, NULL, 11),
(17, 2869, '2022-06-23 11:09:31', 'CUR7737706', -1000, NULL, NULL, 16),
(22, 2749, '2022-06-23 11:09:32', 'CUR7775431', -1000, NULL, NULL, 21),
(27, 2685, '2022-06-23 11:09:33', 'CUR6852771', -1000, NULL, NULL, 26),
(32, 2651, '2022-06-23 11:09:34', 'CUR1960598', -1000, NULL, NULL, 31),
(37, 1288, '2022-06-23 11:09:34', 'CUR1049143', -1000, NULL, NULL, 36),
(42, 362, '2022-06-23 11:09:35', 'CUR4879683', -1000, NULL, NULL, 41),
(47, 495, '2022-06-23 11:09:36', 'CUR3311817', -1000, NULL, NULL, 46),
(52, 2004, '2022-06-23 11:09:37', 'CUR5422414', -1000, NULL, NULL, 51),
(57, 289, '2022-06-23 11:09:37', 'CUR0020561', -1000, NULL, NULL, 56),
(62, 1983, '2022-06-23 11:09:38', 'CUR1398919', -1000, NULL, NULL, 61),
(67, 2739, '2022-06-23 11:09:39', 'CUR7517051', -1000, NULL, NULL, 66),
(72, 2147, '2022-06-23 11:09:40', 'CUR9952292', -1000, NULL, NULL, 71),
(77, 1090, '2022-06-23 11:09:40', 'CUR8415931', -1000, NULL, NULL, 76),
(82, 2607, '2022-06-23 11:09:41', 'CUR1281566', -1000, NULL, NULL, 81),
(87, 2261, '2022-06-23 11:09:42', 'CUR4762803', -1000, NULL, NULL, 86),
(92, 2211, '2022-06-23 11:09:42', 'CUR9007175', -1000, NULL, NULL, 91),
(97, 881, '2022-06-23 11:09:43', 'CUR9150519', -1000, NULL, NULL, 96),
(102, 1097, '2022-06-23 11:09:44', 'CUR9010024', -1000, NULL, NULL, 101),
(107, 2040, '2022-06-23 11:09:45', 'CUR8761443', -1000, NULL, NULL, 106),
(112, 1152, '2022-06-23 11:09:45', 'CUR9709874', -1000, NULL, NULL, 111),
(117, 2596, '2022-06-23 11:09:46', 'CUR0752934', -1000, NULL, NULL, 116),
(122, 381, '2022-06-23 11:09:47', 'CUR0671268', -1000, NULL, NULL, 121),
(127, 2987, '2022-06-23 11:09:47', 'CUR2461194', -1000, NULL, NULL, 126),
(132, 1137, '2022-06-23 11:09:48', 'CUR6776063', -1000, NULL, NULL, 131),
(137, 1804, '2022-06-23 11:09:49', 'CUR5651237', -1000, NULL, NULL, 136),
(142, 805, '2022-06-23 11:09:50', 'CUR7357127', -1000, NULL, NULL, 141),
(147, 338, '2022-06-23 11:09:50', 'CUR6592684', -1000, NULL, NULL, 146),
(152, 1732, '2022-06-23 11:09:51', 'CUR7181985', -1000, NULL, NULL, 151),
(157, 1116, '2022-06-23 11:09:52', 'CUR2244397', -1000, NULL, NULL, 156);

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
(7, 1056.47, '2022-06-23 11:09:30', '2022-06-23 11:23:44', 5),
(14, 2019, '2022-06-23 11:09:31', NULL, 12),
(19, 2869, '2022-06-23 11:09:31', NULL, 17),
(24, 2749, '2022-06-23 11:09:32', NULL, 22),
(29, 2685, '2022-06-23 11:09:33', NULL, 27),
(34, 2651, '2022-06-23 11:09:34', NULL, 32),
(39, 1288, '2022-06-23 11:09:35', NULL, 37),
(44, 362, '2022-06-23 11:09:35', NULL, 42),
(49, 495, '2022-06-23 11:09:36', NULL, 47),
(54, 2004, '2022-06-23 11:09:37', NULL, 52),
(59, 289, '2022-06-23 11:09:37', NULL, 57),
(64, 1983, '2022-06-23 11:09:38', NULL, 62),
(69, 2739, '2022-06-23 11:09:39', NULL, 67),
(74, 2147, '2022-06-23 11:09:40', NULL, 72),
(79, 1090, '2022-06-23 11:09:40', NULL, 77),
(84, 2607, '2022-06-23 11:09:41', NULL, 82),
(89, 2261, '2022-06-23 11:09:42', NULL, 87),
(94, 2211, '2022-06-23 11:09:42', NULL, 92),
(99, 881, '2022-06-23 11:09:43', NULL, 97),
(104, 1097, '2022-06-23 11:09:44', NULL, 102),
(109, 2040, '2022-06-23 11:09:45', NULL, 107),
(114, 1152, '2022-06-23 11:09:45', NULL, 112),
(119, 2596, '2022-06-23 11:09:46', NULL, 117),
(124, 381, '2022-06-23 11:09:47', NULL, 122),
(129, 2987, '2022-06-23 11:09:47', NULL, 127),
(134, 1137, '2022-06-23 11:09:48', NULL, 132),
(139, 1804, '2022-06-23 11:09:49', NULL, 137),
(144, 805, '2022-06-23 11:09:50', NULL, 142),
(149, 338, '2022-06-23 11:09:50', NULL, 147),
(154, 1732, '2022-06-23 11:09:51', NULL, 152),
(159, 1116, '2022-06-23 11:09:52', NULL, 157);

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
(160, '2022-06-23 11:09:52', 'CPT_COURANT', 0, NULL),
(161, '2022-06-23 11:09:52', 'LIVRET_DEVELOPPEMENT_DURABLE', 0.6, NULL),
(162, '2022-06-23 11:09:52', 'LIVRET_A', 0.3, NULL);

--
-- Déclencheurs `account_types`
--
DELIMITER $$
CREATE TRIGGER `preventRateChange` BEFORE UPDATE ON `account_types` FOR EACH ROW BEGIN
        SELECT start_date, end_date INTO @start_date, @end_date FROM changing_rate_dates ORDER BY changing_rate_dates.id_changing_rate_date DESC LIMIT 1;
        SET @today = NOW();
        SET @start = DATE_FORMAT(@start_date, '%d/%m/%Y');
        SET @end = DATE_FORMAT(@end_date, '%d/%m/%Y');
        SET @error_message = CONCAT('Les taux ne sont changeables que dans la période du ', @start, ' au ', @end, '.');
        IF @today < @start_date OR @today > @end_date THEN
            signal sqlstate '42000' set MESSAGE_TEXT = @error_message;
        END IF;
END
$$
DELIMITER ;

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
(2, '2022-06-23 11:09:30', '8500617069', NULL, 1),
(9, '2022-06-23 11:09:30', '7878047917', NULL, 8);

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
(6, '2022-06-23 11:09:30', '250', '9357677827794656', NULL, '2024-06-23 11:09:30', 5),
(13, '2022-06-23 11:09:31', '169', '1893954600965933', NULL, '2024-06-23 11:09:31', 12),
(18, '2022-06-23 11:09:31', '717', '2078941832662461', NULL, '2024-06-23 11:09:31', 17),
(23, '2022-06-23 11:09:32', '866', '8024436704927348', NULL, '2024-06-23 11:09:32', 22),
(28, '2022-06-23 11:09:33', '236', '3143136242551145', NULL, '2024-06-23 11:09:33', 27),
(33, '2022-06-23 11:09:34', '077', '2897027409384676', NULL, '2024-06-23 11:09:34', 32),
(38, '2022-06-23 11:09:35', '680', '1907980163957913', NULL, '2024-06-23 11:09:34', 37),
(43, '2022-06-23 11:09:35', '089', '8095406624251924', NULL, '2024-06-23 11:09:35', 42),
(48, '2022-06-23 11:09:36', '381', '0898385892690888', NULL, '2024-06-23 11:09:36', 47),
(53, '2022-06-23 11:09:37', '210', '1098176197323550', NULL, '2024-06-23 11:09:37', 52),
(58, '2022-06-23 11:09:37', '214', '7994825443254783', NULL, '2024-06-23 11:09:37', 57),
(63, '2022-06-23 11:09:38', '508', '5168776895160126', NULL, '2024-06-23 11:09:38', 62),
(68, '2022-06-23 11:09:39', '058', '1152614171861725', NULL, '2024-06-23 11:09:39', 67),
(73, '2022-06-23 11:09:40', '039', '4364039688554568', NULL, '2024-06-23 11:09:40', 72),
(78, '2022-06-23 11:09:40', '548', '0796160700707307', NULL, '2024-06-23 11:09:40', 77),
(83, '2022-06-23 11:09:41', '071', '5764610185325727', NULL, '2024-06-23 11:09:41', 82),
(88, '2022-06-23 11:09:42', '274', '0640283793040611', NULL, '2024-06-23 11:09:42', 87),
(93, '2022-06-23 11:09:42', '010', '9743023684906000', NULL, '2024-06-23 11:09:42', 92),
(98, '2022-06-23 11:09:43', '015', '5852084033092992', NULL, '2024-06-23 11:09:43', 97),
(103, '2022-06-23 11:09:44', '022', '8030167660428752', NULL, '2024-06-23 11:09:44', 102),
(108, '2022-06-23 11:09:45', '628', '0617056127606327', NULL, '2024-06-23 11:09:45', 107),
(113, '2022-06-23 11:09:45', '562', '2788387415989864', NULL, '2024-06-23 11:09:45', 112),
(118, '2022-06-23 11:09:46', '317', '9918826019817547', NULL, '2024-06-23 11:09:46', 117),
(123, '2022-06-23 11:09:47', '917', '5677167082971706', NULL, '2024-06-23 11:09:47', 122),
(128, '2022-06-23 11:09:47', '028', '7768437451574765', NULL, '2024-06-23 11:09:47', 127),
(133, '2022-06-23 11:09:48', '835', '6095099187647372', NULL, '2024-06-23 11:09:48', 132),
(138, '2022-06-23 11:09:49', '344', '6711198604102325', NULL, '2024-06-23 11:09:49', 137),
(143, '2022-06-23 11:09:50', '332', '2544486228110229', NULL, '2024-06-23 11:09:50', 142),
(148, '2022-06-23 11:09:50', '164', '8082747698982495', NULL, '2024-06-23 11:09:50', 147),
(153, '2022-06-23 11:09:51', '750', '2720216415502171', NULL, '2024-06-23 11:09:51', 152),
(158, '2022-06-23 11:09:52', '200', '3309226976154603', NULL, '2024-06-23 11:09:52', 157);

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
(163, '2022-12-06 01:00:00', '2022-12-01 01:00:00');

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
(4, '2022-06-23 11:09:30', NULL, '9755215741', NULL, 2, 3),
(11, '2022-06-23 11:09:31', NULL, '7625884961', NULL, 2, 10),
(16, '2022-06-23 11:09:31', NULL, '4640696920', NULL, 2, 15),
(21, '2022-06-23 11:09:32', NULL, '3970197567', NULL, 2, 20),
(26, '2022-06-23 11:09:33', NULL, '5138870147', NULL, 2, 25),
(31, '2022-06-23 11:09:34', NULL, '4512274610', NULL, 2, 30),
(36, '2022-06-23 11:09:34', NULL, '6265487927', NULL, 2, 35),
(41, '2022-06-23 11:09:35', NULL, '2086775338', NULL, 2, 40),
(46, '2022-06-23 11:09:36', NULL, '1980726866', NULL, 2, 45),
(51, '2022-06-23 11:09:37', NULL, '0139547914', NULL, 2, 50),
(56, '2022-06-23 11:09:37', NULL, '7516757687', NULL, 2, 55),
(61, '2022-06-23 11:09:38', NULL, '1187672965', NULL, 2, 60),
(66, '2022-06-23 11:09:39', NULL, '2534769123', NULL, 2, 65),
(71, '2022-06-23 11:09:40', NULL, '8456364449', NULL, 2, 70),
(76, '2022-06-23 11:09:40', NULL, '3976443150', NULL, 2, 75),
(81, '2022-06-23 11:09:41', NULL, '4483884472', NULL, 2, 80),
(86, '2022-06-23 11:09:42', NULL, '1303399516', NULL, 2, 85),
(91, '2022-06-23 11:09:42', NULL, '1662120509', NULL, 2, 90),
(96, '2022-06-23 11:09:43', NULL, '7769532076', NULL, 2, 95),
(101, '2022-06-23 11:09:44', NULL, '8524776384', NULL, 2, 100),
(106, '2022-06-23 11:09:45', NULL, '0419209857', NULL, 2, 105),
(111, '2022-06-23 11:09:45', NULL, '8282593138', NULL, 2, 110),
(116, '2022-06-23 11:09:46', NULL, '8365899198', NULL, 2, 115),
(121, '2022-06-23 11:09:47', NULL, '7653796551', NULL, 2, 120),
(126, '2022-06-23 11:09:47', NULL, '8105386950', NULL, 2, 125),
(131, '2022-06-23 11:09:48', NULL, '1925929361', NULL, 2, 130),
(136, '2022-06-23 11:09:49', NULL, '7335649558', NULL, 2, 135),
(141, '2022-06-23 11:09:50', NULL, '4799493047', NULL, 2, 140),
(146, '2022-06-23 11:09:50', NULL, '7206869272', NULL, 2, 145),
(151, '2022-06-23 11:09:51', NULL, '7475829026', NULL, 2, 150),
(156, '2022-06-23 11:09:52', NULL, '0611895656', NULL, 2, 155);

--
-- Déclencheurs `customers`
--
DELIMITER $$
CREATE TRIGGER `preventClientRegistrationOnWE` BEFORE INSERT ON `customers` FOR EACH ROW BEGIN
        CALL throwExceptionIfWeekend();
END
$$
DELIMITER ;

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
(4, 'attestation_domicile'),
(4, 'piece_id'),
(4, 'avis_impots'),
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
(156, 'avis_impots'),
(4, 'attestation_domicile'),
(4, 'piece_id'),
(4, 'avis_impots'),
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
(167),
(167);

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
(164, 29.99, '2022-06-23 11:23:44', 'Prélèvement Orange Mobile', NULL, NULL, 5),
(165, 63.54, '2022-06-23 11:24:24', 'Carrefour Market', NULL, NULL, 5),
(166, 650, '2022-06-23 11:24:51', 'Virement Loyer', NULL, NULL, 5);

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
(164, 1),
(165, 1),
(166, 1);

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
(1, 'Drancy', 'France', '164 Quai Monsieur-le-Prince', '35673', '1990-01-01 00:00:00', '2022-06-23 11:09:29', 'banker@example.fr', 'Banker', 'Test', '$2a$12$gIYOJ732/xTsdfFbyIVVVuOxBSLhAdQxs.s64WqjBUGvl0wKzxMPO', '0864058673', NULL, '8500617069'),
(3, 'Asnières-sur-Seine', 'France', '635 Place de Vaugirard', '42442', '1990-01-01 00:00:00', '2022-06-23 11:09:30', 'customer@example.fr', 'Customer', 'Test', '$2a$12$k//gJwJC4IQ.YOR39ZJRhOJcBKTmN2QJgjijuqi49B5b0Ux13z7bK', '0543682222', NULL, '9755215741'),
(8, 'Paris', 'France', '7 Impasse de la Harpe', '79341', '1990-01-01 00:00:00', '2022-06-23 11:09:30', 'director@example.fr', 'Director', 'Test', '$2a$12$qen8Vje66nAHJUOk6aMZcOqtU.36D0HVB7BCVktwW.UCsQqin4FRm', '0248643976', NULL, '7878047917'),
(10, 'Poitiers', 'France', '04 Quai de Seine', '30100', '1990-01-01 00:00:00', '2022-06-23 11:09:31', 'maëlys.collet@examplemail.fr', 'Antoine', 'Nicolas', '$2a$12$/GkgzU1TbZiNTzvPSHeRMOELg3HspzkvgqaKhYISjqn1J3ue3fCVy', '0652548243', NULL, '7625884961'),
(15, 'Calais', 'France', '16 Allée, Voie Charlemagne', '54363', '1990-01-01 00:00:00', '2022-06-23 11:09:31', 'paul.simon@examplemail.fr', 'Alice', 'Deschamps', '$2a$12$3btqBtqaQppvfv/5/Wczaujyl/I3.lxKOSvRW9//FbIQUaR0f6xjS', '0991584366', NULL, '4640696920'),
(20, 'Besançon', 'France', '512 Place de Solférino', '69079', '1990-01-01 00:00:00', '2022-06-23 11:09:32', 'victor.rousseau@examplemail.fr', 'Mael', 'Durand', '$2a$12$4DT8PxO9sAFq93As1ehPBurQ/alObAf1XS6AX6L3xMMWmGUmW0oY6', '0898384282', NULL, '3970197567'),
(25, 'Clichy', 'France', '7116 Rue de Paris', '85888', '1990-01-01 00:00:00', '2022-06-23 11:09:33', 'lena.fontaine@examplemail.fr', 'Ambre', 'Richard', '$2a$12$WaYUT3KXnEwM/srK6iejPuY9eUM/wkrgUVZ58YqgnwqR484np7pmy', '0529100017', NULL, '5138870147'),
(30, 'Le Tampon', 'France', '4680 Quai de Nesle', '58847', '1990-01-01 00:00:00', '2022-06-23 11:09:34', 'alicia.fleury@examplemail.fr', 'Tom', 'Morin', '$2a$12$ns7CQTXoba/XPlI8MfUkFO0Lxq3h7meXrqeQ/oH074qd0Sascz.t.', '0687993475', NULL, '4512274610'),
(35, 'Orléans', 'France', '5812 Passage d\'Argenteuil', '56126', '1990-01-01 00:00:00', '2022-06-23 11:09:34', 'noa.nicolas@examplemail.fr', 'Paul', 'Lemaire', '$2a$12$VMFF7jSPqonGZ1XseD3wK.92zNGnP8VbnuCWkKY/HY9e2BJkNbF6.', '0581853538', NULL, '6265487927'),
(40, 'Colombes', 'France', '47 Rue Montorgueil', '19860', '1990-01-01 00:00:00', '2022-06-23 11:09:35', 'juliette.guerin@examplemail.fr', 'Célia', 'Meyer', '$2a$12$yi.pW0HGpue9Z2rWtynRAOJlbb7CF/Po4jBgLzzrB/BXTB16KCi6y', '0911227489', NULL, '2086775338'),
(45, 'Amiens', 'France', '0 Allée, Voie de Seine', '01579', '1990-01-01 00:00:00', '2022-06-23 11:09:36', 'marie.noel@examplemail.fr', 'Victor', 'Denis', '$2a$12$NJd0Tnrl6CkNiKPeR.0t6.ngnwnTncexW6iv8ce/vgv3CRw4JGTqG', '0822295604', NULL, '1980726866'),
(50, 'Rueil-Malmaison', 'France', '435 Place Dauphine', '63441', '1990-01-01 00:00:00', '2022-06-23 11:09:37', 'victor.denis@examplemail.fr', 'Hugo', 'Philippe', '$2a$12$lYSPBrTl0/a5y23KS2HMZ.hjgwlzFzL2C4b3l1Nryoci.peZiWDiG', '0303484897', NULL, '0139547914'),
(55, 'Saint-Nazaire', 'France', '6424 Boulevard Saint-Séverin', '53175', '1990-01-01 00:00:00', '2022-06-23 11:09:37', 'baptiste.laine@examplemail.fr', 'Manon', 'Thomas', '$2a$12$ApITrduKAwMqEry2dnwR.uUsLhups6nvPkD1.fwLegNTSb/fVjmRe', '0912979729', NULL, '7516757687'),
(60, 'Drancy', 'France', '5504 Place des Francs-Bourgeois', '31314', '1990-01-01 00:00:00', '2022-06-23 11:09:38', 'yanis.bonnet@examplemail.fr', 'Benjamin', 'Dupuy', '$2a$12$693csbSSqI/i/e9LU7Z8iO4Y8dKIW8yycBlsT97SahXRNffv95L8q', '0252466343', NULL, '1187672965'),
(65, 'Dunkerque14', 'France', '2 Rue de Nesle', '31676', '1990-01-01 00:00:00', '2022-06-23 11:09:39', 'célia.barre@examplemail.fr', 'Carla', 'Renard', '$2a$12$rR6usfJrNwMrHTQ50yGdQO45XImNGteliHtMVdibcF6lYL2RsUCYm', '0578434666', NULL, '2534769123'),
(70, 'Marseille', 'France', '048 Boulevard de la Harpe', '73553', '1990-01-01 00:00:00', '2022-06-23 11:09:40', 'alice.deschamps@examplemail.fr', 'Yanis', 'Nguyen', '$2a$12$b6THu7IkSDK4REWs0z3yve.iJh98yXMkpA.z9bXxmrz1KRzGehbua', '0997668551', NULL, '8456364449'),
(75, 'Aix-en-Provence', 'France', '6320 Passage de la Ferronnerie', '88751', '1990-01-01 00:00:00', '2022-06-23 11:09:40', 'louis.durand@examplemail.fr', 'Hugo', 'Cousin', '$2a$12$z9e5d0CxG72vQHB821v9OeTfTF4MCb0xOxb5FLMXV.y7bpVPWJHem', '0942128125', NULL, '3976443150'),
(80, 'Cannes', 'France', '6 Allée, Voie Marcadet', '67941', '1990-01-01 00:00:00', '2022-06-23 11:09:41', 'océane.guyot@examplemail.fr', 'Mael', 'Julien', '$2a$12$iAMHIhsHFED00IfxAY.Wwun.P5Yn2DCXuovvhM84Ze9NzwhOM2t2m', '0861062369', NULL, '4483884472'),
(85, 'Calais', 'France', '267 Place Joubert', '10120', '1990-01-01 00:00:00', '2022-06-23 11:09:42', 'gabriel.lacroix@examplemail.fr', 'Ethan', 'Dupuis', '$2a$12$fDQnWVrm2z0x15wPeU9GZuMeeKVR/BHP91FNhpd9zFvj7RHMzYgAS', '0452586178', NULL, '1303399516'),
(90, 'Mulhouse', 'France', '470 Passage de la Pompe', '42367', '1990-01-01 00:00:00', '2022-06-23 11:09:42', 'maeva.meyer@examplemail.fr', 'Ambre', 'Da silva', '$2a$12$Yl59FeA1/nGHLzP9Ch/keuoyvflUHEjPH776K8nfZX.SS7x8YH4Ba', '0455244519', NULL, '1662120509'),
(95, 'Boulogne-Billancourt', 'France', '895 Quai Dauphine', '89830', '1990-01-01 00:00:00', '2022-06-23 11:09:43', 'anaïs.roche@examplemail.fr', 'Maxime', 'Thomas', '$2a$12$0FYYEXolGaX7pp17kShQf.5ZByw9N0MhD5xKxLxJ/jN.8bBLJnLf6', '0392084135', NULL, '7769532076'),
(100, 'Tours', 'France', '17 Place de la Huchette', '49535', '1990-01-01 00:00:00', '2022-06-23 11:09:44', 'gabriel.leroy@examplemail.fr', 'Romain', 'Dumas', '$2a$12$nc3bbTIFBSjxkxVhjcSfmOlDaLO9Dh1o21WeeTcB8w3LF19b.LPU.', '0122801247', NULL, '8524776384'),
(105, 'Issy-les-Moulineaux', 'France', '50 Place Marcadet', '73156', '1990-01-01 00:00:00', '2022-06-23 11:09:45', 'clément.gaillard@examplemail.fr', 'Louis', 'Lopez', '$2a$12$4/WF4jC2r/c/thaAk7j59efAdDkKpxzANNPmr4vZ2ubRFyG7QfaR6', '0254245567', NULL, '0419209857'),
(110, 'Bordeaux', 'France', '24 Allée, Voie d\'Assas', '62179', '1990-01-01 00:00:00', '2022-06-23 11:09:45', 'camille.thomas@examplemail.fr', 'Antoine', 'Girard', '$2a$12$ZI/qc4r4lRbszs52AaM55.3iqA2bAv/P6wg3p9VJzJzaqLLVGJiFq', '0021705359', NULL, '8282593138'),
(115, 'Béziers', 'France', '91 Place Joubert', '69349', '1990-01-01 00:00:00', '2022-06-23 11:09:46', 'maxime.remy@examplemail.fr', 'Mathilde', 'Mercier', '$2a$12$/Clove9xOw2gEIkcxw1pkuAmtWKwc/u.kM6SRl4QryGMB7LODHDeq', '0742406764', NULL, '8365899198'),
(120, 'Saint-Pierre', 'France', '1055 Quai Molière', '78720', '1990-01-01 00:00:00', '2022-06-23 11:09:47', 'gabriel.huet@examplemail.fr', 'Louise', 'Robert', '$2a$12$dsv9y3jpzwP6fRTbnuOG6e5aR00yFTlLD82IsxKhHYhbZVoj5KwCG', '0473413654', NULL, '7653796551'),
(125, 'Beauvais', 'France', '6844 Place Pastourelle', '99123', '1990-01-01 00:00:00', '2022-06-23 11:09:47', 'clémence.denis@examplemail.fr', 'Hugo', 'Masson', '$2a$12$x/pGPvhLMSa6qsIHG1fljexMRNx.6BMl6XSBpF8RH8bvunkwwCW.q', '0461111618', NULL, '8105386950'),
(130, 'Avignon', 'France', '831 Impasse Saint-Denis', '43718', '1990-01-01 00:00:00', '2022-06-23 11:09:48', 'maëlle.morel@examplemail.fr', 'Mathis', 'Leclercq', '$2a$12$CErDxWEGI/EvYyleIWcMMe2uz.6j1XnLwjsNjjB.uDt5N719/jA/a', '0426014994', NULL, '1925929361'),
(135, 'Vitry-sur-Seine', 'France', '54 Allée, Voie Pastourelle', '89852', '1990-01-01 00:00:00', '2022-06-23 11:09:49', 'maëlle.le gall@examplemail.fr', 'Maxime', 'Martin', '$2a$12$WTkM7mjuPxCPp3ZkdZ7BYufFrrNkDkIEgHuU6ZoAsCaFgtvPt43Je', '0341495622', NULL, '7335649558'),
(140, 'Brest', 'France', '39 Allée, Voie Monsieur-le-Prince', '00613', '1990-01-01 00:00:00', '2022-06-23 11:09:50', 'jules.boyer@examplemail.fr', 'Lucie', 'Dubois', '$2a$12$OUyORUfz5lOQ0.dvcCyzq.vXXdn6Yl2AvbgSO9fb6/Wj3lCrVqBuC', '0128032611', NULL, '4799493047'),
(145, 'Tourcoing', 'France', '2167 Allée, Voie de la Harpe', '32691', '1990-01-01 00:00:00', '2022-06-23 11:09:50', 'lilou.cousin@examplemail.fr', 'Léa', 'Laine', '$2a$12$RvAHS1H8Jp4iQvxcMxeA9OMmxZHHMNnHewEg1oRunlgm5M1JF71Di', '0637692681', NULL, '7206869272'),
(150, 'Tours', 'France', '4240 Avenue de Seine', '65986', '1990-01-01 00:00:00', '2022-06-23 11:09:51', 'mathis.bertrand@examplemail.fr', 'Kylian', 'Lefevre', '$2a$12$XhbacrjxaGnCQIxHj4mqgubrTOC9wPx1mKR/b/RBPdwnCG.U8TCQC', '0520009607', NULL, '7475829026'),
(155, 'Argenteuil', 'France', '3 Boulevard Oberkampf', '33479', '1990-01-01 00:00:00', '2022-06-23 11:09:52', 'nathan.brun@examplemail.fr', 'Léa', 'Caron', '$2a$12$dpSu6LZhnpNyMg6aOoYW4.NmG/qSbeB6VCsYY0Ck0GxM4yffKKAaK', '0843745742', NULL, '0611895656');

--
-- Déclencheurs `users`
--
DELIMITER $$
CREATE TRIGGER `preventUserRegistrationOnWE` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
        CALL throwExceptionIfWeekend();
END
$$
DELIMITER ;

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
(1, 1),
(3, 2),
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
(155, 2),
(1, 1),
(3, 2),
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
  ADD UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`);

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
