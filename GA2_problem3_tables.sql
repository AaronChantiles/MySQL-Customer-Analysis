-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 12, 2017 at 07:02 AM
-- Server version: 10.1.19-MariaDB
-- PHP Version: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nm-problem3`
--

-- --------------------------------------------------------

--
-- Table structure for table `conf1`
--

CREATE TABLE `conf1` (
  `Name` varchar(30) NOT NULL,
  `c1_presentation_date` date NOT NULL,
  `c1_presentation_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conf1`
--

INSERT INTO `conf1` (`Name`, `c1_presentation_date`, `c1_presentation_type`) VALUES
('M. Rogers', '2016-04-12', 'poster'),
('V. Shah', '2016-04-11', 'talk'),
('K. Daniels', '2016-04-10', 'talk'),
('K. Prasana', '2016-04-12', 'poster'),
('V. Stavros', '2016-04-11', 'poster'),
('A. Kleiner', '2016-04-12', 'talk'),
('B. Schneider', '2016-04-09', 'poster'),
('V. Mathews', '2016-04-09', 'talk'),
('D. Bartens', '2016-04-11', 'talk'),
('S. Valeros', '2016-04-10', 'talk'),
('T. Krishnan', '2016-04-12', 'poster'),
('S. Kim', '2016-04-11', 'talk'),
('S. Gruber', '2016-04-09', 'poster'),
('T. Caulkins', '2016-04-10', 'talk');

-- --------------------------------------------------------

--
-- Table structure for table `conf2`
--

CREATE TABLE `conf2` (
  `Name` varchar(30) NOT NULL,
  `c2_presentation_date` date NOT NULL,
  `c2_presentation_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conf2`
--

INSERT INTO `conf2` (`Name`, `c2_presentation_date`, `c2_presentation_type`) VALUES
('B. Lanier', '2016-07-23', 'talk'),
('V. Shah', '2016-07-21', 'talk'),
('K. Daniels', '2016-07-22', 'poster'),
('A. Kleiner', '2016-07-23', 'talk'),
('D. Adams', '2016-07-24', 'poster'),
('T. Caulkins', '2016-07-21', 'talk'),
('J. Graham', '2016-07-23', 'poster'),
('S. Nichols', '2016-07-22', 'talk'),
('T. Krishnan', '2016-07-22', 'poster'),
('V. Stavros', '2016-07-21', 'talk'),
('B. Schneider', '2016-07-22', 'talk'),
('V. Almagro', '2016-07-21', 'poster');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
