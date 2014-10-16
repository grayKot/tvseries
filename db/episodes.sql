-- phpMyAdmin SQL Dump
-- version 4.0.6deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 16, 2014 at 09:40 PM
-- Server version: 5.5.35-0ubuntu0.13.10.1
-- PHP Version: 5.5.3-1ubuntu2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tvseries`
--

-- --------------------------------------------------------

--
-- Table structure for table `episodes`
--

CREATE TABLE IF NOT EXISTS `episodes` (
  `id` int(11) NOT NULL,
  `season_no` int(11) NOT NULL,
  `episod_no` int(11) NOT NULL,
  `series_name` varchar(250) NOT NULL,
  `episode_name` varchar(250) NOT NULL,
  `air_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `episodes`
--

INSERT INTO `episodes` (`id`, `season_no`, `episod_no`, `series_name`, `episode_name`, `air_date`) VALUES
(123, 13, 4, 'Family Guy', 'Brian the Closer', '2014-11-09'),
(1005881, 11, 3, 'American Dad', 'Blagsnarst, A Love Story', '2014-09-21'),
(1005905, 11, 2, 'American Dad', 'Blonde Ambition', '2014-10-13'),
(1010480, 13, 2, 'Family Guy', 'The Book of Joe', '2014-10-05'),
(1010482, 13, 3, 'Family Guy', 'Baking Bad', '2014-10-19'),
(1011144, 18, 3, 'South Park', 'The Cissy', '2014-10-08'),
(1011887, 18, 4, 'South Park', 'Handicar', '2014-10-15');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
