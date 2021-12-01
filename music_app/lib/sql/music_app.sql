-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2021 at 04:08 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `music_app`
--
CREATE DATABASE IF NOT EXISTS `music_app` DEFAULT CHARACTER SET cp1250 COLLATE cp1250_croatian_ci;
USE `music_app`;

-- --------------------------------------------------------

--
-- Table structure for table `albums`
--

CREATE TABLE `albums` (
  `id` bigint(20) NOT NULL,
  `title` varchar(150) COLLATE cp1250_croatian_ci NOT NULL,
  `date_of_release` date DEFAULT NULL,
  `artist_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1250 COLLATE=cp1250_croatian_ci;

--
-- Dumping data for table `albums`
--

INSERT INTO `albums` (`id`, `title`, `date_of_release`, `artist_id`) VALUES
(1, 'SoundHelix.com', '2021-11-30', 1);

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `id` int(11) NOT NULL,
  `name` varchar(150) COLLATE cp1250_croatian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1250 COLLATE=cp1250_croatian_ci;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `name`) VALUES
(1, 'T. Schurger');

-- --------------------------------------------------------

--
-- Table structure for table `playlists`
--

CREATE TABLE `playlists` (
  `id` bigint(20) NOT NULL,
  `title` varchar(200) COLLATE cp1250_croatian_ci NOT NULL,
  `date_of_creation` date NOT NULL,
  `image_path` text COLLATE cp1250_croatian_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `description` text COLLATE cp1250_croatian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1250 COLLATE=cp1250_croatian_ci;

--
-- Dumping data for table `playlists`
--

INSERT INTO `playlists` (`id`, `title`, `date_of_creation`, `image_path`, `user_id`, `description`) VALUES
(1, 'SoundHelix playlist', '2021-11-30', 'http://localhost/music_app/data/images/SoundHelix-Song-13.jpg', 2, 'Songs from SoundHelix.com');

-- --------------------------------------------------------

--
-- Table structure for table `songs`
--

CREATE TABLE `songs` (
  `id` bigint(20) NOT NULL,
  `title` varchar(200) COLLATE cp1250_croatian_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `release_date` datetime DEFAULT current_timestamp(),
  `path` text COLLATE cp1250_croatian_ci NOT NULL,
  `image_path` text COLLATE cp1250_croatian_ci NOT NULL,
  `artist_id` bigint(20) NOT NULL,
  `album_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1250 COLLATE=cp1250_croatian_ci;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` (`id`, `title`, `duration`, `release_date`, `path`, `image_path`, `artist_id`, `album_id`) VALUES
(6, 'SoundHelix Song 1', 372, '2021-11-30 00:00:00', 'http://localhost/music_app/data/songs/SoundHelix-Song-1.mp3', 'http://localhost/music_app/data/images/SoundHelix-Song.jpg', 1, 1),
(7, 'SoundHelix Song 2', 425, '2021-11-30 00:00:00', 'http://localhost/music_app/data/songs/SoundHelix-Song-2.mp3', 'http://localhost/music_app/data/images/SoundHelix-Song.jpg', 1, 1),
(8, 'SoundHelix Song 3', 344, '2021-11-30 00:00:00', 'http://localhost/music_app/data/songs/SoundHelix-Song-3.mp3', 'http://localhost/music_app/data/images/SoundHelix-Song.jpg', 1, 1),
(9, 'SoundHelix Song 4', 302, '2021-11-30 00:00:00', 'http://localhost/music_app/data/songs/SoundHelix-Song-4.mp3', 'http://localhost/music_app/data/images/SoundHelix-Song.jpg', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `songs_in_playlists`
--

CREATE TABLE `songs_in_playlists` (
  `playlist_id` bigint(20) NOT NULL,
  `song_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1250 COLLATE=cp1250_croatian_ci;

--
-- Dumping data for table `songs_in_playlists`
--

INSERT INTO `songs_in_playlists` (`playlist_id`, `song_id`) VALUES
(1, 1),
(1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(11) NOT NULL,
  `first_name` varchar(150) COLLATE cp1250_croatian_ci NOT NULL,
  `last_name` varchar(150) COLLATE cp1250_croatian_ci NOT NULL,
  `email` varchar(150) COLLATE cp1250_croatian_ci NOT NULL,
  `password` varchar(128) COLLATE cp1250_croatian_ci NOT NULL,
  `registration_tstz` timestamp NOT NULL DEFAULT current_timestamp(),
  `account_type` varchar(30) COLLATE cp1250_croatian_ci NOT NULL DEFAULT 'basic',
  `subscription_id` int(11) NOT NULL DEFAULT 2,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=cp1250 COLLATE=cp1250_croatian_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `registration_tstz`, `account_type`, `subscription_id`, `active`) VALUES
(2, 'Lovro', 'Bocak', 'lbocak@tvz.hr', '12345678', '2021-11-28 17:51:09', 'admin', 1, 1),
(6, 'l', 'b', 'lb', '1', '2021-11-30 10:09:59', 'basic', 2, 1),
(7, 'L', 'B', 'lb@email.com', '1', '2021-12-01 09:28:54', 'basic', 2, 1),
(9, 'l', 'b', 'lb@gmail.com', '3', '2021-12-01 09:34:51', 'basic', 2, 1),
(10, 'a', 'b', 'c', 'sdsds', '2021-12-01 14:34:30', 'basic', 2, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `playlists`
--
ALTER TABLE `playlists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `albums`
--
ALTER TABLE `albums`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `songs`
--
ALTER TABLE `songs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
