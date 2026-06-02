-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 02, 2026 at 02:16 PM
-- Server version: 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vsocial`
--

-- --------------------------------------------------------

--
-- Table structure for table `blocks`
--

CREATE TABLE `blocks` (
  `block_id` int(11) NOT NULL,
  `block_by` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `block_time` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `blocks`
--

INSERT INTO `blocks` (`block_id`, `block_by`, `user`, `block_time`) VALUES
(6, 30, 24, '1763071036453'),
(11, 7, 11, '1763531200638'),
(13, 24, 20, '1769473878187'),
(15, 28, 10, '1772780763828');

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `bkmrk_id` int(11) NOT NULL,
  `bkmrk_by` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `bkmrk_time` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bookmarks`
--

INSERT INTO `bookmarks` (`bkmrk_id`, `bkmrk_by`, `post_id`, `bkmrk_time`) VALUES
(2, 24, 43, '1769055990529'),
(3, 24, 57, '1770768666944');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `type` enum('text','image','sticker') COLLATE utf8mb4_bin NOT NULL,
  `text` mediumtext COLLATE utf8mb4_bin NOT NULL,
  `commentSrc` mediumtext COLLATE utf8mb4_bin NOT NULL,
  `comment_by` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `comment_time` varchar(100) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `type`, `text`, `commentSrc`, `comment_by`, `post_id`, `comment_time`) VALUES
(62, 'text', 'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm', '', 30, 57, '1763067832366'),
(63, 'text', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '', 30, 57, '1763067877360'),
(64, 'text', '#Hello', '', 24, 57, '1763269034882'),
(66, 'text', 'wooo @takkar', '', 7, 88, '1763503576209'),
(69, 'image', '', 'instagram_comment_1763530902697.jpg', 24, 89, '1763530902697'),
(70, 'text', 'thnx @ghalib', '', 24, 88, '1763530984177'),
(71, 'text', 'hmmm', '', 7, 88, '1763531092475'),
(73, 'text', 'https://regexr.com/?37i6s fffffm', '', 24, 89, '1763671723020'),
(102, 'text', 'mmmm', '', 24, 61, '1769322301887'),
(103, 'sticker', '', 'instagram_comment_1772005944048.jpg', 24, 43, '1772005944048'),
(104, 'sticker', '', 'instagram_comment_1772005980923.jpg', 24, 43, '1772005980923');

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `con_id` int(11) NOT NULL,
  `user_one` int(11) NOT NULL,
  `user_two` int(11) NOT NULL,
  `con_time` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`con_id`, `user_one`, `user_two`, `con_time`) VALUES
(24, 24, 7, '1762575034251'),
(25, 24, 27, '1763531047978'),
(29, 24, 28, '1768441879031'),
(36, 28, 11, '1769650769619'),
(39, 24, 18, '1769752288459');

-- --------------------------------------------------------

--
-- Table structure for table `favourites`
--

CREATE TABLE `favourites` (
  `fav_id` int(11) NOT NULL,
  `fav_by` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `fav_time` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `favourites`
--

INSERT INTO `favourites` (`fav_id`, `fav_by`, `user`, `fav_time`) VALUES
(1, 30, 24, '1763014889340'),
(2, 27, 18, '1767993018237'),
(3, 24, 14, '1769061090238'),
(4, 24, 17, '1769472263393');

-- --------------------------------------------------------

--
-- Table structure for table `follow_system`
--

CREATE TABLE `follow_system` (
  `follow_id` int(11) NOT NULL,
  `follow_by` int(11) NOT NULL,
  `follow_by_username` varchar(32) NOT NULL,
  `follow_to` int(11) NOT NULL,
  `follow_to_username` varchar(32) NOT NULL,
  `follow_time` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `friend_requests`
--

CREATE TABLE `friend_requests` (
  `request_id` int(11) NOT NULL,
  `from_user` int(11) NOT NULL,
  `to_user` int(11) NOT NULL,
  `status` enum('pending','accepted','rejected') COLLATE utf8mb4_bin NOT NULL DEFAULT 'pending',
  `request_time` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `response_time` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `follow_system`
--

INSERT INTO `follow_system` (`follow_id`, `follow_by`, `follow_by_username`, `follow_to`, `follow_to_username`, `follow_time`) VALUES
(116, 7, 'ghalib', 8, 'coldplay', '1760477756511'),
(118, 8, 'coldplay', 7, 'ghalib', '1760477817648'),
(183, 7, 'ghalib', 10, 'noddy', '1761191674772'),
(205, 29, 'steve_jobs', 24, 'takkar', '1762576603271'),
(211, 7, 'ghalib', 24, 'takkar', '1763531113707'),
(215, 30, 'doraemon', 24, 'takkar', '1765263868294'),
(228, 11, 'nobita', 18, 'ragnar', '1769057193133'),
(229, 11, 'nobita', 28, 'selena', '1769057195829'),
(230, 11, 'nobita', 10, 'noddy', '1769057199870'),
(231, 11, 'nobita', 8, 'coldplay', '1769057201279'),
(232, 11, 'nobita', 29, 'steve_jobs', '1769057206914'),
(234, 11, 'nobita', 19, 'jonsnow', '1769057240892'),
(235, 11, 'nobita', 12, 'pikachu', '1769057323878'),
(236, 11, 'nobita', 20, 'gian', '1769057325821'),
(237, 11, 'nobita', 13, 'iamsrk', '1769057327162'),
(238, 11, 'nobita', 15, 'suniyo', '1769057328332'),
(239, 11, 'nobita', 30, 'doraemon', '1769057329708'),
(243, 28, 'selena', 11, 'nobita', '1769565056806'),
(246, 24, 'takkar', 7, 'ghalib', '1770768463412'),
(248, 24, 'takkar', 29, 'steve_jobs', '1770768536790'),
(252, 24, 'takkar', 18, 'ragnar', '1770770001910'),
(255, 24, 'takkar', 19, 'jonsnow', '1770770132966'),
(258, 24, 'takkar', 8, 'coldplay', '1770770323941'),
(261, 24, 'takkar', 11, 'nobita', '1770770527294'),
(273, 27, 'taylor_swift', 24, 'takkar', '1770933141674'),
(275, 27, 'taylor_swift', 28, 'selena', '1770933926858'),
(277, 27, 'taylor_swift', 18, 'ragnar', '1770942396238'),
(278, 27, 'taylor_swift', 16, 'zayn', '1770942941491'),
(279, 27, 'taylor_swift', 10, 'noddy', '1770942963887'),
(289, 24, 'takkar', 10, 'noddy', '1770969140566'),
(301, 16, 'zayn', 24, 'takkar', '1771221471628'),
(302, 24, 'takkar', 16, 'zayn', '1772830564719'),
(303, 28, 'selena', 24, 'takkar', '1773092540901');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `bio` varchar(2000) NOT NULL,
  `admin` int(11) NOT NULL,
  `group_type` enum('public','private') NOT NULL DEFAULT 'public',
  `created` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`group_id`, `name`, `bio`, `admin`, `group_type`, `created`) VALUES
(11, 'a groupss', '#random group', 24, 'private', '1762574789025'),
(12, 'nmnmnmnm', '', 7, 'public', '1763531129032');

-- --------------------------------------------------------

--
-- Table structure for table `group_members`
--

CREATE TABLE `group_members` (
  `grp_member_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `member` int(11) NOT NULL,
  `added_by` int(11) NOT NULL,
  `joined_group` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group_members`
--

INSERT INTO `group_members` (`grp_member_id`, `group_id`, `member`, `added_by`, `joined_group`) VALUES
(31, 11, 24, 24, '1762574789135'),
(34, 11, 18, 24, '1762574821345'),
(36, 12, 7, 7, '1763531129128'),
(38, 12, 8, 7, '1763531161333'),
(49, 12, 28, 28, '1765404177769'),
(57, 11, 28, 24, '1770770382578'),
(58, 11, 7, 24, '1770770386427');

-- --------------------------------------------------------

--
-- Table structure for table `hashtags`
--

CREATE TABLE `hashtags` (
  `hashtag_id` int(11) NOT NULL,
  `hashtag` varchar(1000) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `hashtag_time` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hashtags`
--

INSERT INTO `hashtags` (`hashtag_id`, `hashtag`, `post_id`, `user`, `hashtag_time`) VALUES
(13, '#nice', 69, 24, '1763412828084'),
(14, '#travel', 69, 24, '1763412828084'),
(16, '#travel', 71, 24, '1763415965188'),
(43, '#checkout', 88, 24, '1769235128944'),
(53, '#checkout', 89, 24, '1771228647996'),
(54, '#dd', 89, 24, '1771228648278'),
(55, '#fgf', 89, 24, '1771228648458');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `like_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `like_by` int(11) NOT NULL,
  `like_time` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`like_id`, `post_id`, `like_by`, `like_time`) VALUES
(31, 22, 12, '1761081272813'),
(33, 24, 13, '1761081870507'),
(34, 23, 11, '1761082896673'),
(35, 32, 10, '1761083037597'),
(36, 34, 16, '1761083187585'),
(37, 35, 17, '1761083345668'),
(38, 36, 18, '1761083612159'),
(39, 41, 20, '1761085862838'),
(42, 43, 18, '1761086119775'),
(57, 43, 23, '1762574394053'),
(58, 40, 24, '1762574560627'),
(59, 39, 24, '1762574563762'),
(63, 61, 27, '1762576415906'),
(64, 63, 30, '1763068138794'),
(65, 57, 24, '1763073366561'),
(67, 89, 28, '1768803784468'),
(69, 89, 18, '1770420433247'),
(71, 69, 24, '1770768663730'),
(75, 89, 24, '1771221972977');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `con_id` int(11) NOT NULL,
  `mssg_by` int(11) NOT NULL,
  `mssg_to` int(11) NOT NULL,
  `message` longtext COLLATE utf8mb4_bin NOT NULL,
  `type` enum('text','image','sticker') COLLATE utf8mb4_bin NOT NULL,
  `status` enum('read','unread') COLLATE utf8mb4_bin NOT NULL DEFAULT 'unread',
  `message_time` varchar(100) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `con_id`, `mssg_by`, `mssg_to`, `message`, `type`, `status`, `message_time`) VALUES
(77, 25, 24, 27, 'hello', 'text', 'read', '1763531052917'),
(78, 24, 7, 24, 'eo', 'text', 'read', '1763531103354'),
(79, 25, 24, 27, '@takkar', 'text', 'read', '1763586522859'),
(93, 29, 28, 24, 'instagram_message_1769649227982.jpg', 'sticker', 'read', '1769649227982'),
(94, 29, 24, 28, 'kjkjk', 'text', 'unread', '1770367278676'),
(95, 29, 24, 28, 'kjkjk', 'text', 'unread', '1770367535404'),
(96, 39, 24, 18, 'mnm', 'text', 'read', '1770367641624'),
(99, 29, 24, 28, 'instagram_message_1770367938322.jpg', 'sticker', 'unread', '1770367938322'),
(100, 29, 24, 28, 'mnmnmnm', 'text', 'unread', '1770416535079'),
(101, 39, 24, 18, 'kjkj', 'text', 'unread', '1771039058343'),
(102, 29, 24, 28, 'instagram_message_1772836916322.jpg', 'image', 'unread', '1772836916322');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notify_id` int(11) NOT NULL,
  `notify_by` int(11) NOT NULL,
  `notify_to` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `type` enum('follow','tag','like','share','shared_your_post','comment','favourites','recommend','add_grp_member','invite','change_admin','new_con','mention_post','mention_comment','friend_request','friend_accept','post_approved','post_rejected') NOT NULL,
  `user` int(11) NOT NULL,
  `notify_time` varchar(100) NOT NULL,
  `status` enum('read','unread') NOT NULL DEFAULT 'unread'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notify_id`, `notify_by`, `notify_to`, `post_id`, `group_id`, `type`, `user`, `notify_time`, `status`) VALUES
(286, 7, 10, 0, 0, 'follow', 0, '1761191674930', 'read'),
(343, 24, 19, 0, 0, 'follow', 0, '1762574537774', 'unread'),
(344, 24, 8, 0, 0, 'follow', 0, '1762574541350', 'unread'),
(345, 24, 19, 40, 0, 'like', 0, '1762574560695', 'unread'),
(346, 24, 19, 39, 0, 'like', 0, '1762574563968', 'unread'),
(353, 24, 8, 0, 11, 'add_grp_member', 0, '1762574816777', 'unread'),
(368, 24, 29, 0, 0, 'follow', 0, '1762900306395', 'unread'),
(382, 24, 7, 88, 0, 'mention_post', 0, '1763503437918', 'read'),
(392, 24, 7, 89, 0, 'share', 0, '1763530881675', 'read'),
(394, 24, 7, 88, 0, 'mention_comment', 0, '1763530984228', 'read'),
(400, 7, 8, 0, 12, 'add_grp_member', 0, '1763531161424', 'unread'),
(402, 24, 20, 0, 0, 'favourites', 0, '1765240173708', 'unread'),
(403, 24, 12, 0, 0, 'favourites', 0, '1765240193628', 'unread'),
(404, 24, 10, 0, 0, 'favourites', 0, '1765240197791', 'unread'),
(410, 30, 8, 0, 0, 'follow', 0, '1765263876908', 'unread'),
(412, 28, 10, 0, 0, 'follow', 0, '1765317297268', 'unread'),
(418, 24, 10, 0, 0, 'follow', 0, '1767931969762', 'unread'),
(429, 24, 28, 0, 0, 'new_con', 0, '1768035783954', 'read'),
(430, 24, 28, 0, 0, 'new_con', 0, '1768036405789', 'read'),
(431, 24, 28, 0, 0, 'new_con', 0, '1768038089831', 'read'),
(434, 24, 28, 61, 0, 'share', 0, '1769054920163', 'read'),
(436, 24, 28, 89, 0, 'share', 0, '1769054929975', 'read'),
(437, 24, 28, 88, 0, 'share', 0, '1769054934967', 'read'),
(439, 24, 28, 69, 0, 'share', 0, '1769054943980', 'read'),
(440, 24, 28, 43, 0, 'share', 0, '1769054959987', 'read'),
(443, 11, 28, 0, 0, 'follow', 0, '1769057195978', 'read'),
(444, 11, 10, 0, 0, 'follow', 0, '1769057200021', 'unread'),
(445, 11, 8, 0, 0, 'follow', 0, '1769057201411', 'unread'),
(446, 11, 29, 0, 0, 'follow', 0, '1769057207162', 'unread'),
(448, 11, 19, 0, 0, 'follow', 0, '1769057241042', 'unread'),
(449, 11, 12, 0, 0, 'follow', 0, '1769057324031', 'unread'),
(450, 11, 20, 0, 0, 'follow', 0, '1769057325917', 'unread'),
(451, 11, 13, 0, 0, 'follow', 0, '1769057327211', 'unread'),
(452, 11, 15, 0, 0, 'follow', 0, '1769057328401', 'unread'),
(453, 11, 30, 0, 0, 'follow', 0, '1769057329911', 'unread'),
(454, 24, 14, 0, 0, 'follow', 0, '1769060801391', 'unread'),
(455, 24, 14, 0, 0, 'favourites', 0, '1769061090341', 'unread'),
(456, 24, 29, 0, 0, 'new_con', 0, '1769062674022', 'unread'),
(497, 24, 12, 0, 0, 'follow', 0, '1769468036137', 'unread'),
(498, 24, 30, 0, 0, 'favourites', 0, '1769472243323', 'unread'),
(499, 24, 17, 0, 0, 'favourites', 0, '1769472263529', 'unread'),
(500, 24, 28, 0, 0, 'recommend', 20, '1769474403894', 'read'),
(501, 24, 10, 0, 0, 'recommend', 20, '1769474642115', 'unread'),
(502, 24, 28, 0, 11, 'invite', 0, '1769560933101', 'read'),
(503, 24, 28, 0, 0, 'recommend', 14, '1769561683073', 'read'),
(504, 24, 14, 0, 0, 'favourites', 0, '1769561782071', 'unread'),
(505, 28, 11, 0, 0, 'follow', 0, '1769564832734', 'unread'),
(506, 28, 11, 0, 0, 'follow', 0, '1769565056902', 'unread'),
(507, 28, 11, 0, 0, 'new_con', 0, '1769636015160', 'unread'),
(508, 28, 10, 0, 0, 'new_con', 0, '1769636030344', 'unread'),
(509, 28, 11, 0, 0, 'new_con', 0, '1769636084605', 'unread'),
(510, 28, 10, 0, 0, 'new_con', 0, '1769636098870', 'unread'),
(511, 28, 11, 0, 0, 'new_con', 0, '1769637255970', 'unread'),
(512, 28, 11, 0, 0, 'new_con', 0, '1769650769833', 'unread'),
(513, 24, 10, 0, 0, 'new_con', 0, '1769666818258', 'unread'),
(516, 24, 13, 0, 0, 'favourites', 0, '1769759650445', 'unread'),
(517, 24, 13, 0, 0, 'favourites', 0, '1769759687374', 'unread'),
(518, 24, 28, 0, 0, 'follow', 0, '1769832175484', 'read'),
(528, 24, 28, 0, 0, 'follow', 0, '1770768458683', 'read'),
(529, 24, 7, 0, 0, 'follow', 0, '1770768463586', 'unread'),
(530, 24, 29, 0, 0, 'follow', 0, '1770768467470', 'unread'),
(531, 24, 29, 0, 0, 'follow', 0, '1770768536932', 'unread'),
(532, 24, 28, 0, 0, 'follow', 0, '1770768561959', 'read'),
(533, 24, 18, 0, 0, 'follow', 0, '1770768920968', 'unread'),
(534, 24, 28, 0, 0, 'follow', 0, '1770769731819', 'read'),
(535, 24, 18, 0, 0, 'follow', 0, '1770770002617', 'unread'),
(536, 24, 28, 0, 0, 'follow', 0, '1770770010053', 'read'),
(537, 24, 15, 0, 0, 'follow', 0, '1770770129505', 'unread'),
(538, 24, 19, 0, 0, 'follow', 0, '1770770133362', 'unread'),
(540, 24, 11, 0, 0, 'follow', 0, '1770770320067', 'unread'),
(541, 24, 8, 0, 0, 'follow', 0, '1770770324073', 'unread'),
(542, 24, 13, 0, 0, 'follow', 0, '1770770333589', 'unread'),
(543, 24, 28, 0, 11, 'add_grp_member', 0, '1770770382686', 'read'),
(544, 24, 7, 0, 11, 'add_grp_member', 0, '1770770386561', 'unread'),
(545, 24, 14, 0, 0, 'follow', 0, '1770770401310', 'unread'),
(546, 24, 11, 0, 0, 'follow', 0, '1770770527493', 'unread'),
(547, 24, 10, 0, 0, 'follow', 0, '1770770537304', 'unread'),
(548, 24, 17, 0, 0, 'follow', 0, '1770770539556', 'unread'),
(549, 24, 16, 0, 0, 'follow', 0, '1770770540876', 'read'),
(550, 24, 12, 0, 0, 'follow', 0, '1770770671086', 'unread'),
(551, 24, 20, 0, 0, 'follow', 0, '1770770831110', 'unread'),
(552, 24, 20, 0, 0, 'follow', 0, '1770770940680', 'unread'),
(553, 24, 12, 0, 0, 'follow', 0, '1770771051031', 'unread'),
(554, 24, 10, 0, 0, 'new_con', 0, '1770793614796', 'unread'),
(555, 24, 16, 0, 0, 'follow', 0, '1770794956618', 'read'),
(567, 27, 28, 0, 0, 'follow', 0, '1770933921497', 'read'),
(568, 27, 28, 0, 0, 'follow', 0, '1770933926909', 'read'),
(569, 27, 18, 0, 0, 'follow', 0, '1770935465158', 'unread'),
(570, 27, 18, 0, 0, 'follow', 0, '1770942396367', 'unread'),
(571, 27, 16, 0, 0, 'follow', 0, '1770942941789', 'read'),
(572, 27, 10, 0, 0, 'follow', 0, '1770942963991', 'unread'),
(573, 24, 27, 0, 0, 'follow', 0, '1770964630774', 'unread'),
(574, 24, 27, 0, 0, 'follow', 0, '1770964760010', 'unread'),
(575, 24, 27, 0, 0, 'follow', 0, '1770964770298', 'unread'),
(576, 24, 27, 0, 0, 'follow', 0, '1770967401088', 'unread'),
(577, 24, 20, 0, 0, 'follow', 0, '1770967922436', 'unread'),
(578, 24, 17, 0, 0, 'follow', 0, '1770968577391', 'unread'),
(579, 24, 17, 0, 0, 'follow', 0, '1770968580733', 'unread'),
(580, 24, 13, 0, 0, 'follow', 0, '1770969022566', 'unread'),
(581, 24, 20, 0, 0, 'follow', 0, '1770969067033', 'unread'),
(582, 24, 10, 0, 0, 'follow', 0, '1770969140758', 'unread'),
(583, 24, 27, 0, 0, 'follow', 0, '1770969756938', 'unread'),
(584, 24, 28, 0, 0, 'follow', 0, '1770969771561', 'read'),
(585, 24, 27, 0, 0, 'follow', 0, '1770970980645', 'unread'),
(586, 24, 27, 0, 0, 'follow', 0, '1770971796168', 'unread'),
(587, 24, 13, 0, 0, 'follow', 0, '1771018874059', 'unread'),
(588, 24, 16, 0, 0, 'follow', 0, '1771018919927', 'read'),
(589, 24, 12, 0, 0, 'follow', 0, '1771018926213', 'unread'),
(590, 24, 27, 0, 0, 'follow', 0, '1771018992273', 'unread'),
(591, 24, 20, 0, 0, 'follow', 0, '1771019014195', 'unread'),
(592, 24, 17, 0, 0, 'follow', 0, '1771019028129', 'unread'),
(593, 24, 11, 0, 0, 'new_con', 0, '1771038407414', 'unread'),
(594, 24, 10, 0, 0, 'new_con', 0, '1771038938235', 'unread'),
(595, 24, 28, 0, 11, 'invite', 0, '1771048353133', 'read'),
(598, 24, 19, 0, 0, 'recommend', 13, '1771201615961', 'unread'),
(599, 24, 28, 89, 0, 'share', 0, '1771205084563', 'read'),
(600, 24, 10, 89, 0, 'share', 0, '1771218140393', 'unread'),
(620, 24, 28, 89, 0, 'share', 0, '1771303651514', 'read'),
(621, 24, 10, 89, 0, 'share', 0, '1771303687169', 'unread'),
(622, 24, 11, 89, 0, 'share', 0, '1771303688207', 'unread'),
(625, 24, 18, 43, 0, 'comment', 0, '1772005944208', 'unread'),
(626, 24, 18, 43, 0, 'comment', 0, '1772005981147', 'unread'),
(627, 7, 28, 0, 12, 'change_admin', 0, '1772500689398', 'read'),
(628, 28, 7, 0, 12, 'change_admin', 0, '1772500725407', 'unread'),
(629, 24, 16, 0, 0, 'follow', 0, '1772830564913', 'unread'),
(630, 24, 10, 0, 0, 'new_con', 0, '1772832523722', 'unread'),
(632, 28, 24, 0, 0, 'follow', 0, '1773092541169', 'read');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `description` mediumtext COLLATE utf8mb4_bin NOT NULL,
  `imgSrc` mediumtext COLLATE utf8mb4_bin NOT NULL,
  `filter` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT 'normal',
  `location` mediumtext COLLATE utf8mb4_bin NOT NULL,
  `type` enum('user','group') COLLATE utf8mb4_bin NOT NULL DEFAULT 'user',
  `group_id` int(11) NOT NULL,
  `post_time` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `isNSFW` tinyint(1) DEFAULT 0,
  `nsfwTaggedByAuthor` tinyint(1) DEFAULT 0,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_bin NOT NULL DEFAULT 'approved',
  `rejection_reason` varchar(500) COLLATE utf8mb4_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `user`, `description`, `imgSrc`, `filter`, `location`, `type`, `group_id`, `post_time`, `status`, `rejection_reason`) VALUES
(22, 12, '', 'instagram_1761080827777.jpg', 'filter-normal', 'A-301, 90 Feet Road, Dharavi, Mumbai, Maharashtra 400017, India', 'user', 0, '1761080827777', 'approved', ''),
(23, 11, '', 'instagram_1761081519807.jpg', 'filter-normal', '', 'user', 0, '1761081519807', 'approved', ''),
(24, 13, '@ghalib #travel', 'instagram_1761081864443.jpg', 'filter-normal', '', 'user', 0, '1761081864444', 'approved', ''),
(25, 14, '', 'instagram_1761082061525.jpg', 'filter-normal', '', 'user', 0, '1761082061525', 'approved', ''),
(26, 14, '', 'instagram_1761082083102.jpg', 'filter-normal', '', 'user', 0, '1761082083102', 'approved', ''),
(27, 14, '', 'instagram_1761082108349.jpg', 'filter-normal', '', 'user', 0, '1761082108349', 'approved', ''),
(28, 14, '', 'instagram_1761082150205.jpg', 'filter-normal', '', 'user', 0, '1761082150205', 'approved', ''),
(29, 14, '', 'instagram_1761082185132.jpg', 'filter-normal', '', 'user', 0, '1761082185132', 'approved', ''),
(30, 14, '', 'instagram_1761082242014.jpg', 'filter-normal', '', 'user', 0, '1761082242014', 'approved', ''),
(31, 15, '', 'instagram_1761082805361.jpg', 'filter-normal', '', 'user', 0, '1761082805361', 'approved', ''),
(32, 10, '', 'instagram_1761083032591.jpg', 'filter-normal', '', 'user', 0, '1761083032591', 'approved', ''),
(33, 10, '', 'instagram_1761083091515.jpg', 'filter-normal', '', 'user', 0, '1761083091515', 'approved', ''),
(34, 16, '', 'instagram_1761083181327.jpg', 'filter-normal', '', 'user', 0, '1761083181327', 'approved', ''),
(35, 17, '', 'instagram_1761083340484.jpg', 'filter-normal', '', 'user', 0, '1761083340484', 'approved', ''),
(36, 18, '', 'instagram_1761083607252.jpg', 'filter-normal', '', 'user', 0, '1761083607252', 'approved', ''),
(37, 18, '', 'instagram_1761083699850.jpg', 'filter-normal', '', 'user', 0, '1761083699850', 'approved', ''),
(38, 18, '', 'instagram_1761083754737.jpg', 'filter-normal', '', 'user', 0, '1761083754737', 'approved', ''),
(39, 19, '', 'instagram_1761085442965.jpg', 'filter-normal', '', 'user', 0, '1761085442965', 'approved', ''),
(40, 19, '', 'instagram_1761085454480.jpg', 'filter-normal', '', 'user', 0, '1761085454480', 'approved', ''),
(41, 20, '', 'instagram_1761085855810.jpg', 'filter-normal', '', 'user', 0, '1761085855810', 'approved', ''),
(43, 18, '', 'instagram_1761086113532.jpg', 'filter-normal', '', 'user', 0, '1761086113532', 'approved', ''),
(57, 24, 'm', 'instagram_1762574756272.jpg', 'filter-normal', '', 'user', 0, '1762574756272', 'approved', ''),
(61, 27, '', 'instagram_1762576410196.jpg', 'filter-normal', 'Progresive Building, 90 Feet Road, Dharavi, Mumbai, Maharashtra 400017, India', 'user', 0, '1762576410196', 'approved', ''),
(63, 30, 'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm', 'instagram_1763068129073.jpg', 'filter-normal', '', 'user', 0, '1763068129073', 'approved', ''),
(69, 24, 'That''s a #nice place to #travel', 'instagram_1763412827262.jpg', 'filter-normal', '', 'user', 0, '1763412827262', 'approved', ''),
(71, 24, '#travel', 'instagram_1763415963684.jpg', 'filter-normal', '', 'group', 11, '1763415963684', 'approved', ''),
(88, 24, 'Hello @ghalib @takkar #checkout', 'instagram_1763503437605.jpg', 'filter-normal', '', 'user', 0, '1763503437605', 'approved', ''),
(89, 24, 'he @nobita, @doraemon #checkout, #dd #fgf', 'instagram_1763530866148.jpg', 'filter-ashby', 'A-301, 90 Feet Road, Dharavi, Mumbai, Maharashtra 400017, India', 'user', 0, '1763530866148', 'approved', '');

-- --------------------------------------------------------

--
-- Table structure for table `post_tags`
--

CREATE TABLE `post_tags` (
  `post_tag_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `profile_views`
--

CREATE TABLE `profile_views` (
  `view_id` int(11) NOT NULL,
  `view_by` int(11) NOT NULL,
  `view_to` int(11) NOT NULL,
  `view_time` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `profile_views`
--

INSERT INTO `profile_views` (`view_id`, `view_by`, `view_to`, `view_time`) VALUES
(64, 7, 8, '1760477736647'),
(129, 8, 7, '1760847160802'),
(134, 11, 12, '1761082382745'),
(214, 17, 12, '1761803269037'),
(215, 30, 24, '1763012752284'),
(216, 30, 24, '1763013235614'),
(217, 30, 24, '1763013427948'),
(218, 30, 24, '1763013733801'),
(219, 30, 24, '1763013957449'),
(220, 30, 24, '1763014333038'),
(221, 30, 24, '1763014510295'),
(222, 30, 24, '1763014718809'),
(223, 30, 24, '1763014873434'),
(224, 30, 24, '1763067814963'),
(225, 30, 24, '1763071025727'),
(226, 24, 30, '1763071082992'),
(227, 24, 30, '1763071563945'),
(228, 24, 30, '1763071928511'),
(229, 24, 27, '1763071946370'),
(230, 24, 30, '1763072229315'),
(231, 24, 27, '1763072435480'),
(232, 24, 27, '1763072588668'),
(233, 24, 28, '1763072681982'),
(234, 24, 30, '1763072695885'),
(236, 24, 13, '1763266271454'),
(237, 24, 7, '1763499968625'),
(238, 7, 24, '1763531110266'),
(239, 7, 11, '1763531195839'),
(240, 11, 7, '1763531224416'),
(241, 30, 24, '1763618771654'),
(242, 30, 24, '1763619061712'),
(243, 24, 10, '1764541035986'),
(244, 24, 28, '1764667206055'),
(245, 24, 28, '1764821559264'),
(246, 24, 20, '1765240166227'),
(247, 24, 12, '1765240190692'),
(248, 24, 10, '1765240195018'),
(249, 24, 10, '1765240383084'),
(250, 24, 15, '1765240398186'),
(251, 24, 10, '1765240982302'),
(252, 24, 10, '1765241154648'),
(253, 24, 10, '1765241605043'),
(254, 24, 10, '1765241757115'),
(255, 24, 10, '1765242035474'),
(256, 28, 24, '1765242216680'),
(257, 28, 24, '1765242395973'),
(258, 24, 13, '1765258665557'),
(259, 30, 24, '1765262986270'),
(260, 30, 24, '1765263473640'),
(261, 30, 24, '1765263858401'),
(262, 30, 8, '1765263874586'),
(263, 24, 30, '1765263948097'),
(264, 24, 30, '1765264123700'),
(265, 24, 15, '1765264142917'),
(266, 24, 15, '1765265422525'),
(268, 24, 27, '1765315320877'),
(269, 28, 24, '1765315446815'),
(270, 28, 24, '1765316094236'),
(271, 28, 24, '1765316572491'),
(272, 28, 7, '1765317097392'),
(273, 28, 24, '1765317113425'),
(274, 28, 24, '1765317292110'),
(275, 28, 24, '1765317445751'),
(276, 28, 11, '1765318234298'),
(277, 28, 24, '1765318283047'),
(278, 28, 24, '1765318465218'),
(279, 28, 24, '1765318701100'),
(280, 28, 24, '1765321467890'),
(281, 28, 24, '1765321632337'),
(282, 24, 28, '1765321683996'),
(283, 24, 10, '1765321873854'),
(284, 24, 7, '1765321881357'),
(285, 24, 7, '1765322854724'),
(286, 24, 27, '1765326734822'),
(287, 24, 30, '1765326796126'),
(288, 28, 24, '1765326818499'),
(289, 28, 24, '1765404139509'),
(290, 24, 27, '1766215648709'),
(291, 24, 10, '1767761350581'),
(292, 24, 27, '1767761745759'),
(293, 24, 7, '1767843877587'),
(294, 7, 24, '1767843952049'),
(295, 7, 24, '1767844874603'),
(296, 7, 19, '1767844883961'),
(297, 7, 24, '1767845496288'),
(298, 7, 24, '1767845685795'),
(299, 24, 27, '1767921064714'),
(300, 28, 18, '1767991131373'),
(301, 28, 7, '1767991143569'),
(302, 24, 27, '1767991990753'),
(303, 27, 18, '1767993007370'),
(304, 27, 19, '1767993577910'),
(305, 27, 19, '1767993952153'),
(306, 27, 19, '1767994120158'),
(307, 27, 19, '1767994404534'),
(308, 27, 19, '1767994635428'),
(309, 27, 24, '1768028278765'),
(310, 28, 24, '1768036281035'),
(311, 24, 28, '1768036311514'),
(312, 24, 28, '1768038387054'),
(313, 24, 28, '1768038570229'),
(314, 24, 28, '1768038724837'),
(315, 24, 17, '1768038794529'),
(316, 24, 28, '1768038891602'),
(317, 24, 27, '1768039104321'),
(318, 24, 28, '1768039112454'),
(319, 24, 28, '1768078214784'),
(320, 24, 11, '1768078247232'),
(321, 24, 11, '1768080109611'),
(322, 24, 11, '1768080428811'),
(323, 24, 13, '1768081957505'),
(324, 24, 7, '1768081970528'),
(325, 24, 28, '1768367268445'),
(326, 24, 28, '1768367476850'),
(327, 24, 28, '1768367891341'),
(328, 24, 28, '1768441875619'),
(329, 24, 28, '1768442049435'),
(330, 24, 28, '1768442201230'),
(331, 24, 28, '1768861906422'),
(332, 24, 28, '1768863021322'),
(333, 24, 14, '1769049695351'),
(335, 24, 27, '1769054390118'),
(336, 24, 27, '1769054597764'),
(337, 24, 27, '1769054763640'),
(338, 28, 24, '1769055318360'),
(339, 28, 24, '1769055944170'),
(340, 11, 24, '1769057610014'),
(341, 24, 7, '1769058439855'),
(342, 24, 15, '1769060367186'),
(343, 24, 30, '1769060423729'),
(344, 24, 14, '1769060558377'),
(345, 24, 14, '1769060756989'),
(346, 24, 14, '1769060979433'),
(347, 7, 24, '1769126295778'),
(348, 24, 11, '1769457973071'),
(349, 24, 11, '1769458540955'),
(350, 24, 11, '1769459188937'),
(351, 24, 12, '1769468028111'),
(352, 24, 12, '1769468179858'),
(353, 24, 17, '1769471967148'),
(354, 24, 12, '1769472113296'),
(355, 24, 30, '1769472146024'),
(356, 24, 17, '1769472259463'),
(357, 24, 27, '1769472451006'),
(358, 24, 27, '1769472616402'),
(359, 24, 20, '1769472674918'),
(360, 24, 20, '1769472893911'),
(361, 24, 20, '1769473227930'),
(362, 24, 20, '1769473442037'),
(363, 24, 20, '1769473838050'),
(364, 24, 20, '1769474340160'),
(365, 24, 20, '1769474636730'),
(366, 24, 20, '1769474833259'),
(367, 24, 27, '1769547832212'),
(368, 24, 27, '1769548179998'),
(369, 24, 27, '1769548361143'),
(370, 24, 27, '1769549042992'),
(371, 24, 27, '1769549194563'),
(372, 24, 15, '1769549439617'),
(373, 24, 14, '1769561487774'),
(374, 24, 14, '1769561671222'),
(375, 28, 14, '1769565009497'),
(376, 24, 11, '1769656476391'),
(377, 24, 20, '1769756446256'),
(378, 24, 20, '1769756719079'),
(379, 24, 20, '1769757922220'),
(380, 24, 20, '1769758510976'),
(381, 24, 20, '1769758702686'),
(382, 24, 20, '1769758965002'),
(383, 24, 13, '1769759612041'),
(384, 24, 13, '1769760288806'),
(385, 24, 13, '1769760833339'),
(386, 24, 18, '1769832156826'),
(387, 24, 28, '1769832168322'),
(388, 24, 11, '1769837499216'),
(389, 24, 12, '1769841847515'),
(390, 24, 11, '1769841864728'),
(391, 24, 30, '1769842004543'),
(392, 24, 11, '1769842099380'),
(393, 24, 11, '1769894946120'),
(394, 24, 11, '1769895203209'),
(395, 24, 28, '1770418896640'),
(396, 18, 11, '1770418984931'),
(397, 18, 24, '1770419001872'),
(398, 18, 24, '1770419232129'),
(399, 18, 24, '1770420424715'),
(400, 18, 24, '1770420882823'),
(401, 18, 28, '1770421062411'),
(402, 18, 28, '1770421951001'),
(403, 18, 24, '1770422523083'),
(404, 18, 24, '1770424501900'),
(405, 28, 24, '1770508022243'),
(406, 24, 12, '1770672879501'),
(407, 24, 12, '1770673044503'),
(408, 24, 12, '1770673237881'),
(409, 24, 30, '1770768908643'),
(410, 24, 18, '1770768917142'),
(411, 24, 20, '1770780314516'),
(412, 24, 30, '1770781919215'),
(413, 24, 7, '1770782025932'),
(414, 24, 28, '1770782032870'),
(415, 24, 20, '1770789772086'),
(416, 24, 13, '1770790123725'),
(417, 24, 27, '1770793286507'),
(418, 24, 27, '1770793596194'),
(419, 24, 20, '1770793732097'),
(420, 24, 20, '1770794075574'),
(421, 24, 16, '1770794954146'),
(422, 28, 24, '1770844833119'),
(423, 28, 24, '1770844988714'),
(424, 24, 30, '1770861865568'),
(425, 24, 11, '1770862336035'),
(426, 24, 11, '1770862964415'),
(427, 24, 11, '1770863282543'),
(428, 27, 24, '1770933138705'),
(429, 27, 24, '1770933914847'),
(430, 27, 24, '1770935341889'),
(431, 27, 30, '1770942934657'),
(432, 27, 16, '1770942938694'),
(433, 27, 24, '1770942959807'),
(434, 27, 11, '1770942982359'),
(435, 27, 24, '1770943409169'),
(436, 24, 10, '1770969143843'),
(437, 24, 13, '1771018911472'),
(438, 24, 27, '1771018936615'),
(439, 24, 20, '1771019016138'),
(440, 24, 17, '1771019024011'),
(441, 24, 15, '1771019523309'),
(442, 24, 15, '1771019771564'),
(443, 24, 15, '1771019972253'),
(444, 24, 15, '1771020124920'),
(445, 24, 12, '1771053935313'),
(446, 24, 12, '1771055647520'),
(447, 24, 18, '1771134973330'),
(448, 24, 18, '1771135133260'),
(449, 24, 13, '1771201563260'),
(450, 24, 20, '1771201629045'),
(451, 24, 18, '1771204284006'),
(453, 16, 24, '1771221475246'),
(454, 24, 24, '1771541304708'),
(455, 24, 24, '1771541503671'),
(456, 24, 14, '1771715431552'),
(457, 24, 28, '1771752701733'),
(458, 24, 7, '1771797790920'),
(459, 24, 7, '1771897844159'),
(460, 24, 7, '1771907570082'),
(461, 24, 18, '1772179509463'),
(462, 24, 18, '1772238064370'),
(463, 24, 18, '1772240320494'),
(464, 28, 24, '1772780679123'),
(465, 28, 10, '1772780760002'),
(466, 24, 16, '1772830562502'),
(467, 28, 11, '1773092533087'),
(468, 28, 24, '1773092538633'),
(469, 24, 18, '1773092565068');

-- --------------------------------------------------------

--
-- Table structure for table `recommendations`
--

CREATE TABLE `recommendations` (
  `recommend_id` int(11) NOT NULL,
  `recommend_by` int(11) NOT NULL,
  `recommend_to` int(11) NOT NULL,
  `recommend_of` int(11) NOT NULL,
  `recommend_time` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recommendations`
--

INSERT INTO `recommendations` (`recommend_id`, `recommend_by`, `recommend_to`, `recommend_of`, `recommend_time`) VALUES
(1, 24, 18, 30, '1763071570157'),
(2, 24, 27, 30, '1763071587887'),
(3, 24, 28, 20, '1769474403692'),
(4, 24, 10, 20, '1769474641978'),
(5, 24, 28, 14, '1769561682984'),
(6, 24, 18, 28, '1770418917036'),
(7, 24, 19, 13, '1771201615847');

-- --------------------------------------------------------

--
-- Table structure for table `shares`
--

CREATE TABLE `shares` (
  `share_id` int(11) NOT NULL,
  `share_by` int(11) NOT NULL,
  `share_to` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `share_time` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shares`
--

INSERT INTO `shares` (`share_id`, `share_by`, `share_to`, `post_id`, `share_time`) VALUES
(94, 27, 24, 61, '1762576420094'),
(98, 24, 28, 61, '1769054920014'),
(100, 24, 28, 88, '1769054934860'),
(103, 24, 28, 43, '1769054959839'),
(105, 24, 27, 61, '1769297819133'),
(112, 24, 28, 89, '1771303651361'),
(113, 24, 10, 89, '1771303687022'),
(114, 24, 11, 89, '1771303688019');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `tag_id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `tag` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`tag_id`, `user`, `tag`) VALUES
(1, 29, 'apple'),
(33, 24, 'bb');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `firstname` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `surname` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `nickname` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `email` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `bio` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `joined` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `email_verified` enum('yes','no') COLLATE utf8mb4_bin NOT NULL DEFAULT 'no',
  `account_type` enum('public','private') COLLATE utf8mb4_bin NOT NULL DEFAULT 'public',
  `instagram` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `twitter` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `facebook` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `github` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `website` varchar(500) COLLATE utf8mb4_bin NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `isOnline` enum('yes','no') COLLATE utf8mb4_bin NOT NULL DEFAULT 'no',
  `lastOnline` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `cover_image` varchar(500) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `account_status` enum('active','locked','deleted') COLLATE utf8mb4_bin NOT NULL DEFAULT 'active',
  `role` enum('user','admin') COLLATE utf8mb4_bin NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `firstname`, `surname`, `nickname`, `email`, `password`, `bio`, `joined`, `email_verified`, `account_type`, `instagram`, `twitter`, `facebook`, `github`, `website`, `phone`, `isOnline`, `lastOnline`, `cover_image`, `account_status`, `role`) VALUES
(7, 'ghalib', 'Mirza', 'Ghalib', '', 'ghalib@gmail.com', '$2a$10$E3ZgkSwaa6rUopG1CBUm8OoCMKVqzSwv79bfuUrICV0eLOqTlqR/m', '', '1759276800000', 'yes', 'private', '', '', '', '', '', '', 'no', '1772500696734', '', 'active', 'user'),
(8, 'coldplay', 'cold', 'play', '', 'coldplay@gmail.com', '$2a$10$zVPMDJKlOY00UnSlrLEUfuaeTwXkZ.VD4ixp.q1x2RjX/LbezoqPO', '', '1760476487291', 'no', 'public', '', '', '', '', '', '', 'no', '', '', 'active', 'user'),
(10, 'noddy', 'your', 'noddy', '', 'noddy@gmail.com', '$2a$10$/FlxKj904j7TnMo.9gJJTe5cwFakoJc4/w9kba3LeAdP0hTWGCzCG', '', '1761012464182', 'no', 'public', '', '', '', '', '', '', 'no', '', '', 'active', 'user'),
(11, 'nobita', 'nobita', 'nobi', '', 'nobita@gmail.com', '$2a$10$nzMI2G054StCufuo4fzkEOWhpwUWKqZwV67jbPqaqqSNDNnF5led2', '', '1761080517627', 'no', 'public', '', '', '', '', '', '', 'no', '1769057613335', '', 'active', 'user'),
(12, 'pikachu', 'your', 'pikachu', '', 'pikachu@gmail.com', '$2a$10$j/buNE/iwJquKzzyBsOhLe4dEVVXKs56KTet8E4arAjcjsQ87BZt2', '', '1761080650179', 'no', 'public', '', '', '', '', '', '', 'no', '', '', 'active', 'user'),
(13, 'iamsrk', 'Shahrukh', 'Khan', '', 'iamsrk@gmail.com', '$2a$10$Xn99377.3Ns8.QoneTP4qeMuERyvNR2Ki86eRjpmHCsj01xvFoFIq', '', '1761081644545', 'no', 'public', '', '', '', '', '', '', 'no', '', '', 'active', 'user'),
(14, 'kinkade', 'Thomas', 'Kinkade', '', 'kinkade@gmail.com', '$2a$10$IvK3CBxFh/dnkWZtRMh9k.S2/WIdQbd6adF78Bb16.G.62nrSUgcG', '', '1761081903926', 'no', 'public', '', '', '', '', '', '', 'no', '', '', 'active', 'user'),
(15, 'suniyo', 'suniyo', 'honekawa', '', 'suniyo@gmail.com', '$2a$10$60TUnK2JiH8RoloKA/IdB.ZG07o.bc8FpHqu9Euc2kEXc28PslceS', '', '1761082719078', 'no', 'public', '', '', '', '', '', '', 'no', '', '', 'active', 'user'),
(16, 'zayn', 'Zayn', 'Malik', '', 'zayn@gmail.com', '$2a$10$ktjq/vo/8nBxlOnixyTpQuN6gyXc5vN4.rslSVRt4eM6vhq7ftaxS', '', '1761083124011', 'no', 'private', '', '', '', '', '', '', 'yes', '1771221529522', '', 'active', 'user'),
(17, 'nfak', 'Nusratfateh', 'Alikhan', '', 'nfak@gmail.com', '$2a$10$TAzl3pUYIs/HRb8LPhvZdOclk/TSfnmicUVgHEGyUwnUxm7j7Z.Ie', '', '1761083252602', 'no', 'public', '', '', '', '', '', '', 'no', '', '', 'active', 'user'),
(18, 'ragnar', 'Ragnar', 'Lothbrok', '', 'ragnar@gmail.com', '$2a$10$M7lx4wF.PUhAjSJVxb7bW.nk2G6zxeCjhXBnKTyFz3JNq8NQbQQ8m', '', '1761083395083', 'no', 'public', '', '', '', '', '', '', 'no', '1770424732484', '', 'active', 'user'),
(19, 'jonsnow', 'jon_', 'snow', '', 'jonsnow@gmail.com', '$2a$10$9Nb4hFjgg.MKKLLTeXMuWehralT21UCoeWsPq3./VWMkUnu19JpzS', '', '1761085378296', 'no', 'public', '', '', '', '', '', '', 'no', '', '', 'active', 'user'),
(20, 'gian', 'Takeshi', 'Gauda', '', 'gian@gmail.com', '$2a$10$K3ijpio/4HIOKJhQ5yq3DOQ4IW5Oee4O5hwogEQtB/FBuNJRvd9T2', '', '1761085586423', 'no', 'public', '', '', '', '', '', '', 'no', '', '', 'active', 'user'),
(24, 'takkar', 'iam_', 'takkar', '', 'takkar@gmail.com', '$2a$10$R/iWFCwEDgmOvg7mCB3wreerTC0hRuYyZflDN2Gyr3YV/ppMMNgJu', 'Hello #world', '1762574488631', 'no', 'private', '', '', 'm', '', '', 'gg', 'yes', '1773048581709', '', 'active', 'user'),
(27, 'taylor_swift', 'taylor', 'swift', '', 'taylor_swift@gmail.com', '$2a$10$rnQRsp0iWCdV8b6AD24mJ.7rL5XQ31ejULlOQMVkBpjxD7RlRxqKK', '', '1762576334866', 'no', 'public', '', '', '', '', '', '', 'no', '1770945321938', '', 'active', 'user'),
(28, 'selena', 'selena', 'gomez', '', 'selenagomez@gmail.com', '$2a$10$.ifdYlKQdt/acrXtn09NLuENJylSfZIJq2U4tqzZNqeRWaUG0nnQq', '', '1762576460603', 'no', 'public', 'mmmm', '', '', '', '', '', 'no', '1773092554827', '', 'active', 'user'),
(29, 'steve_jobs', 'steve', 'jobs', '', 'steve_jobs@gmail.com', '$2a$10$B05HNF3/pnK.8fU7kCJHpuaU5LpVxwao9Wmkn3Md2sAPc5GINiU6O', '', '1762576550110', 'no', 'public', '', '', '', '', '', '', 'no', '', '', 'active', 'user'),
(30, 'doraemon', 'iam_', 'doraemon', '', 'doraemon@gmail.com', '$2a$10$OjZg/mosNPOT297skkotUetzYL7mIEFDVxVPP2lsBAv4F0LSyK18m', '', '1763012711939', 'no', 'public', '', '', '', '', '', '', 'no', '1770359765018', '', 'active', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blocks`
--
ALTER TABLE `blocks`
  ADD PRIMARY KEY (`block_id`);

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`bkmrk_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`con_id`);

--
-- Indexes for table `favourites`
--
ALTER TABLE `favourites`
  ADD PRIMARY KEY (`fav_id`);

--
-- Indexes for table `follow_system`
--
ALTER TABLE `follow_system`
  ADD PRIMARY KEY (`follow_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`group_id`);

--
-- Indexes for table `group_members`
--
ALTER TABLE `group_members`
  ADD PRIMARY KEY (`grp_member_id`);

--
-- Indexes for table `hashtags`
--
ALTER TABLE `hashtags`
  ADD PRIMARY KEY (`hashtag_id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`like_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_account_status` (`account_status`),
  ADD KEY `idx_user_role` (`role`);

--
-- Indexes for table `friend_requests`
--
ALTER TABLE `friend_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `idx_from_user` (`from_user`),
  ADD KEY `idx_to_user` (`to_user`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `idx_post_status` (`status`);

--
-- Indexes for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD PRIMARY KEY (`post_tag_id`);

--
-- Indexes for table `profile_views`
--
ALTER TABLE `profile_views`
  ADD PRIMARY KEY (`view_id`);

--
-- Indexes for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD PRIMARY KEY (`recommend_id`);

--
-- Indexes for table `shares`
--
ALTER TABLE `shares`
  ADD PRIMARY KEY (`share_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`tag_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blocks`
--
ALTER TABLE `blocks`
  MODIFY `block_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `bkmrk_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;
--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `con_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `favourites`
--
ALTER TABLE `favourites`
  MODIFY `fav_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `follow_system`
--
ALTER TABLE `follow_system`
  MODIFY `follow_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=304;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `group_members`
--
ALTER TABLE `group_members`
  MODIFY `grp_member_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `hashtags`
--
ALTER TABLE `hashtags`
  MODIFY `hashtag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;
--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `like_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notify_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=633;
--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;
--
-- AUTO_INCREMENT for table `post_tags`
--
ALTER TABLE `post_tags`
  MODIFY `post_tag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `profile_views`
--
ALTER TABLE `profile_views`
  MODIFY `view_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=470;
--
-- AUTO_INCREMENT for table `recommendations`
--
ALTER TABLE `recommendations`
  MODIFY `recommend_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `shares`
--
ALTER TABLE `shares`
  MODIFY `share_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;
--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `friend_requests`
--
ALTER TABLE `friend_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

