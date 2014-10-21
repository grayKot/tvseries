-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 21, 2014 at 07:15 PM
-- Server version: 5.5.40-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.4

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
  `episode_id` int(11) NOT NULL,
  `tv_id` int(11) NOT NULL,
  `season_no` int(11) NOT NULL,
  `episode_no` int(11) NOT NULL,
  `series_name` varchar(250) NOT NULL,
  `episode_name` varchar(250) NOT NULL,
  `air_date` date DEFAULT NULL,
  PRIMARY KEY (`episode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `episodes`
--

INSERT INTO `episodes` (`episode_id`, `tv_id`, `season_no`, `episode_no`, `series_name`, `episode_name`, `air_date`) VALUES
(66027, 1433, 10, 1, 'American Dad!', 'Steve and Snot''s Test-Tubular Adventure', '2013-09-29'),
(66028, 1433, 10, 2, 'American Dad!', 'Poltergasm', '2013-10-06'),
(66029, 1433, 10, 3, 'American Dad!', 'Buck, Wild', '2013-11-03'),
(66030, 1433, 10, 4, 'American Dad!', 'Crotchwalkers', '2013-11-10'),
(66031, 1433, 10, 5, 'American Dad!', 'Kung Pao Turkey', '2013-11-24'),
(66032, 1433, 10, 6, 'American Dad!', 'Independent Movie', '2013-12-01'),
(66280, 1434, 12, 1, 'Family Guy', 'Finders Keepers', '2013-09-29'),
(66281, 1434, 12, 2, 'Family Guy', 'Vestigial Peter', '2013-10-06'),
(66282, 1434, 12, 3, 'Family Guy', 'Quagmire''s Quagmire', '2013-11-03'),
(66283, 1434, 12, 4, 'Family Guy', 'A Fistful of Meg', '2013-11-10'),
(153841, 2190, 17, 1, 'South Park', 'Let Go, Let Gov', '2013-09-25'),
(153842, 2190, 17, 2, 'South Park', 'Informative Murder Porn', '2013-10-02'),
(153843, 2190, 17, 3, 'South Park', 'World War Zimmerman', '2013-10-09'),
(153844, 2190, 17, 4, 'South Park', 'Goth Kids 3: Dawn of the Posers', '2013-10-23'),
(153845, 2190, 17, 5, 'South Park', 'Taming Strange', '2013-10-30'),
(153846, 2190, 17, 6, 'South Park', 'Ginger Cow', '2013-11-06'),
(153847, 2190, 17, 7, 'South Park', 'Black Friday', '2013-11-13'),
(153848, 2190, 17, 8, 'South Park', 'A Song of Ass and Fire', '2013-11-20'),
(153849, 2190, 17, 9, 'South Park', 'Titties and Dragons', '2013-12-04'),
(153850, 2190, 17, 10, 'South Park', 'The Hobbit', '2013-12-11'),
(769797, 32726, 3, 1, 'Bob''s Burgers', 'Ear-sy Rider', '2012-09-30'),
(769798, 32726, 3, 2, 'Bob''s Burgers', 'Full Bars', '2012-10-07'),
(769799, 32726, 3, 3, 'Bob''s Burgers', 'Bob Fires the Kids', '2012-11-04'),
(769800, 32726, 3, 5, 'Bob''s Burgers', 'An Indecent Thanksgiving Proposal', '2012-11-18'),
(769801, 32726, 3, 4, 'Bob''s Burgers', 'Mutiny on the Windbreaker', '2012-11-11'),
(769802, 32726, 3, 6, 'Bob''s Burgers', 'The Deepening', '2012-11-25'),
(769803, 32726, 3, 7, 'Bob''s Burgers', 'Tina-rannosaurus Wrecks', '2012-12-02'),
(769804, 32726, 3, 8, 'Bob''s Burgers', 'The Unbearable Like-Likeness of Gene', '2012-12-09'),
(769805, 32726, 3, 9, 'Bob''s Burgers', 'God Rest Ye Merry Gentle-Mannequins', '2012-12-16'),
(769806, 32726, 3, 10, 'Bob''s Burgers', 'Mother Daughter Laser Razor', '2013-01-06'),
(769807, 32726, 3, 11, 'Bob''s Burgers', 'Nude Beach', '2013-01-13'),
(769808, 32726, 3, 12, 'Bob''s Burgers', 'Broadcast Wagstaff School News', '2013-01-27'),
(769809, 32726, 3, 14, 'Bob''s Burgers', 'Lindapendent Woman', '2013-02-17'),
(769810, 32726, 3, 13, 'Bob''s Burgers', 'My Fuzzy Valentine', '2013-02-10'),
(769811, 32726, 3, 15, 'Bob''s Burgers', 'O.T.: The Outside Toilet', '2013-03-03'),
(769812, 32726, 3, 16, 'Bob''s Burgers', 'Topsy', '2013-03-10'),
(769813, 32726, 3, 18, 'Bob''s Burgers', 'It Snakes a Village', '2013-03-24'),
(769814, 32726, 3, 17, 'Bob''s Burgers', 'Two for Tina', '2013-03-17'),
(769815, 32726, 3, 23, 'Bob''s Burgers', 'The Unnatural', '2013-05-12'),
(769816, 32726, 3, 22, 'Bob''s Burgers', 'Carpe Museum', '2013-05-05'),
(769817, 32726, 3, 21, 'Bob''s Burgers', 'Boyz 4 Now', '2013-04-28'),
(769818, 32726, 3, 20, 'Bob''s Burgers', 'The Kids Run the Restaurant', '2013-04-21'),
(769819, 32726, 3, 19, 'Bob''s Burgers', 'Family Fracas', '2013-04-14'),
(769823, 32726, 4, 1, 'Bob''s Burgers', 'A River Runs Through Bob', '2013-09-29'),
(769824, 32726, 4, 8, 'Bob''s Burgers', 'Bob and Deliver', '0000-00-00'),
(769825, 32726, 4, 11, 'Bob''s Burgers', 'I Get Psy-chic Out of You', '0000-00-00'),
(769826, 32726, 4, 12, 'Bob''s Burgers', 'Mazel Tina', '0000-00-00'),
(769827, 32726, 4, 9, 'Bob''s Burgers', 'Easy Com-mercial, Easy Go-mercial', '0000-00-00'),
(769828, 32726, 4, 10, 'Bob''s Burgers', 'Presto Tina-o', '0000-00-00'),
(769829, 32726, 4, 6, 'Bob''s Burgers', 'Turkey in a Can', '0000-00-00'),
(769830, 32726, 4, 5, 'Bob''s Burgers', 'Purple Rain-union', '0000-00-00'),
(769831, 32726, 4, 2, 'Bob''s Burgers', 'My Big Fat Greek Bob', '2013-10-06'),
(769832, 32726, 4, 3, 'Bob''s Burgers', 'Fort Night', '2013-11-03'),
(769833, 32726, 4, 4, 'Bob''s Burgers', 'Seaplane!', '0000-00-00'),
(769834, 32726, 4, 7, 'Bob''s Burgers', 'Christmas in the Car', '0000-00-00'),
(968813, 1433, 10, 7, 'American Dad!', 'Faking Bad', '2013-12-08'),
(968814, 1434, 12, 7, 'Family Guy', 'Into HarmonyÃ¢Â€Â™s Way', '2013-12-08'),
(968953, 1433, 10, 8, 'American Dad!', 'Minstrel Krampus', '2013-12-15'),
(969004, 1434, 12, 8, 'Family Guy', 'Christmas Guy', '2013-12-15'),
(969041, 1433, 10, 10, 'American Dad!', 'Familyland', '2014-01-12'),
(969042, 1433, 10, 11, 'American Dad!', 'Cock of the Sleepwalk', '2014-01-26'),
(969043, 1433, 10, 13, 'American Dad!', 'I AinÃ¢Â€Â™t No Holodeck Boy', '2014-03-23'),
(969044, 1433, 10, 14, 'American Dad!', 'Stan Goes On the Pill', '2014-03-30'),
(969088, 1433, 10, 9, 'American Dad!', 'Vision: Impossible', '2014-01-05'),
(969922, 1434, 12, 5, 'Family Guy', 'Bobba-Dee Babba-Dee', '2013-11-17'),
(969923, 1434, 12, 6, 'Family Guy', 'Life of Brian', '2013-11-24'),
(970224, 1434, 12, 9, 'Family Guy', 'Peter Problems', '2014-01-05'),
(970225, 1434, 12, 10, 'Family Guy', 'Grimm Job', '2014-01-12'),
(970855, 1434, 12, 11, 'Family Guy', 'Brian''s a Bad Father', '2014-01-26'),
(972585, 1434, 12, 12, 'Family Guy', 'Mom''s the Word', '2014-03-09'),
(972961, 32726, 4, 13, 'Bob''s Burgers', 'Mazel-Tina', '2014-03-16'),
(972979, 1434, 12, 13, 'Family Guy', '3 Acts of God', '2014-03-16'),
(973231, 32726, 4, 14, 'Bob''s Burgers', 'Uncle Teddy', '2014-03-23'),
(973255, 1434, 12, 14, 'Family Guy', 'Fresh Heir', '2014-03-23'),
(973272, 1434, 12, 15, 'Family Guy', 'Secondhand Spoke', '2014-03-30'),
(973456, 32726, 4, 15, 'Bob''s Burgers', 'The Kids Rob a Train', '2014-03-30'),
(973658, 1433, 10, 19, 'American Dad!', 'News Glance With Genevieve Vavance', '2014-05-11'),
(973690, 1433, 10, 15, 'American Dad!', 'Honey, I''m Homeland', '2014-04-06'),
(973721, 32726, 4, 16, 'Bob''s Burgers', 'I Get Psychic Out Of You', '2014-04-06'),
(973776, 1434, 12, 16, 'Family Guy', 'Herpe the Love Sore', '2014-04-06'),
(974020, 1434, 12, 17, 'Family Guy', 'The Most Interesting Man in the World', '2014-04-13'),
(974118, 32726, 4, 17, 'Bob''s Burgers', 'The Equestranauts', '2014-04-13'),
(974140, 1433, 10, 16, 'American Dad!', 'She Swill Survive', '2014-04-13'),
(974234, 32726, 4, 18, 'Bob''s Burgers', 'Ambergris', '2014-04-20'),
(974419, 1434, 12, 18, 'Family Guy', 'Baby Got Black', '2014-04-27'),
(974672, 32726, 4, 19, 'Bob''s Burgers', 'The Kids Run Away', '2014-04-27'),
(974840, 1434, 12, 19, 'Family Guy', 'Meg Stinks!', '2014-05-04'),
(974907, 1433, 10, 12, 'American Dad!', 'Introducing the Naughty Stewardesses', '2014-03-16'),
(974908, 1433, 10, 18, 'American Dad!', 'Permanent Record Wrecker', '2014-05-04'),
(975277, 1433, 10, 20, 'American Dad!', 'The Longest Distance Relationship', '2014-05-18'),
(975279, 1434, 12, 20, 'Family Guy', 'HeÃ¢Â€Â™s Bla-ack', '2014-05-11'),
(975280, 1434, 12, 21, 'Family Guy', 'Chap Stewie', '2014-05-18'),
(975327, 32726, 4, 20, 'Bob''s Burgers', 'Gene It On', '2014-05-04'),
(975397, 1433, 10, 17, 'American Dad!', 'Rubberneckers', '2014-04-27'),
(975415, 32726, 4, 21, 'Bob''s Burgers', 'Wharf Horse (or How Bob Saves/Destroys the Town) (1)', '2014-05-11'),
(975542, 32726, 4, 22, 'Bob''s Burgers', 'World Wharf II: The Wharfening (or How Bob Saves/Destroys the Town) (2)', '2014-05-18'),
(1000649, 1434, 13, 1, 'Family Guy', 'The Simpsons Guy', '2014-09-28'),
(1005879, 1433, 11, 1, 'American Dad!', 'Roger Passes the Bar', '2014-09-14'),
(1005880, 1433, 11, 2, 'American Dad!', 'A Boy Named Michael', '2014-09-14'),
(1005881, 1433, 11, 3, 'American Dad!', 'Blagsnarst, A Love Story', '2014-09-21'),
(1005905, 1433, 11, 4, 'American Dad!', 'Brobot', '0000-00-00'),
(1005906, 1433, 11, 5, 'American Dad!', 'Scents and Sensei-bility', '0000-00-00'),
(1005907, 1433, 11, 6, 'American Dad!', 'Now and Gwen', '0000-00-00'),
(1005908, 1433, 11, 13, 'American Dad!', 'Holy Shit, Jeff''s Back!', '0000-00-00'),
(1009440, 2190, 18, 1, 'South Park', 'Go Fund Yourself', '2014-09-24'),
(1010231, 2190, 18, 2, 'South Park', 'Gluten Free Ebola', '2014-10-01'),
(1010480, 1434, 13, 2, 'Family Guy', 'The Book of Joe', '2014-10-05'),
(1010482, 1434, 13, 3, 'Family Guy', 'Baking Bad', '2014-10-19'),
(1011144, 2190, 18, 3, 'South Park', 'The Cissy', '2014-10-08'),
(1011887, 2190, 18, 4, 'South Park', 'Handicar', '2014-10-15'),
(1012097, 1434, 13, 4, 'Family Guy', 'Brian the Closer', '2014-11-09');

-- --------------------------------------------------------

--
-- Table structure for table `tv`
--

CREATE TABLE IF NOT EXISTS `tv` (
  `tv_id` int(11) NOT NULL,
  `tv_name` varchar(250) NOT NULL,
  PRIMARY KEY (`tv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tv`
--

INSERT INTO `tv` (`tv_id`, `tv_name`) VALUES
(1433, 'American Dad'),
(1434, 'Famly Guy'),
(2190, 'South Park');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
