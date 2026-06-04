-- Migration: Add post_media table for multi-file post support
-- Run this against your 'vsocial' database

CREATE TABLE IF NOT EXISTS `post_media` (
  `media_id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `filename` mediumtext COLLATE utf8mb4_bin NOT NULL,
  `filter` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT 'filter-normal',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`media_id`),
  KEY `post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Backfill existing posts that have an imgSrc into post_media
INSERT INTO `post_media` (`post_id`, `filename`, `filter`, `sort_order`)
SELECT `post_id`, `imgSrc`, IFNULL(`filter`, 'filter-normal'), 0
FROM `posts`
WHERE `imgSrc` IS NOT NULL AND `imgSrc` != ''
AND NOT EXISTS (
  SELECT 1 FROM `post_media` pm WHERE pm.`post_id` = `posts`.`post_id`
);
