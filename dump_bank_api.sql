-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 03 juin 2022 à 14:18
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
DROP PROCEDURE IF EXISTS `throwExceptionIfWeekend`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `throwExceptionIfWeekend` ()  BEGIN
    SET @today = DAYOFWEEK(NOW());
    SET @current_hour = DATE_FORMAT(NOW(), "%T");
    SET @error_message = 'Vous ne pouvez pas enregistrer de client ou de compte en dehors des jours ouvrés';
    IF (@today = 6 AND @current_hour > '12:00:00')
    OR @today = 7
    OR (@today = 1 AND @current_hour < '12:00:00') THEN
        signal sqlstate '42000' set MESSAGE_TEXT = @error_message;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
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
(10, 300, '2022-06-02 23:08:38', 'LVA0253884', -500, NULL, 9, 4),
(13, 300, '2022-06-02 23:09:09', 'CUR3966550', -500, NULL, 7, 4);

-- --------------------------------------------------------

--
-- Structure de la table `account_balances`
--

DROP TABLE IF EXISTS `account_balances`;
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
(12, 300, '2022-06-02 23:08:38', NULL, 10),
(15, 300, '2022-06-02 23:09:09', NULL, 13);

-- --------------------------------------------------------

--
-- Structure de la table `account_types`
--

DROP TABLE IF EXISTS `account_types`;
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
(7, '2022-06-02 22:37:20', 'CPT_COURANT', 0, NULL),
(8, '2022-06-02 22:37:21', 'LIVRET_DEVELOPPENT_DURABLE', 0.6, NULL),
(9, '2022-06-02 22:37:21', 'LIVRET_A', 0.3, NULL);

--
-- Déclencheurs `account_types`
--
DROP TRIGGER IF EXISTS `preventRateChange`;
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

DROP TABLE IF EXISTS `bankers`;
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
(2, '2022-06-02 21:52:03', '1GPDH7Z0OQ', NULL, 1),
(6, '2022-06-02 21:52:03', 'LQF0QOBTX9', NULL, 5);

-- --------------------------------------------------------

--
-- Structure de la table `cards`
--

DROP TABLE IF EXISTS `cards`;
CREATE TABLE `cards` (
  `id_card` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `cvc` int(11) NOT NULL,
  `number` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `validity_date` datetime DEFAULT NULL,
  `id_account` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `cards`
--

INSERT INTO `cards` (`id_card`, `created_at`, `cvc`, `number`, `updated_at`, `validity_date`, `id_account`) VALUES
(11, '2022-06-02 23:08:38', 258, '3256784555664242', NULL, '2023-05-01 02:00:00', 10),
(14, '2022-06-02 23:09:09', 258, '3254589635664242', NULL, '2023-05-01 02:00:00', 13);

-- --------------------------------------------------------

--
-- Structure de la table `changing_rate_dates`
--

DROP TABLE IF EXISTS `changing_rate_dates`;
CREATE TABLE `changing_rate_dates` (
  `id_changing_rate_date` int(11) NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `start_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `customers`
--

DROP TABLE IF EXISTS `customers`;
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
(4, '2022-06-02 21:52:03', NULL, 'XG726DMWSK', NULL, 2, 3),
(18, '2022-06-03 11:11:53', NULL, '6041225648', NULL, 2, 16),
(19, '2022-06-03 11:35:25', NULL, '9998187814', NULL, 2, 16),
(20, '2022-06-03 12:02:53', NULL, '5831002865', NULL, 2, 16),
(21, '2022-06-03 12:22:20', NULL, '0161835756', NULL, 2, 16);

--
-- Déclencheurs `customers`
--
DROP TRIGGER IF EXISTS `preventClientRegistrationOnWE`;
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

DROP TABLE IF EXISTS `customer_document_type`;
CREATE TABLE `customer_document_type` (
  `customer_id_customer` int(11) NOT NULL,
  `document_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `customer_document_type`
--

INSERT INTO `customer_document_type` (`customer_id_customer`, `document_type`) VALUES
(18, 'attestation_domicile'),
(18, 'piece_id'),
(18, 'avis_impots'),
(4, 'attestation_domicile'),
(4, 'piece_id'),
(4, 'avis_impots'),
(4, 'bulletin_salaire'),
(4, 'bulletin_salaire'),
(19, 'attestation_domicile'),
(19, 'piece_id'),
(19, 'avis_impots'),
(20, 'attestation_domicile'),
(20, 'piece_id'),
(20, 'avis_impots'),
(21, 'attestation_domicile'),
(21, 'piece_id'),
(21, 'avis_impots');

-- --------------------------------------------------------

--
-- Structure de la table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `hibernate_sequence`
--

INSERT INTO `hibernate_sequence` (`next_val`) VALUES
(22);

-- --------------------------------------------------------

--
-- Structure de la table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id_transaction` int(11) NOT NULL,
  `amount` float NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `id_account_credit` int(11) DEFAULT NULL,
  `id_account_debit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `transaction_description`
--

DROP TABLE IF EXISTS `transaction_description`;
CREATE TABLE `transaction_description` (
  `transaction_id_transaction` int(11) NOT NULL,
  `description` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
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
(1, 'Rouen', 'France', 'rue test', '76000', '1990-01-01 00:00:00', '2022-06-02 21:52:02', 'banker@example.fr', 'Banker', 'Test', '$2a$12$CUwjchc/w92j1uCYB/M.9uNzMIT/0XjbpBkUJEatNhBU3VPaSxnj.', '0600000000', NULL, '1GPDH7Z0OQ'),
(3, 'Rouen', 'France', 'nouvelle adresse', '76000', '1990-01-01 00:00:00', '2022-06-02 21:52:03', 'nouveaumailclient@mail.fr', 'Customer', 'nouveau nom', '$2a$12$TYqCsewbxFmLe/A92xrQT.x0qRbHTFkCdtGvC1TuIbdXAKA.Q8oo6', '0600000000', '2022-06-03 10:11:52', 'XG726DMWSK'),
(5, 'Rouen', 'France', 'rue test', '76000', '1990-01-01 00:00:00', '2022-06-02 21:52:03', 'director@example.fr', 'Director', 'Test', '$2a$12$3YB45pAUy3.N9/HJW9jheecO9tpd6M3XmXrYimHjbrj3PSiLA6/3i', '0600000000', NULL, 'LQF0QOBTX9'),
(16, 'Rouen', 'France', 'rue test', '76000', '1990-01-01 00:00:00', '2022-06-03 10:24:55', 'customer@example.fr', 'Customer', 'Test', '$2a$12$3OcOHeoeNSvAUzOSSuNueOmiUWhCUXOEveOTsDmRfriM/ud1vweeS', '0600000000', NULL, '4360697811');

--
-- Déclencheurs `users`
--
DROP TRIGGER IF EXISTS `preventUserRegistrationOnWE`;
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

DROP TABLE IF EXISTS `user_role`;
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
(5, 0),
(16, 2);

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
