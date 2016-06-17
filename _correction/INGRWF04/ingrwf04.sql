-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mar 31 Mai 2016 à 15:18
-- Version du serveur :  5.6.24
-- Version de PHP :  5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `ingrwf04`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresses`
--

CREATE TABLE IF NOT EXISTS `adresses` (
  `id_adresses` tinyint(3) unsigned NOT NULL,
  `rue` varchar(250) NOT NULL,
  `id_city` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `adresses`
--

INSERT INTO `adresses` (`id_adresses`, `rue`, `id_city`) VALUES
(1, 'rue du Pouly', 1),
(2, 'Rue des Ecoles', 1),
(3, 'Place Albert 1er', 12),
(4, 'Rue Neuve', 2),
(5, 'Bd Tirou', 2),
(6, 'Rue des Alexandrins', 3),
(7, 'Georges Lemaitre 22', 0);

-- --------------------------------------------------------

--
-- Structure de la table `cities`
--

CREATE TABLE IF NOT EXISTS `cities` (
  `id_cities` smallint(5) unsigned NOT NULL,
  `cp` smallint(10) NOT NULL,
  `city` varchar(250) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `cities`
--

INSERT INTO `cities` (`id_cities`, `cp`, `city`) VALUES
(1, 5600, 'Jamagne'),
(2, 6000, 'Charleroi'),
(3, 4020, 'Liège'),
(4, 5000, 'Namur');

-- --------------------------------------------------------

--
-- Structure de la table `l_p_add`
--

CREATE TABLE IF NOT EXISTS `l_p_add` (
  `id_l_p_add` int(10) unsigned NOT NULL,
  `id_personne` tinyint(3) unsigned NOT NULL,
  `id_adresse` tinyint(3) unsigned NOT NULL,
  `domicile` tinyint(1) NOT NULL DEFAULT '0',
  `num` varchar(5) NOT NULL,
  `bte` varchar(5) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `tel` int(11) DEFAULT NULL,
  `gaz` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `l_p_add`
--

INSERT INTO `l_p_add` (`id_l_p_add`, `id_personne`, `id_adresse`, `domicile`, `num`, `bte`, `floor`, `tel`, `gaz`) VALUES
(1, 1, 1, 1, '76', NULL, 2, NULL, 8560),
(2, 1, 2, 0, '12', NULL, 1, 4, NULL),
(3, 2, 1, 1, '76', '2', 1, NULL, NULL),
(4, 3, 3, 1, '48', '2', NULL, NULL, NULL),
(5, 4, 12, 1, '2', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `personnes`
--

CREATE TABLE IF NOT EXISTS `personnes` (
  `id_personnes` tinyint(3) unsigned NOT NULL,
  `nom` varchar(150) NOT NULL,
  `prenom` varchar(150) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `ddn` date DEFAULT NULL,
  `salaire` decimal(7,2) unsigned DEFAULT NULL,
  `genre` enum('f','m') DEFAULT 'f',
  `inscription` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `personnes`
--

INSERT INTO `personnes` (`id_personnes`, `nom`, `prenom`, `email`, `ddn`, `salaire`, `genre`, `inscription`) VALUES
(1, 'Charlier', 'Pierre', 'pcepegra@gmail.com', '2016-05-03', '1589.45', 'm', 1),
(2, 'charlier', 'benoit', NULL, NULL, NULL, 'm', 0),
(3, 'Van Grunderbeecq', 'Martine', 'mvg@gmail.com', NULL, NULL, 'f', 1),
(4, 'charlier', 'Sophie', 'sp@gmail.com', NULL, NULL, 'f', 0),
(5, 'Proust', 'Marcel', NULL, '2016-05-01', '2456.00', 'm', 1),
(6, 'Dupont', 'Pierre', 'dupontP@gmail.com', NULL, '1428.32', 'm', 1),
(7, 'Shot', 'Edgar', NULL, '2015-11-15', NULL, 'm', 0);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `personnes_residences`
--
CREATE TABLE IF NOT EXISTS `personnes_residences` (
`id_personnes` tinyint(3) unsigned
,`nom` varchar(150)
,`prenom` varchar(150)
,`cp` smallint(10)
,`city` varchar(250)
,`id_cities` smallint(5) unsigned
,`id_adresses` tinyint(3) unsigned
,`rue` varchar(250)
);

-- --------------------------------------------------------

--
-- Structure de la table `requests`
--

CREATE TABLE IF NOT EXISTS `requests` (
  `id_requests` int(10) unsigned NOT NULL,
  `request` text COLLATE utf8_general_mysql500_ci NOT NULL,
  `description` varchar(200) COLLATE utf8_general_mysql500_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

--
-- Contenu de la table `requests`
--

INSERT INTO `requests` (`id_requests`, `request`, `description`) VALUES
(1, 'SELECT personnes.id_personnes, personnes.nom, personnes.prenom, cities.cp, cities.city, cities.id_cities, adresses.id_adresses, adresses.rue FROM personnes\r\nLEFT JOIN l_p_add ON personnes.id_personnes = l_p_add.id_personne\r\nLEFT JOIN adresses ON l_p_add.id_adresse = adresses.id_adresses\r\nLEFT JOIN cities ON adresses.id_city = cities.id_cities', 'toutes les personnes et ses lieux de résidence');

-- --------------------------------------------------------

--
-- Structure de la vue `personnes_residences`
--
DROP TABLE IF EXISTS `personnes_residences`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `personnes_residences` AS select `personnes`.`id_personnes` AS `id_personnes`,`personnes`.`nom` AS `nom`,`personnes`.`prenom` AS `prenom`,`cities`.`cp` AS `cp`,`cities`.`city` AS `city`,`cities`.`id_cities` AS `id_cities`,`adresses`.`id_adresses` AS `id_adresses`,`adresses`.`rue` AS `rue` from (((`personnes` left join `l_p_add` on((`personnes`.`id_personnes` = `l_p_add`.`id_personne`))) left join `adresses` on((`l_p_add`.`id_adresse` = `adresses`.`id_adresses`))) left join `cities` on((`adresses`.`id_city` = `cities`.`id_cities`)));

--
-- Index pour les tables exportées
--

--
-- Index pour la table `adresses`
--
ALTER TABLE `adresses`
  ADD PRIMARY KEY (`id_adresses`), ADD KEY `id_city` (`id_city`);

--
-- Index pour la table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id_cities`), ADD KEY `ville` (`city`), ADD KEY `cp` (`cp`);

--
-- Index pour la table `l_p_add`
--
ALTER TABLE `l_p_add`
  ADD PRIMARY KEY (`id_l_p_add`), ADD KEY `id_personne` (`id_personne`), ADD KEY `id_adresse` (`id_adresse`);

--
-- Index pour la table `personnes`
--
ALTER TABLE `personnes`
  ADD PRIMARY KEY (`id_personnes`), ADD UNIQUE KEY `email` (`email`), ADD KEY `nom` (`nom`), ADD KEY `prenom` (`prenom`);

--
-- Index pour la table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id_requests`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `adresses`
--
ALTER TABLE `adresses`
  MODIFY `id_adresses` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `cities`
--
ALTER TABLE `cities`
  MODIFY `id_cities` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `l_p_add`
--
ALTER TABLE `l_p_add`
  MODIFY `id_l_p_add` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `personnes`
--
ALTER TABLE `personnes`
  MODIFY `id_personnes` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `requests`
--
ALTER TABLE `requests`
  MODIFY `id_requests` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
