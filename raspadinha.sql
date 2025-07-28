-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 22/07/2025 às 02:31
-- Versão do servidor: 8.0.24
-- Versão do PHP: 8.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `raspadinha`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `affiliate_histories`
--

CREATE TABLE `affiliate_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `inviter` int UNSIGNED NOT NULL,
  `commission` decimal(20,2) NOT NULL DEFAULT '0.00',
  `commission_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposited` tinyint DEFAULT '0',
  `deposited_amount` decimal(10,2) DEFAULT '0.00',
  `losses` bigint DEFAULT '0',
  `losses_amount` decimal(10,2) DEFAULT '0.00',
  `commission_paid` decimal(10,2) DEFAULT '0.00',
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `affiliate_withdraws`
--

CREATE TABLE `affiliate_withdraws` (
  `id` bigint UNSIGNED NOT NULL,
  `payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `proof` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `pix_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pix_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_info` text COLLATE utf8mb4_unicode_ci,
  `currency` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `banners`
--

CREATE TABLE `banners` (
  `id` bigint UNSIGNED NOT NULL,
  `link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'home',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `banners`
--

INSERT INTO `banners` (`id`, `link`, `image`, `type`, `description`, `created_at`, `updated_at`) VALUES
(20, '/profile/affiliate', '01JZTCA7TM0PKTETRGN1RWJT8S.png', 'carousel', NULL, '2024-05-03 11:22:56', '2025-07-10 11:37:28');

-- --------------------------------------------------------

--
-- Estrutura para tabela `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `image`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Popular', 'All Games', '01J1X58EXE93QFH62S67YT7XBT.png', 'todos', '2023-11-13 14:59:07', '2024-08-30 16:03:57'),
(17, 'Slots', 'Slots', '', 'slots', '2023-12-24 12:06:46', '2025-02-06 11:00:28'),
(18, 'Blockchain', 'Blockchain', '', 'Blockchain', '2023-12-24 12:10:01', '2025-02-06 11:00:35'),
(19, 'Recentes', 'Recentes', '', 'Recentes', '2023-12-24 12:12:36', '2025-02-06 11:00:46'),
(22, 'Favoritos', 'Favoritos', '', 'Favoritos', '2025-02-06 11:00:57', '2025-02-06 11:00:57');

-- --------------------------------------------------------

--
-- Estrutura para tabela `category_game`
--

CREATE TABLE `category_game` (
  `category_id` bigint UNSIGNED NOT NULL,
  `game_id` bigint UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=FIXED;

--
-- Despejando dados para a tabela `category_game`
--

INSERT INTO `category_game` (`category_id`, `game_id`) VALUES
(1, 631),
(1, 634),
(1, 632),
(17, 1797),
(1, 633),
(1, 635),
(1, 636),
(1, 637),
(1, 638),
(17, 1775),
(17, 1774),
(1, 640),
(1, 641),
(1, 639),
(1, 642),
(19, 1520),
(19, 1457),
(19, 1444),
(19, 1449),
(19, 1514),
(17, 1380),
(20, 6709),
(1, 6709),
(17, 2869),
(17, 2870),
(17, 1821),
(1, 1821),
(1, 2870),
(1, 2869),
(1, 1797),
(1, 1774),
(19, 1775),
(17, 2873),
(17, 2874),
(17, 2875),
(1, 2876),
(17, 2876),
(1, 2875),
(17, 2877),
(17, 2879),
(17, 3436),
(1, 2873),
(17, 2880),
(17, 2881),
(18, 2881),
(1, 2880),
(1, 2874),
(18, 2874),
(17, 3437),
(17, 3438),
(17, 2884),
(17, 2885),
(17, 2882),
(18, 2878),
(17, 2878),
(1, 2878),
(1, 2907),
(17, 2907),
(17, 3186),
(17, 3115),
(1, 3115),
(17, 2920),
(1, 2920),
(17, 3091),
(17, 2983),
(17, 2970),
(17, 3110),
(17, 2911),
(17, 2913),
(17, 2893),
(17, 3147),
(17, 2900),
(17, 2973),
(17, 2975),
(17, 2883),
(17, 3212),
(17, 2950),
(17, 2918),
(17, 2944),
(17, 3007),
(1, 2879),
(17, 2889),
(1, 2889),
(17, 2887),
(17, 2886),
(17, 2890),
(17, 2888),
(17, 2892),
(17, 2891),
(17, 2896),
(17, 2895),
(17, 2894),
(17, 2899),
(17, 2898),
(17, 2902),
(17, 2901),
(17, 2905),
(17, 2904),
(1, 2871),
(17, 2871),
(17, 2903),
(17, 2906),
(17, 2908),
(17, 2909),
(17, 2910),
(17, 2914),
(17, 2912),
(17, 2915);

-- --------------------------------------------------------

--
-- Estrutura para tabela `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `symbol`, `created_at`, `updated_at`) VALUES
(1, 'Leke', 'ALL', 'Lek', '2023-11-07 18:01:38', NULL),
(2, 'Dollars', 'USD', '$', '2023-11-07 18:01:38', NULL),
(3, 'Afghanis', 'AFN', '؋', '2023-11-07 18:01:38', NULL),
(4, 'Pesos', 'ARS', '$', '2023-11-07 18:01:38', NULL),
(5, 'Guilders', 'AWG', 'ƒ', '2023-11-07 18:01:38', NULL),
(6, 'Dollars', 'AUD', '$', '2023-11-07 18:01:38', NULL),
(7, 'New Manats', 'AZN', 'ман', '2023-11-07 18:01:38', NULL),
(8, 'Dollars', 'BSD', '$', '2023-11-07 18:01:38', NULL),
(9, 'Dollars', 'BBD', '$', '2023-11-07 18:01:38', NULL),
(10, 'Rubles', 'BYR', 'p.', '2023-11-07 18:01:38', NULL),
(11, 'Euro', 'EUR', '€', '2023-11-07 18:01:38', NULL),
(12, 'Dollars', 'BZD', 'BZ$', '2023-11-07 18:01:38', NULL),
(13, 'Dollars', 'BMD', '$', '2023-11-07 18:01:38', NULL),
(14, 'Bolivianos', 'BOB', '$b', '2023-11-07 18:01:38', NULL),
(15, 'Convertible Marka', 'BAM', 'KM', '2023-11-07 18:01:38', NULL),
(16, 'Pula', 'BWP', 'P', '2023-11-07 18:01:38', NULL),
(17, 'Leva', 'BGN', 'лв', '2023-11-07 18:01:38', NULL),
(18, 'Reais', 'BRL', 'R$', '2023-11-07 18:01:38', NULL),
(19, 'Pounds', 'GBP', '£', '2023-11-07 18:01:38', NULL),
(20, 'Dollars', 'BND', '$', '2023-11-07 18:01:38', NULL),
(21, 'Riels', 'KHR', '៛', '2023-11-07 18:01:38', NULL),
(22, 'Dollars', 'CAD', '$', '2023-11-07 18:01:38', NULL),
(23, 'Dollars', 'KYD', '$', '2023-11-07 18:01:38', NULL),
(24, 'Pesos', 'CLP', '$', '2023-11-07 18:01:38', NULL),
(25, 'Yuan Renminbi', 'CNY', '¥', '2023-11-07 18:01:38', NULL),
(26, 'Pesos', 'COP', '$', '2023-11-07 18:01:38', NULL),
(27, 'Colón', 'CRC', '₡', '2023-11-07 18:01:38', NULL),
(28, 'Kuna', 'HRK', 'kn', '2023-11-07 18:01:38', NULL),
(29, 'Pesos', 'CUP', '₱', '2023-11-07 18:01:38', NULL),
(30, 'Koruny', 'CZK', 'Kč', '2023-11-07 18:01:38', NULL),
(31, 'Kroner', 'DKK', 'kr', '2023-11-07 18:01:38', NULL),
(32, 'Pesos', 'DOP', 'RD$', '2023-11-07 18:01:38', NULL),
(33, 'Dollars', 'XCD', '$', '2023-11-07 18:01:38', NULL),
(34, 'Pounds', 'EGP', '£', '2023-11-07 18:01:38', NULL),
(35, 'Colones', 'SVC', '$', '2023-11-07 18:01:38', NULL),
(36, 'Pounds', 'FKP', '£', '2023-11-07 18:01:38', NULL),
(37, 'Dollars', 'FJD', '$', '2023-11-07 18:01:38', NULL),
(38, 'Cedis', 'GHC', '¢', '2023-11-07 18:01:38', NULL),
(39, 'Pounds', 'GIP', '£', '2023-11-07 18:01:38', NULL),
(40, 'Quetzales', 'GTQ', 'Q', '2023-11-07 18:01:38', NULL),
(41, 'Pounds', 'GGP', '£', '2023-11-07 18:01:38', NULL),
(42, 'Dollars', 'GYD', '$', '2023-11-07 18:01:38', NULL),
(43, 'Lempiras', 'HNL', 'L', '2023-11-07 18:01:38', NULL),
(44, 'Dollars', 'HKD', '$', '2023-11-07 18:01:38', NULL),
(45, 'Forint', 'HUF', 'Ft', '2023-11-07 18:01:38', NULL),
(46, 'Kronur', 'ISK', 'kr', '2023-11-07 18:01:38', NULL),
(47, 'Rupees', 'INR', 'Rp', '2023-11-07 18:01:38', NULL),
(48, 'Rupiahs', 'IDR', 'Rp', '2023-11-07 18:01:38', NULL),
(49, 'Rials', 'IRR', '﷼', '2023-11-07 18:01:38', NULL),
(50, 'Pounds', 'IMP', '£', '2023-11-07 18:01:38', NULL),
(51, 'New Shekels', 'ILS', '₪', '2023-11-07 18:01:38', NULL),
(52, 'Dollars', 'JMD', 'J$', '2023-11-07 18:01:38', NULL),
(53, 'Yen', 'JPY', '¥', '2023-11-07 18:01:38', NULL),
(54, 'Pounds', 'JEP', '£', '2023-11-07 18:01:38', NULL),
(55, 'Tenge', 'KZT', 'лв', '2023-11-07 18:01:38', NULL),
(56, 'Won', 'KPW', '₩', '2023-11-07 18:01:38', NULL),
(57, 'Won', 'KRW', '₩', '2023-11-07 18:01:38', NULL),
(58, 'Soms', 'KGS', 'лв', '2023-11-07 18:01:38', NULL),
(59, 'Kips', 'LAK', '₭', '2023-11-07 18:01:38', NULL),
(60, 'Lati', 'LVL', 'Ls', '2023-11-07 18:01:38', NULL),
(61, 'Pounds', 'LBP', '£', '2023-11-07 18:01:38', NULL),
(62, 'Dollars', 'LRD', '$', '2023-11-07 18:01:38', NULL),
(63, 'Switzerland Francs', 'CHF', 'CHF', '2023-11-07 18:01:38', NULL),
(64, 'Litai', 'LTL', 'Lt', '2023-11-07 18:01:38', NULL),
(65, 'Denars', 'MKD', 'ден', '2023-11-07 18:01:38', NULL),
(66, 'Ringgits', 'MYR', 'RM', '2023-11-07 18:01:38', NULL),
(67, 'Rupees', 'MUR', '₨', '2023-11-07 18:01:38', NULL),
(68, 'Pesos', 'MXN', '$', '2023-11-07 18:01:38', NULL),
(69, 'Tugriks', 'MNT', '₮', '2023-11-07 18:01:38', NULL),
(70, 'Meticais', 'MZN', 'MT', '2023-11-07 18:01:38', NULL),
(71, 'Dollars', 'NAD', '$', '2023-11-07 18:01:38', NULL),
(72, 'Rupees', 'NPR', '₨', '2023-11-07 18:01:38', NULL),
(73, 'Guilders', 'ANG', 'ƒ', '2023-11-07 18:01:38', NULL),
(74, 'Dollars', 'NZD', '$', '2023-11-07 18:01:38', NULL),
(75, 'Cordobas', 'NIO', 'C$', '2023-11-07 18:01:38', NULL),
(76, 'Nairas', 'NGN', '₦', '2023-11-07 18:01:38', NULL),
(77, 'Krone', 'NOK', 'kr', '2023-11-07 18:01:38', NULL),
(78, 'Rials', 'OMR', '﷼', '2023-11-07 18:01:38', NULL),
(79, 'Rupees', 'PKR', '₨', '2023-11-07 18:01:38', NULL),
(80, 'Balboa', 'PAB', 'B/.', '2023-11-07 18:01:38', NULL),
(81, 'Guarani', 'PYG', 'Gs', '2023-11-07 18:01:38', NULL),
(82, 'Nuevos Soles', 'PEN', 'S/.', '2023-11-07 18:01:38', NULL),
(83, 'Pesos', 'PHP', 'Php', '2023-11-07 18:01:38', NULL),
(84, 'Zlotych', 'PLN', 'zł', '2023-11-07 18:01:38', NULL),
(85, 'Rials', 'QAR', '﷼', '2023-11-07 18:01:38', NULL),
(86, 'New Lei', 'RON', 'lei', '2023-11-07 18:01:38', NULL),
(87, 'Rubles', 'RUB', 'руб', '2023-11-07 18:01:38', NULL),
(88, 'Pounds', 'SHP', '£', '2023-11-07 18:01:38', NULL),
(89, 'Riyals', 'SAR', '﷼', '2023-11-07 18:01:38', NULL),
(90, 'Dinars', 'RSD', 'Дин.', '2023-11-07 18:01:38', NULL),
(91, 'Rupees', 'SCR', '₨', '2023-11-07 18:01:38', NULL),
(92, 'Dollars', 'SGD', '$', '2023-11-07 18:01:38', NULL),
(93, 'Dollars', 'SBD', '$', '2023-11-07 18:01:38', NULL),
(94, 'Shillings', 'SOS', 'S', '2023-11-07 18:01:38', NULL),
(95, 'Rand', 'ZAR', 'R', '2023-11-07 18:01:38', NULL),
(96, 'Rupees', 'LKR', '₨', '2023-11-07 18:01:38', NULL),
(97, 'Kronor', 'SEK', 'kr', '2023-11-07 18:01:38', NULL),
(98, 'Dollars', 'SRD', '$', '2023-11-07 18:01:38', NULL),
(99, 'Pounds', 'SYP', '£', '2023-11-07 18:01:38', NULL),
(100, 'New Dollars', 'TWD', 'NT$', '2023-11-07 18:01:38', NULL),
(101, 'Baht', 'THB', '฿', '2023-11-07 18:01:38', NULL),
(102, 'Dollars', 'TTD', 'TT$', '2023-11-07 18:01:38', NULL),
(103, 'Lira', 'TRY', '₺', '2023-11-07 18:01:38', NULL),
(104, 'Liras', 'TRL', '£', '2023-11-07 18:01:38', NULL),
(105, 'Dollars', 'TVD', '$', '2023-11-07 18:01:38', NULL),
(106, 'Hryvnia', 'UAH', '₴', '2023-11-07 18:01:38', NULL),
(107, 'Pesos', 'UYU', '$U', '2023-11-07 18:01:38', NULL),
(108, 'Sums', 'UZS', 'лв', '2023-11-07 18:01:38', NULL),
(109, 'Bolivares Fuertes', 'VEF', 'Bs', '2023-11-07 18:01:38', NULL),
(110, 'Dong', 'VND', '₫', '2023-11-07 18:01:38', NULL),
(111, 'Rials', 'YER', '﷼', '2023-11-07 18:01:38', NULL),
(112, 'Zimbabwe Dollars', 'ZWD', 'Z$', '2023-11-07 18:01:38', NULL),
(113, 'Rupees', 'INR', '₹', '2023-11-07 18:01:38', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `currency_alloweds`
--

CREATE TABLE `currency_alloweds` (
  `id` bigint UNSIGNED NOT NULL,
  `currency_id` bigint UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Estrutura para tabela `custom_layouts`
--

CREATE TABLE `custom_layouts` (
  `id` bigint UNSIGNED NOT NULL,
  `font_family_default` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#0073D2',
  `primary_opacity_color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secundary_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#084375',
  `gray_dark_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#3b3b3b',
  `gray_light_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#c9c9c9',
  `gray_medium_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#676767',
  `gray_over_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#1A1C20',
  `title_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#ffffff',
  `text_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#98A7B5',
  `sub_text_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#656E78',
  `placeholder_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#4D565E',
  `background_color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#24262B',
  `background_base` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '#ECEFF1',
  `background_base_dark` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '#24262B',
  `carousel_banners` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '#1E2024',
  `carousel_banners_dark` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '#1E2024',
  `sidebar_color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sidebar_color_dark` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `navtop_color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `navtop_color_dark` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `side_menu` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `side_menu_dark` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `input_primary` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `input_primary_dark` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_color_dark` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_color_dark` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `border_radius` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '.25rem',
  `custom_css` text COLLATE utf8mb4_unicode_ci,
  `custom_js` text COLLATE utf8mb4_unicode_ci,
  `custom_body` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `custom_header` longtext COLLATE utf8mb4_unicode_ci,
  `instagram` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telegram` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whastapp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `youtube` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `custom_layouts`
--

INSERT INTO `custom_layouts` (`id`, `font_family_default`, `primary_color`, `primary_opacity_color`, `secundary_color`, `gray_dark_color`, `gray_light_color`, `gray_medium_color`, `gray_over_color`, `title_color`, `text_color`, `sub_text_color`, `placeholder_color`, `background_color`, `background_base`, `background_base_dark`, `carousel_banners`, `carousel_banners_dark`, `sidebar_color`, `sidebar_color_dark`, `navtop_color`, `navtop_color_dark`, `side_menu`, `side_menu_dark`, `input_primary`, `input_primary_dark`, `footer_color`, `footer_color_dark`, `card_color`, `card_color_dark`, `border_radius`, `custom_css`, `custom_js`, `custom_body`, `created_at`, `updated_at`, `custom_header`, `instagram`, `telegram`, `whastapp`, `facebook`, `twitter`, `youtube`) VALUES
(1, '\'Roboto Condensed\', sans-serif', '#FFF0BB', '#062064', '#FFF0BB', '#1542b3', '#062064', '#6FA4EF', '#05309F', '#fff', '#fff', '#656E78', '#302e2e', '#24262B', '#171616', '#05309F', '#bdbdbd', '#05309F', '#ffffff', '#062064', '#d8d8de', '#000000', '#828282', '#05309F', '#3a61c2', '#2A815F', '#919191', '#062064', '#ababab', '#000000', '5px', NULL, '<?php echo \'jsjs\'; ?>', '<?php echo \'hehe\'; ?>', '2024-01-01 14:36:03', '2025-07-21 11:20:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `daily_checkins`
--

CREATE TABLE `daily_checkins` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `checkin_date` date NOT NULL,
  `rewards` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `debug`
--

CREATE TABLE `debug` (
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `debug`
--

INSERT INTO `debug` (`text`) VALUES
('\"PlaceBet: 914806915\"'),
('\"PlaceBet: 914806915\"'),
('\"AwardWinnings: 914806915\"'),
('\"PlaceBet: 914806916\"'),
('\"AwardWinnings: 914806916\"'),
('\"PlaceBet: 914806916\"'),
('\"PlaceBet: 914806917\"'),
('\"PlaceBet: 914806918\"'),
('\"AwardWinnings: 914806918\"'),
('\"PlaceBet: 914806918\"'),
('\"PlaceBet: 914806919\"'),
('\"AwardWinnings: 914806919\"'),
('\"AwardWinnings: 914806919\"'),
('\"PlaceBet: 914806920\"'),
('\"PlaceBet: 914806921\"'),
('\"AwardWinnings: 914806921\"'),
('\"PlaceBet: 535367\"'),
('\"PlaceBet: 154646\"'),
('\"PlaceBet: 914806922\"'),
('\"PlaceBet: 914806923\"'),
('\"PlaceBet: 914806924\"'),
('\"AwardWinnings: 914806924\"'),
('{\"idTransaction\":\"4562a92e-0ec6-453e-8b26-5546433dc2f9\",\"typeTransaction\":\"PIX_CASHOUT\",\"statusTransaction\":\"PAID_OUT\",\"value\":100,\"destinationName\":\"Cintia da Silva Reis\",\"destinationTaxId\":\"08019527940\",\"destinationBank\":\"NUBANK\"}'),
('{\"idTransaction\":\"f6243806-a4b4-45b8-b386-290fa4f96fc0\",\"typeTransaction\":\"PIX_CASHOUT\",\"statusTransaction\":\"PAID_OUT\",\"value\":50,\"destinationName\":\"CAMILLA EVELLIN FERRAZ CLEMENTINO\",\"destinationTaxId\":\"42051354839\",\"destinationBank\":\"BRADESCO\"}');

-- --------------------------------------------------------

--
-- Estrutura para tabela `deposits`
--

CREATE TABLE `deposits` (
  `id` bigint UNSIGNED NOT NULL,
  `payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `proof` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `currency` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `deposits`
--

INSERT INTO `deposits` (`id`, `payment_id`, `user_id`, `amount`, `type`, `proof`, `status`, `currency`, `symbol`, `created_at`, `updated_at`) VALUES
(2, 'aa3911862933df8cfba7mcxlpqw63afj', 927613841, 20.00, 'pix', NULL, 0, 'BRL', 'R$', '2025-07-10 13:27:37', '2025-07-10 13:27:37');

-- --------------------------------------------------------

--
-- Estrutura para tabela `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `games`
--

CREATE TABLE `games` (
  `id` bigint UNSIGNED NOT NULL,
  `provider_id` int UNSIGNED NOT NULL,
  `game_server_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `game_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `game_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `game_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `game_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `technology` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_lobby` tinyint NOT NULL DEFAULT '0',
  `is_mobile` tinyint NOT NULL DEFAULT '0',
  `has_freespins` tinyint NOT NULL DEFAULT '0',
  `has_tables` tinyint NOT NULL DEFAULT '0',
  `only_demo` tinyint DEFAULT '0',
  `rtp` bigint NOT NULL COMMENT 'Controle de RTP em porcentagem',
  `distribution` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'O nome do provedor',
  `views` bigint NOT NULL DEFAULT '0',
  `is_featured` tinyint(1) DEFAULT '0',
  `show_home` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `games`
--

INSERT INTO `games` (`id`, `provider_id`, `game_server_url`, `game_id`, `game_name`, `game_code`, `game_type`, `description`, `cover`, `status`, `technology`, `has_lobby`, `is_mobile`, `has_freespins`, `has_tables`, `only_demo`, `rtp`, `distribution`, `views`, `is_featured`, `show_home`, `created_at`, `updated_at`) VALUES
(1774, 11, NULL, '1543462', 'Fortune Rabbit', 'fortune-rabbit', 'slot', NULL, '01JD0PE6TMZMZC5RN8XD17Z8TC.png', '1', 'html5', 1, 0, 0, 0, 0, 80, 'games2_api', 8978, 1, 1, '2024-03-10 09:54:39', '2024-11-18 19:31:36'),
(1775, 11, NULL, '69', 'Bikini Paradise ', '69', 'slot', NULL, '01J1XVJJKB2XQQKRSY1R6GSGVE.png', '0', 'html5', 0, 0, 0, 0, 0, 80, 'games2_api', 3219, 0, 0, '2024-03-10 09:54:39', '2024-07-04 00:43:07'),
(1797, 11, NULL, '98', 'Fortune Ox', 'fortune-ox', 'slot', NULL, '01JD0PE8F24XP6P9NKHFRFTSNF.png', '1', 'html5', 1, 0, 0, 0, 0, 80, 'games2_api', 6947, 1, 1, '2024-03-10 09:54:47', '2024-11-18 19:31:38'),
(1821, 11, NULL, '68', 'Fortune Mouse', 'fortune-mouse', 'slot', NULL, '01JD0PEBRK8J4Q55750J89G8JK.png', '1', 'html5', 0, 0, 0, 0, 0, 80, 'games2_api', 24894, 1, 1, '2024-03-10 09:54:59', '2024-11-18 19:31:41'),
(2869, 11, NULL, '126', 'Fortune Tiger', 'fortune-tiger', 'Slot', NULL, '01JD0PECYBNS0E4JX8KX4WKT50.png', '1', NULL, 0, 0, 0, 0, 0, 90, 'games2_api', 23300, 1, 1, '2024-03-21 10:22:46', '2024-11-18 19:31:42'),
(2870, 11, NULL, '1695365', 'Fortune Dragon', 'fortune-dragon', 'Slot', NULL, '01JD0PEE9Z5X48CHCAPWVTZA0P.png', '1', NULL, 1, 0, 0, 0, 0, 90, 'games2_api', 27897, 1, 1, '2024-03-21 10:29:29', '2024-11-18 19:31:44'),
(2871, 11, NULL, '1879752', 'Fortune Snake', 'fortune-snake', 'Slot', NULL, '01JM8NNB76197JB1RWQRW9S490.png', '1', NULL, 0, 0, 0, 0, 0, 90, 'evergame', 1, 1, 1, '2024-04-26 13:25:01', '2025-02-16 21:53:33'),
(2879, 11, NULL, '57', 'Mystic Potion', 'dragon-hatch', 'Slot', NULL, '01JD0PF4FCSDR7Q7HWKMPGTG37.png', '1', NULL, 0, 0, 0, 0, 0, 90, 'evergame', 1, 1, 1, '2024-07-04 00:44:26', '2024-11-18 19:32:06'),
(2873, 11, NULL, '1508783', 'Wild Ape', 'wild-ape-3258', 'Slot', NULL, '01JD0PEFCS1GH1CD3XBS4YZ7P2.png', '1', NULL, 0, 0, 0, 0, 0, 90, 'games2_api', 19, 1, 1, '2024-07-04 00:11:23', '2024-11-18 19:31:45'),
(2874, 11, NULL, '1778752', 'Futebol Fever', 'futebol-fever', 'Slot', NULL, '01JD0PENGHPS4TQZV712T8R3PH.png', '1', NULL, 0, 0, 0, 0, 0, 90, 'evergame', 13, 1, 1, '2024-07-04 00:11:45', '2024-11-18 19:31:51'),
(2875, 11, NULL, '1492288', 'Pinata Wins', 'pinata-wins', 'Slot', NULL, '01JD0PEQRPKA86ZJDH3BADB2FG.png', '1', NULL, 0, 0, 0, 0, 0, 90, 'games2_api', 8, 1, 1, '2024-07-04 00:11:57', '2024-11-18 19:31:53'),
(2876, 11, NULL, '104', 'Wild Bandito', 'wild-bandito', 'Slot', NULL, '01JD0PEW3B4Y10NZW5XAV4K3Z0.png', '1', NULL, 0, 0, 0, 0, 0, 90, 'games2_api', 2, 1, 1, '2024-07-04 00:12:22', '2024-11-18 19:31:58'),
(2877, 11, NULL, '1451122', 'Dragon Hatch 2', 'dragon-hatch2', 'Slot', NULL, '01JD0PEXS05PS7HZ22BGPZEWJW.png', '1', NULL, 0, 0, 0, 0, 0, 90, 'games2_api', 6, 1, 1, '2024-07-04 00:13:08', '2024-11-18 19:32:00'),
(2878, 11, NULL, '100', 'Candy Bonanza', 'candy-bonanza', 'Slot', NULL, '01JD0PEZ6Q3N30WYNE17S79YWS.png', '1', NULL, 0, 0, 0, 0, 0, 90, 'games2_api', 0, 1, 1, '2024-07-04 00:13:29', '2024-11-18 19:32:01'),
(2880, 11, NULL, '1682240', 'Cash Mania', 'cash-mania', 'Slot', NULL, '01JD0PF69KWN1ZQZQQSJ9BTW76.png', '1', NULL, 0, 0, 0, 0, 0, 90, 'games2_api', 1, 1, 1, '2024-07-16 00:34:39', '2024-11-18 19:32:08'),
(2881, 11, NULL, '63', 'Dragon Tiger Luck', '63', 'Slot', NULL, '01JD0PF7TSAT4H4FKV3PYS0X6P.png', '1', NULL, 0, 0, 0, 0, 0, 90, 'games2_api', 0, 1, 1, '2024-07-17 22:59:24', '2024-11-18 19:32:10'),
(2882, 11, NULL, '40', 'Jungle Delight', 'jungle-delight', 'Slot', NULL, '01JD0PF992P6PBT9QEJ9M5JPRW.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'games2_api', 0, 1, 1, '2024-07-17 23:05:22', '2024-11-18 19:32:11'),
(2883, 16, NULL, 'vs20doghouse', 'The Dog House', 'vs20doghouse', 'Slot', NULL, '01JADPCGHGRDQZZ49YKCCEYC35.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:05:23', '2024-10-17 13:53:43'),
(2884, 11, NULL, '42', 'Ganesha Fortune', 'ganesha-gold', 'Slot', NULL, '01JD0PFC7JN697NEJ4QE8V5JBQ.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'games2_api', 0, 1, 1, '2024-07-17 23:05:23', '2024-11-18 19:32:14'),
(2885, 11, NULL, '48', 'Double Fortune', 'double-fortune', 'Slot', NULL, '01JD0PFATZA48P0WDBCN3EK771.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'games2_api', 0, 1, 1, '2024-07-17 23:05:23', '2024-11-18 19:32:13'),
(2886, 11, NULL, '1648578', 'Shark Hunter', 'shark-hunter', 'Slot', NULL, '01JD0PSSCS8ENP8M30S3GH4KVC.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'games2_api', 0, 1, 1, '2024-07-17 23:05:24', '2024-11-18 19:37:55'),
(2887, 11, NULL, '1717688', 'Mystic Potion', 'mystic-potions', 'Slot', NULL, '01JD0PSCER14HFYRCHKVJQY3BT.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'games2_api', 0, 1, 1, '2024-07-17 23:05:24', '2024-11-18 19:37:42'),
(2888, 11, NULL, '1760238', 'Yakuza Honor', 'yakuza-honor', 'Slot', NULL, '01JD0PVQBX0Z5WMTS3PHSX9BDW.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:25', '2024-11-18 19:38:59'),
(2889, 11, NULL, '69', 'Bikini Paradise', 'bikini-paradise', 'Slot', NULL, '01JD0PFDQJM9WN5VSNRK4Z6YJK.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'games2_api', 0, 1, 1, '2024-07-17 23:05:25', '2025-02-07 21:18:39'),
(2890, 11, NULL, '1635221', 'Zombie Outbreak', 'zombie-outbrk', 'Slot', NULL, '01JD0PTBRTRSVMV6DHAPH6K42V.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'games2_api', 0, 1, 1, '2024-07-17 23:05:25', '2024-11-18 19:38:14'),
(2891, 11, NULL, '1727711', 'Three Crazy Piggies', 'three-crazy-piggies', 'Slot', NULL, '01JD0PWSKX5092B3V95YBZNRF4.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:26', '2024-11-18 19:39:34'),
(2892, 11, NULL, '1747549', 'Wings of Iguazu', 'wings-of-iguazu', 'Slot', NULL, '01JD0PW5HX6N1RHCK78MCTQ2ZS.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:26', '2024-11-18 19:39:13'),
(2893, 16, NULL, 'vs10madame', 'Madame Destiny', 'vs10madame', 'Slot', NULL, '01JADP8SGQYDRY5KS2EEJWC0FS.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:05:26', '2024-10-17 13:51:41'),
(2894, 11, NULL, '1338274', 'Totem Wonders', 'totem-wonders', 'Slot', NULL, '01JD0PY32MFJJ6YSCNSWHG8QQP.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:27', '2024-11-18 19:40:16'),
(2895, 11, NULL, '53', 'The Great Icescape', 'the-great-icespace', 'Slot', NULL, '01JD0PXQMTXWFECDP8WE63XNKN.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:27', '2024-11-18 19:40:05'),
(2896, 11, NULL, '1580541', 'Mafia Mayhem', 'mafia-mayhem', 'Slot', NULL, '01JD0PX6KF0NN1G7M7SH537KBT.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:27', '2024-11-18 19:39:47'),
(2897, 14, NULL, 'vs10bbbonanza', 'Big Bass Bonanza', 'vs10bbbonanza', 'Slot', NULL, '01J31SYY3JWHTWE5Y5P9WGBGAM.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 1, 1, '2024-07-17 23:05:28', '2024-10-17 13:47:49'),
(2898, 11, NULL, '39', 'Piggy Gold', 'piggy-gold', 'Slot', NULL, '01JD0PZ3MN7XZ9N5N2T8J3ZKFW.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:29', '2024-11-18 19:40:50'),
(2899, 11, NULL, '1368367', 'Alchemy Gold', 'alchemy-gold', 'Slot', NULL, '01JD0PYHAG22XBDY76AF0SBPF7.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:29', '2024-11-18 19:40:31'),
(2900, 16, NULL, 'vs25mustang', 'Mustang Gold', 'vs25mustang', 'Slot', NULL, '01JADP9831VGZ7RAV4PE563BVB.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:05:30', '2024-10-17 13:51:56'),
(2901, 11, NULL, '67', 'Shaolin Soccer', 'shaolin-soccer', 'Slot', NULL, '01JD0Q1JZ6990EBBCR51K5X3TZ.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:30', '2024-11-18 19:42:11'),
(2902, 11, NULL, '82', 'Piggy Gold', 'phoenix-rises', 'Slot', NULL, '01JD0PZEYP47NQGPM2VWDKV8GC.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:30', '2024-11-18 19:41:01'),
(2903, 11, NULL, '1815268', 'Oishi Delights', 'oish-delight', 'Slot', NULL, '01JM8NRVFYT1R5Y0WMGVEDM5HA.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 1, 1, 1, '2024-07-17 23:05:31', '2025-02-16 21:53:39'),
(2904, 11, NULL, '3', 'Fortune Gods', 'fortune-gods', 'Slot', NULL, '01JD0Q27XHD430130AC41SKGVC.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:31', '2024-11-18 19:42:33'),
(2905, 11, NULL, '59', 'Ninja vs Samurai', 'samurai-vs-ninja', 'Slot', NULL, '01JD0Q1XWGV2G1EDFR4HW5J8VZ.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 0, 1, 1, '2024-07-17 23:05:31', '2024-11-18 19:42:22'),
(2906, 11, NULL, '1786529', 'Rio Fantasia', 'rio-fantasia', 'Slot', NULL, '01JM8NSKY6A2NYRHXC0KRN6840.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 1, 1, 1, '2024-07-17 23:05:32', '2025-02-16 21:53:44'),
(2907, 16, NULL, 'vs20olympx', 'Gates of Olympus', 'vs20olympx', 'Slot', NULL, '01JADP3ZV5YWAW2WKT2PFXPH7E.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 1, 1, 1, '2024-07-17 23:05:32', '2024-10-17 13:49:03'),
(2908, 11, NULL, '1755623', 'Museum Mystery', 'museum-mystery', 'Slot', NULL, '01JM8NWGGTXGPG1QPZKHZB7929.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 1, 1, 1, '2024-07-17 23:05:33', '2025-02-16 21:53:48'),
(2909, 11, NULL, '58', 'Vampire Charm', 'vampire-charm', 'Slot', NULL, '01JM8PH7CDN1P7A5S3YDGPMX1H.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 1, 1, 1, '2024-07-17 23:05:34', '2025-02-16 21:57:35'),
(2910, 11, NULL, '88', 'Jewels of Prosperity', 'jewels-prosper', 'Slot', NULL, '01JM8NY93BP6DA1F1TFA2ZTD4X.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 1, 1, 1, '2024-07-17 23:05:35', '2025-02-16 21:54:00'),
(2911, 16, NULL, 'vs20fparty2', 'Fruit Party 2', 'vs20fparty2', 'Slot', NULL, '01JADP8CJ490SXKD2B3G3JD9TM.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:05:35', '2024-10-17 13:51:27'),
(2912, 11, NULL, '62', 'Gem Saviour Conquest', 'gem-saviour-conquest', 'Slot', NULL, '01JM8NZHDWZ1VEZ90J3YRA7SGF.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 1, 1, 1, '2024-07-17 23:05:36', '2025-02-16 21:54:05'),
(2913, 16, NULL, 'vs50juicyfr', 'Juicy Fruits', 'vs50juicyfr', 'Slot', NULL, '01JADP8KNZCSX82JP24VYQ9F5J.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:05:36', '2024-10-17 13:51:35'),
(2914, 11, NULL, '83', 'Wild Fireworks', 'wild-fireworks', 'Slot', NULL, '01JM8NYVR4ZZTERY7793YPR5PY.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 1, 1, 1, '2024-07-17 23:05:36', '2025-02-16 21:54:09'),
(2915, 11, NULL, '60', 'Leprechaun Riches', 'leprechaun-riches', 'Slot', NULL, '01JM8P0A7XCYNKGJMXEE4EMDNN.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'evergame', 1, 1, 1, '2024-07-17 23:05:37', '2025-02-16 21:54:12'),
(2916, 16, NULL, 'vs40wildwest', 'Wild West Gold', 'vs40wildwest', NULL, NULL, 'fivers/vs40wildwest.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:38', '2024-08-31 15:33:16'),
(2917, 16, NULL, 'vs20chickdrop', 'Chicken Drop', 'vs20chickdrop', NULL, NULL, 'fivers/vs20chickdrop.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:38', '2024-08-31 15:33:16'),
(2918, 16, NULL, 'vs40spartaking', 'Spartan King', 'vs40spartaking', 'Slot', NULL, '01JADPD0WT8SPPC5B3KTAM2064.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:05:38', '2024-10-17 13:53:59'),
(2919, 16, NULL, 'vswaysrhino', 'Great Rhino Megaways', 'vswaysrhino', NULL, NULL, 'fivers/vswaysrhino.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:39', '2024-08-31 15:33:16'),
(2920, 16, NULL, 'vs20sbxmas', 'Sweet Bonanza Xmas', 'vs20sbxmas', 'Slot', NULL, '01JADP3HCCWGK7FJFP6V6J5QV2.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 1, 1, 1, '2024-07-17 23:05:39', '2024-10-17 13:49:25'),
(2921, 16, NULL, 'vs10fruity2', 'Extra Juicy', 'vs10fruity2', NULL, NULL, 'fivers/vs10fruity2.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:39', '2024-08-31 15:33:16'),
(2922, 16, NULL, 'vs10egypt', 'Ancient Egypt', 'vs10egypt', NULL, NULL, 'fivers/vs10egypt.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:40', '2024-08-31 15:33:16'),
(2923, 16, NULL, 'vs5drhs', 'Dragon Hot Hold and Spin', 'vs5drhs', NULL, NULL, 'fivers/vs5drhs.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:40', '2024-08-31 15:33:16'),
(2924, 14, NULL, 'vs12bbb', 'Bigger Bass Bonanza', 'vs12bbb', 'Slot', NULL, '01J31SYV4423KGTKQ948BAP2G7.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 1, 1, '2024-07-17 23:05:41', '2024-10-17 13:47:49'),
(2925, 16, NULL, 'vs20tweethouse', 'The Tweety House', 'vs20tweethouse', NULL, NULL, 'fivers/vs20tweethouse.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:41', '2024-08-31 15:33:16'),
(2926, 16, NULL, 'vswayslions', '5 Lions Megaways', 'vswayslions', NULL, NULL, 'fivers/vswayslions.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:42', '2024-08-31 15:33:16'),
(2927, 16, NULL, 'vswayssamurai', 'Rise of Samurai Megaways', 'vswayssamurai', NULL, NULL, 'fivers/vswayssamurai.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:42', '2024-08-31 15:33:16'),
(2928, 16, NULL, 'vs50pixie', 'Pixie Wings', 'vs50pixie', NULL, NULL, 'fivers/vs50pixie.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:42', '2024-08-31 15:33:16'),
(2929, 16, NULL, 'vs10floatdrg', 'Floating Dragon', 'vs10floatdrg', NULL, NULL, 'fivers/vs10floatdrg.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:43', '2024-08-31 15:33:16'),
(2930, 16, NULL, 'vs20fruitsw', 'Sweet Bonanza', 'vs20fruitsw', 'Slot', NULL, '01J31SSM8H4NCJA6SQWEBJ8BEQ.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 1, 1, 1, '2024-07-17 23:05:43', '2024-10-17 13:48:05'),
(2931, 16, NULL, 'vs20rhinoluxe', 'Great Rhino Deluxe', 'vs20rhinoluxe', NULL, NULL, 'fivers/vs20rhinoluxe.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:43', '2024-08-31 15:33:16'),
(2932, 16, NULL, 'vs432congocash', 'Congo Cash', 'vs432congocash', NULL, NULL, 'fivers/vs432congocash.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:44', '2024-08-31 15:33:16'),
(2933, 16, NULL, 'vswaysmadame', 'Madame Destiny Megaways', 'vswaysmadame', NULL, NULL, 'fivers/vswaysmadame.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:44', '2024-08-31 15:33:16'),
(2934, 16, NULL, 'vs1024temuj', 'Temujin Treasures', 'vs1024temuj', NULL, NULL, 'fivers/vs1024temuj.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:44', '2024-08-31 15:33:16'),
(2935, 16, NULL, 'vs40pirgold', 'Pirate Gold Deluxe', 'vs40pirgold', NULL, NULL, 'fivers/vs40pirgold.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:45', '2024-08-31 15:33:16'),
(2936, 16, NULL, 'vs25mmouse', 'Money Mouse', 'vs25mmouse', NULL, NULL, 'fivers/vs25mmouse.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:45', '2024-08-31 15:33:16'),
(2937, 16, NULL, 'vs10threestar', 'Three Star Fortune', 'vs10threestar', NULL, NULL, 'fivers/vs10threestar.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:45', '2024-08-31 15:33:16'),
(2938, 16, NULL, 'vs1ball', 'Lucky Dragon Ball', 'vs1ball', NULL, NULL, 'fivers/vs1ball.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:46', '2024-08-31 15:33:16'),
(2939, 16, NULL, 'vs243lionsgold', '5 Lions', 'vs243lionsgold', NULL, NULL, 'fivers/vs243lionsgold.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:46', '2024-08-31 15:33:16'),
(2940, 16, NULL, 'vs10egyptcls', 'Ancient Egypt Classic', 'vs10egyptcls', NULL, NULL, 'fivers/vs10egyptcls.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:46', '2024-08-31 15:33:16'),
(2941, 16, NULL, 'vs25davinci', 'Da Vinci Treasure', 'vs25davinci', NULL, NULL, 'fivers/vs25davinci.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:47', '2024-08-31 15:33:16'),
(2942, 16, NULL, 'vs7776secrets', 'Aztec Treasure', 'vs7776secrets', NULL, NULL, 'fivers/vs7776secrets.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:47', '2024-08-31 15:33:16'),
(2943, 16, NULL, 'vs25wolfgold', 'Wolf Gold', 'vs25wolfgold', NULL, NULL, 'fivers/vs25wolfgold.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:48', '2024-08-31 15:33:16'),
(2944, 16, NULL, 'vs50safariking', 'Safari King', 'vs50safariking', 'Slot', NULL, '01JADPD4XF5MSG1G0P4W9GAA2Q.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:05:48', '2024-10-17 13:54:03'),
(2945, 16, NULL, 'vs25peking', 'Peking Luck', 'vs25peking', NULL, NULL, 'fivers/vs25peking.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:48', '2024-08-31 15:33:16'),
(2946, 16, NULL, 'vs25asgard', 'Asgard', 'vs25asgard', NULL, NULL, 'fivers/vs25asgard.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:49', '2024-08-31 15:33:16'),
(2947, 16, NULL, 'vs25vegas', 'Vegas Nights', 'vs25vegas', NULL, NULL, 'fivers/vs25vegas.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:49', '2024-08-31 15:33:16'),
(2948, 16, NULL, 'vs75empress', 'Golden Beauty', 'vs75empress', NULL, NULL, 'fivers/vs75empress.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:49', '2024-08-31 15:33:16'),
(2949, 16, NULL, 'vs25scarabqueen', 'John Hunter and the Tomb of the Scarab Queen', 'vs25scarabqueen', NULL, NULL, 'fivers/vs25scarabqueen.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:50', '2024-08-31 15:33:16'),
(2950, 16, NULL, 'vs20starlight', 'Starlight Princess', 'vs20starlight', 'Slot', NULL, '01JADPCXWKJ8GV18YFCM6X2RFW.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:05:50', '2024-10-17 13:53:56'),
(2951, 16, NULL, 'vs10bookoftut', 'John Hunter and the Book of Tut', 'vs10bookoftut', NULL, NULL, 'fivers/vs10bookoftut.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:50', '2024-08-31 15:33:16'),
(2952, 16, NULL, 'vs9piggybank', 'Piggy Bank Bills', 'vs9piggybank', NULL, NULL, 'fivers/vs9piggybank.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:51', '2024-08-31 15:33:16'),
(2953, 16, NULL, 'vs5drmystery', 'Dragon Kingdom Mystery', 'vs5drmystery', NULL, NULL, 'fivers/vs5drmystery.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:51', '2024-08-31 15:33:16'),
(2954, 16, NULL, 'vs20eightdragons', 'Eight Dragons', 'vs20eightdragons', NULL, NULL, 'fivers/vs20eightdragons.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:51', '2024-08-31 15:33:16'),
(2955, 16, NULL, 'vs1024lionsd', '5 Lions Dance', 'vs1024lionsd', NULL, NULL, 'fivers/vs1024lionsd.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:52', '2024-08-31 15:33:16'),
(2956, 16, NULL, 'vs25rio', 'Heart of Rio', 'vs25rio', NULL, NULL, 'fivers/vs25rio.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:52', '2024-08-31 15:33:16'),
(2957, 16, NULL, 'vs10nudgeit', 'Rise of Giza PowerNudge', 'vs10nudgeit', NULL, NULL, 'fivers/vs10nudgeit.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:52', '2024-08-31 15:33:16'),
(2958, 14, NULL, 'vs10bxmasbnza', 'Christmas Big Bass Bonanza', 'vs10bxmasbnza', 'Slot', NULL, '01J31SYBH89AHRMEGJKD8WHBKC.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 1, 1, '2024-07-17 23:05:53', '2024-10-17 13:47:49'),
(2959, 16, NULL, 'vs20santawonder', 'Santa\'s Wonderland', 'vs20santawonder', NULL, NULL, 'fivers/vs20santawonder.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:53', '2024-08-31 15:33:16'),
(2960, 16, NULL, 'vs20terrorv', 'Cash Elevator', 'vs20terrorv', NULL, NULL, 'fivers/vs20terrorv.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:54', '2024-08-31 15:33:16'),
(2961, 16, NULL, 'vs10bblpop', 'Bubble Pop', 'vs10bblpop', NULL, NULL, 'fivers/vs10bblpop.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:54', '2024-08-31 15:33:16'),
(2962, 16, NULL, 'vs25btygold', 'Bounty Gold', 'vs25btygold', NULL, NULL, 'fivers/vs25btygold.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:54', '2024-08-31 15:33:16'),
(2963, 16, NULL, 'vs88hockattack', 'Hockey Attack™', 'vs88hockattack', NULL, NULL, 'fivers/vs88hockattack.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:55', '2024-08-31 15:33:16'),
(2964, 16, NULL, 'vswaysbbb', 'Big Bass Bonanza Megaways™', 'vswaysbbb', NULL, NULL, 'fivers/vswaysbbb.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:55', '2024-08-31 15:33:16'),
(2965, 16, NULL, 'vs10bookfallen', 'Book of the Fallen', 'vs10bookfallen', NULL, NULL, 'fivers/vs10bookfallen.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:55', '2024-08-31 15:33:16'),
(2966, 16, NULL, 'vs40bigjuan', 'Big Juan', 'vs40bigjuan', NULL, NULL, 'fivers/vs40bigjuan.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:56', '2024-08-31 15:33:16'),
(2967, 16, NULL, 'vs20bermuda', 'John Hunter and the Quest for Bermuda Riches', 'vs20bermuda', NULL, NULL, 'fivers/vs20bermuda.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:56', '2024-08-31 15:33:16'),
(2968, 16, NULL, 'vs10starpirate', 'Star Pirates Code', 'vs10starpirate', NULL, NULL, 'fivers/vs10starpirate.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:56', '2024-08-31 15:33:16'),
(2969, 16, NULL, 'vswayswest', 'Mystic Chief', 'vswayswest', NULL, NULL, 'fivers/vswayswest.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:57', '2024-08-31 15:33:16'),
(2970, 16, NULL, 'vs20daydead', 'Day of Dead', 'vs20daydead', 'Slot', NULL, '01JADP80386ACMA6EES98FGCDZ.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:05:57', '2024-10-17 13:51:15'),
(2971, 16, NULL, 'vs20candvil', 'Candy Village', 'vs20candvil', NULL, NULL, 'fivers/vs20candvil.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:57', '2024-08-31 15:33:16'),
(2972, 16, NULL, 'vs20wildboost', 'Wild Booster', 'vs20wildboost', NULL, NULL, 'fivers/vs20wildboost.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:58', '2024-08-31 15:33:16'),
(2973, 16, NULL, 'vswayshammthor', 'Power of Thor Megaways', 'vswayshammthor', 'Slot', NULL, '01JADP9F69F6XSW8FM9APM2FXG.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:05:58', '2024-10-17 13:52:03'),
(2974, 16, NULL, 'vs243lions', '5 Lions', 'vs243lions', NULL, NULL, 'fivers/vs243lions.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:59', '2024-08-31 15:33:16'),
(2975, 16, NULL, 'vs5super7', 'Super 7s', 'vs5super7', 'Slot', NULL, '01JADPC60GHVVD8S84FZNRJN6H.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:05:59', '2024-10-17 13:53:32'),
(2976, 16, NULL, 'vs1masterjoker', 'Master Joker', 'vs1masterjoker', NULL, NULL, 'fivers/vs1masterjoker.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:05:59', '2024-08-31 15:33:16'),
(2977, 16, NULL, 'vs20kraken', 'Release the Kraken', 'vs20kraken', NULL, NULL, 'fivers/vs20kraken.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:00', '2024-08-31 15:33:16'),
(2978, 16, NULL, 'vs10firestrike', 'Fire Strike', 'vs10firestrike', NULL, NULL, 'fivers/vs10firestrike.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:00', '2024-08-31 15:33:16'),
(2979, 16, NULL, 'vs243fortune', 'Caishen\'s Gold', 'vs243fortune', NULL, NULL, 'fivers/vs243fortune.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:01', '2024-08-31 15:33:16'),
(2980, 16, NULL, 'vs4096mystery', 'Mysterious', 'vs4096mystery', NULL, NULL, 'fivers/vs4096mystery.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:01', '2024-08-31 15:33:16'),
(2981, 16, NULL, 'vs20aladdinsorc', 'Aladdin and the Sorcerrer', 'vs20aladdinsorc', NULL, NULL, 'fivers/vs20aladdinsorc.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:01', '2024-08-31 15:33:16'),
(2982, 16, NULL, 'vs243fortseren', 'Greek Gods', 'vs243fortseren', NULL, NULL, 'fivers/vs243fortseren.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:02', '2024-08-31 15:33:16'),
(2983, 16, NULL, 'vs25chilli', 'Chilli Heat', 'vs25chilli', 'Slot', NULL, '01JADP7RP7FW1MN6SVEMFT06B7.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:06:02', '2024-10-17 13:51:07'),
(2984, 16, NULL, 'vs8magicjourn', 'Magic Journey', 'vs8magicjourn', NULL, NULL, 'fivers/vs8magicjourn.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:03', '2024-08-31 15:33:16'),
(2985, 16, NULL, 'vs25pantherqueen', 'Panther Queen', 'vs25pantherqueen', NULL, NULL, 'fivers/vs25pantherqueen.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:03', '2024-08-31 15:33:16'),
(2986, 16, NULL, 'vs20leprexmas', 'Leprechaun Carol', 'vs20leprexmas', NULL, NULL, 'fivers/vs20leprexmas.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:04', '2024-08-31 15:33:16'),
(2987, 16, NULL, 'vs7pigs', '7 Piggies', 'vs7pigs', NULL, NULL, 'fivers/vs7pigs.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:04', '2024-08-31 15:33:16'),
(2988, 16, NULL, 'vs243caishien', 'Caishen\'s Cash', 'vs243caishien', NULL, NULL, 'fivers/vs243caishien.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:04', '2024-08-31 15:33:16'),
(2989, 16, NULL, 'vs5joker', 'Joker\'s Jewels', 'vs5joker', 'Slot', NULL, '01J31SSV63CNDQJSNZVPBBZMNT.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 1, 1, '2024-07-17 23:06:05', '2024-10-17 13:48:05'),
(2990, 16, NULL, 'vs25gladiator', 'Wild Gladiator', 'vs25gladiator', NULL, NULL, 'fivers/vs25gladiator.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:05', '2024-08-31 15:33:16'),
(2991, 16, NULL, 'vs25goldpig', 'Golden Pig', 'vs25goldpig', NULL, NULL, 'fivers/vs25goldpig.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:06', '2024-08-31 15:33:16'),
(2992, 16, NULL, 'vs25goldrush', 'Gold Rush', 'vs25goldrush', NULL, NULL, 'fivers/vs25goldrush.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:06', '2024-08-31 15:33:16'),
(2993, 16, NULL, 'vs25dragonkingdom', 'Dragon Kingdom', 'vs25dragonkingdom', NULL, NULL, 'fivers/vs25dragonkingdom.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:07', '2024-08-31 15:33:16'),
(2994, 16, NULL, 'vs25kingdoms', '3 Kingdoms - Battle of Red Cliffs', 'vs25kingdoms', NULL, NULL, 'fivers/vs25kingdoms.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:07', '2024-08-31 15:33:16'),
(2995, 16, NULL, 'vs1dragon8', '888 Dragons', 'vs1dragon8', NULL, NULL, 'fivers/vs1dragon8.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:08', '2024-08-31 15:33:16'),
(2996, 16, NULL, 'vs5aztecgems', 'Aztec Gems', 'vs5aztecgems', NULL, NULL, 'fivers/vs5aztecgems.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:08', '2024-08-31 15:33:16'),
(2997, 16, NULL, 'vs20hercpeg', 'Hercules and Pegasus', 'vs20hercpeg', NULL, NULL, 'fivers/vs20hercpeg.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:08', '2024-08-31 15:33:16'),
(2998, 16, NULL, 'vs7fire88', 'Fire 88', 'vs7fire88', NULL, NULL, 'fivers/vs7fire88.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:09', '2024-08-31 15:33:16'),
(2999, 16, NULL, 'vs20honey', 'Honey Honey Honey', 'vs20honey', NULL, NULL, 'fivers/vs20honey.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:10', '2024-08-31 15:33:16'),
(3000, 16, NULL, 'vs25safari', 'Hot Safari', 'vs25safari', NULL, NULL, 'fivers/vs25safari.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:10', '2024-08-31 15:33:16'),
(3001, 16, NULL, 'vs25journey', 'Journey to the West', 'vs25journey', NULL, NULL, 'fivers/vs25journey.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:10', '2024-08-31 15:33:16'),
(3002, 16, NULL, 'vs20chicken', 'The Great Chicken Escape', 'vs20chicken', NULL, NULL, 'fivers/vs20chicken.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:11', '2024-08-31 15:33:16'),
(3003, 16, NULL, 'vs1fortunetree', 'Tree of Riches', 'vs1fortunetree', NULL, NULL, 'fivers/vs1fortunetree.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:11', '2024-08-31 15:33:16'),
(3004, 16, NULL, 'vs20wildpix', 'Wild Pixies', 'vs20wildpix', NULL, NULL, 'fivers/vs20wildpix.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:11', '2024-08-31 15:33:16'),
(3005, 16, NULL, 'vs15fairytale', 'Fairytale Fortune', 'vs15fairytale', NULL, NULL, 'fivers/vs15fairytale.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:12', '2024-08-31 15:33:16'),
(3006, 16, NULL, 'vs20santa', 'Santa', 'vs20santa', NULL, NULL, 'fivers/vs20santa.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:12', '2024-08-31 15:33:16'),
(3007, 16, NULL, 'vs10vampwolf', 'Vampires vs Wolves', 'vs10vampwolf', 'Slot', NULL, '01JADPDZZE9YESKZC3C756GY28.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:06:12', '2024-10-17 13:54:31'),
(3008, 16, NULL, 'vs50aladdin', '3 Genie Wishes', 'vs50aladdin', NULL, NULL, 'fivers/vs50aladdin.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:13', '2024-08-31 15:33:16'),
(3009, 16, NULL, 'vs50hercules', 'Hercules Son of Zeus', 'vs50hercules', NULL, NULL, 'fivers/vs50hercules.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:13', '2024-08-31 15:33:16'),
(3010, 16, NULL, 'vs7776aztec', 'Aztec Bonanza', 'vs7776aztec', NULL, NULL, 'fivers/vs7776aztec.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:13', '2024-08-31 15:33:16'),
(3011, 16, NULL, 'vs5trdragons', 'Triple Dragons', 'vs5trdragons', NULL, NULL, 'fivers/vs5trdragons.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:14', '2024-08-31 15:33:16'),
(3012, 16, NULL, 'vs40madwheel', 'The Wild Machine', 'vs40madwheel', NULL, NULL, 'fivers/vs40madwheel.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:14', '2024-08-31 15:33:16'),
(3013, 16, NULL, 'vs25newyear', 'Lucky New Year', 'vs25newyear', NULL, NULL, 'fivers/vs25newyear.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:14', '2024-08-31 15:33:16'),
(3014, 16, NULL, 'vs40frrainbow', 'Fruit Rainbow', 'vs40frrainbow', NULL, NULL, 'fivers/vs40frrainbow.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:15', '2024-08-31 15:33:16'),
(3015, 16, NULL, 'vs50kingkong', 'Mighty Kong', 'vs50kingkong', NULL, NULL, 'fivers/vs50kingkong.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:15', '2024-08-31 15:33:16'),
(3016, 16, NULL, 'vs20godiva', 'Lady Godiva', 'vs20godiva', NULL, NULL, 'fivers/vs20godiva.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:16', '2024-08-31 15:33:16'),
(3017, 16, NULL, 'vs9madmonkey', 'Monkey Madness', 'vs9madmonkey', NULL, NULL, 'fivers/vs9madmonkey.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:16', '2024-08-31 15:33:16'),
(3018, 16, NULL, 'vs1tigers', 'Triple Tigers', 'vs1tigers', NULL, NULL, 'fivers/vs1tigers.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:16', '2024-08-31 15:33:16'),
(3019, 16, NULL, 'vs9chen', 'Master Chen\'s Fortune', 'vs9chen', NULL, NULL, 'fivers/vs9chen.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:17', '2024-08-31 15:33:16'),
(3020, 16, NULL, 'vs5hotburn', 'Hot to burn', 'vs5hotburn', NULL, NULL, 'fivers/vs5hotburn.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:17', '2024-08-31 15:33:16'),
(3021, 16, NULL, 'vs25dwarves_new', 'Dwarven Gold Deluxe', 'vs25dwarves_new', NULL, NULL, 'fivers/vs25dwarves_new.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:17', '2024-08-31 15:33:16'),
(3022, 16, NULL, 'vs1024butterfly', 'Jade Butterfly', 'vs1024butterfly', NULL, NULL, 'fivers/vs1024butterfly.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:18', '2024-08-31 15:33:16'),
(3023, 16, NULL, 'vs25sea', 'Great Reef', 'vs25sea', NULL, NULL, 'fivers/vs25sea.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:18', '2024-08-31 15:33:16'),
(3024, 16, NULL, 'vs20leprechaun', 'Leprechaun Song', 'vs20leprechaun', NULL, NULL, 'fivers/vs20leprechaun.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:19', '2024-08-31 15:33:16'),
(3025, 16, NULL, 'vs7monkeys', '7 Monkeys', 'vs7monkeys', NULL, NULL, 'fivers/vs7monkeys.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:19', '2024-08-31 15:33:16'),
(3026, 16, NULL, 'vs50chinesecharms', 'Lucky Dragons', 'vs50chinesecharms', NULL, NULL, 'fivers/vs50chinesecharms.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:20', '2024-08-31 15:33:16'),
(3027, 16, NULL, 'vs18mashang', 'Treasure Horse', 'vs18mashang', NULL, NULL, 'fivers/vs18mashang.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:20', '2024-08-31 15:33:16'),
(3028, 16, NULL, 'vs5spjoker', 'Super Joker', 'vs5spjoker', NULL, NULL, 'fivers/vs5spjoker.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:21', '2024-08-31 15:33:16'),
(3029, 16, NULL, 'vs20egypttrs', 'Egyptian Fortunes', 'vs20egypttrs', NULL, NULL, 'fivers/vs20egypttrs.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:21', '2024-08-31 15:33:16'),
(3030, 16, NULL, 'vs25queenofgold', 'Queen of Gold', 'vs25queenofgold', NULL, NULL, 'fivers/vs25queenofgold.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:22', '2024-08-31 15:33:16'),
(3031, 16, NULL, 'vs9hotroll', 'Hot Chilli', 'vs9hotroll', NULL, NULL, 'fivers/vs9hotroll.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:22', '2024-08-31 15:33:16'),
(3032, 16, NULL, 'vs4096jurassic', 'Jurassic Giants', 'vs4096jurassic', NULL, NULL, 'fivers/vs4096jurassic.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:24', '2024-08-31 15:33:16'),
(3033, 16, NULL, 'vs3train', 'Gold Train', 'vs3train', NULL, NULL, 'fivers/vs3train.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:24', '2024-08-31 15:33:16'),
(3034, 16, NULL, 'vs40beowulf', 'Beowulf', 'vs40beowulf', NULL, NULL, 'fivers/vs40beowulf.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:25', '2024-08-31 15:33:16'),
(3035, 16, NULL, 'vs1024atlantis', 'Queen of Atlantis', 'vs1024atlantis', NULL, NULL, 'fivers/vs1024atlantis.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:25', '2024-08-31 15:33:16'),
(3036, 16, NULL, 'vs20bl', 'Busy Bees', 'vs20bl', NULL, NULL, 'fivers/vs20bl.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:26', '2024-08-31 15:33:16'),
(3037, 16, NULL, 'vs25champ', 'The Champions', 'vs25champ', NULL, NULL, 'fivers/vs25champ.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:27', '2024-08-31 15:33:16'),
(3038, 16, NULL, 'vs13g', 'Devil\'s 13', 'vs13g', NULL, NULL, 'fivers/vs13g.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:27', '2024-08-31 15:33:16'),
(3039, 16, NULL, 'vs243crystalcave', 'Magic Crystals', 'vs243crystalcave', NULL, NULL, 'fivers/vs243crystalcave.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:29', '2024-08-31 15:33:16'),
(3040, 16, NULL, 'vs5trjokers', 'Triple Jokers', 'vs5trjokers', NULL, NULL, 'fivers/vs5trjokers.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:29', '2024-08-31 15:33:16'),
(3041, 16, NULL, 'vs1money', 'Money Money Money', 'vs1money', NULL, NULL, 'fivers/vs1money.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:30', '2024-08-31 15:33:16'),
(3042, 16, NULL, 'vs75bronco', 'Bronco Spirit', 'vs75bronco', NULL, NULL, 'fivers/vs75bronco.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:30', '2024-08-31 15:33:16'),
(3043, 16, NULL, 'vs1600drago', 'Drago - Jewels of Fortune', 'vs1600drago', NULL, NULL, 'fivers/vs1600drago.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:31', '2024-08-31 15:33:16'),
(3044, 16, NULL, 'vs1fufufu', 'Fu Fu Fu', 'vs1fufufu', NULL, NULL, 'fivers/vs1fufufu.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:31', '2024-08-31 15:33:16'),
(3045, 16, NULL, 'vs40streetracer', 'Street Racer', 'vs40streetracer', NULL, NULL, 'fivers/vs40streetracer.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:31', '2024-08-31 15:33:16'),
(3046, 16, NULL, 'vs9aztecgemsdx', 'Aztec Gems Deluxe', 'vs9aztecgemsdx', NULL, NULL, 'fivers/vs9aztecgemsdx.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:32', '2024-08-31 15:33:16'),
(3047, 16, NULL, 'vs20gorilla', 'Jungle Gorilla', 'vs20gorilla', NULL, NULL, 'fivers/vs20gorilla.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:32', '2024-08-31 15:33:16'),
(3048, 16, NULL, 'vswayswerewolf', 'Curse of the Werewolf Megaways', 'vswayswerewolf', NULL, NULL, 'fivers/vswayswerewolf.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:33', '2024-08-31 15:33:16'),
(3049, 16, NULL, 'vswayshive', 'Star Bounty', 'vswayshive', NULL, NULL, 'fivers/vswayshive.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:33', '2024-08-31 15:33:16'),
(3050, 16, NULL, 'vs25samurai', 'Rise of Samurai', 'vs25samurai', NULL, NULL, 'fivers/vs25samurai.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:33', '2024-08-31 15:33:16'),
(3051, 16, NULL, 'vs25walker', 'Wild Walker', 'vs25walker', NULL, NULL, 'fivers/vs25walker.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:34', '2024-08-31 15:33:16'),
(3052, 16, NULL, 'vs20goldfever', 'Gems Bonanza', 'vs20goldfever', NULL, NULL, 'fivers/vs20goldfever.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:34', '2024-08-31 15:33:16'),
(3053, 16, NULL, 'vs25bkofkngdm', 'Book of Kingdoms', 'vs25bkofkngdm', NULL, NULL, 'fivers/vs25bkofkngdm.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:35', '2024-08-31 15:33:16'),
(3054, 16, NULL, 'vs10goldfish', 'Fishin Reels', 'vs10goldfish', NULL, NULL, 'fivers/vs10goldfish.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:35', '2024-08-31 15:33:16'),
(3055, 16, NULL, 'vs1024dtiger', 'The Dragon Tiger', 'vs1024dtiger', NULL, NULL, 'fivers/vs1024dtiger.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:35', '2024-08-31 15:33:16'),
(3056, 16, NULL, 'vs20eking', 'Emerald King', 'vs20eking', NULL, NULL, 'fivers/vs20eking.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:36', '2024-08-31 15:33:16'),
(3057, 16, NULL, 'vs20xmascarol', 'Christmas Carol Megaways', 'vs20xmascarol', NULL, NULL, 'fivers/vs20xmascarol.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:36', '2024-08-31 15:33:16'),
(3058, 16, NULL, 'vs10mayangods', 'John Hunter and the Mayan Gods', 'vs10mayangods', NULL, NULL, 'fivers/vs10mayangods.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:36', '2024-08-31 15:33:16'),
(3059, 16, NULL, 'vs20bonzgold', 'Bonanza Gold', 'vs20bonzgold', NULL, NULL, 'fivers/vs20bonzgold.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:37', '2024-08-31 15:33:16'),
(3060, 16, NULL, 'vs40voodoo', 'Voodoo Magic', 'vs40voodoo', NULL, NULL, 'fivers/vs40voodoo.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:37', '2024-08-31 15:33:16'),
(3061, 16, NULL, 'vs25gldox', 'Golden Ox', 'vs25gldox', NULL, NULL, 'fivers/vs25gldox.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:37', '2024-08-31 15:33:16'),
(3062, 16, NULL, 'vs10wildtut', 'Mysterious Egypt', 'vs10wildtut', NULL, NULL, 'fivers/vs10wildtut.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:38', '2024-08-31 15:33:16'),
(3063, 16, NULL, 'vs20ekingrr', 'Emerald King Rainbow Road', 'vs20ekingrr', NULL, NULL, 'fivers/vs20ekingrr.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:38', '2024-08-31 15:33:16'),
(3064, 16, NULL, 'vs10eyestorm', 'Eye of the Storm', 'vs10eyestorm', NULL, NULL, 'fivers/vs10eyestorm.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:38', '2024-08-31 15:33:16'),
(3065, 16, NULL, 'vs117649starz', 'Starz Megaways', 'vs117649starz', NULL, NULL, 'fivers/vs117649starz.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:39', '2024-08-31 15:33:16'),
(3066, 16, NULL, 'vs10amm', 'The Amazing Money Machine', 'vs10amm', NULL, NULL, 'fivers/vs10amm.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:39', '2024-08-31 15:33:16'),
(3067, 16, NULL, 'vs20magicpot', 'The Magic Cauldron - Enchanted Brew', 'vs20magicpot', NULL, NULL, 'fivers/vs20magicpot.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:39', '2024-08-31 15:33:16'),
(3068, 16, NULL, 'vswaysyumyum', 'Yum Yum Powerways', 'vswaysyumyum', NULL, NULL, 'fivers/vswaysyumyum.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:40', '2024-08-31 15:33:16'),
(3069, 16, NULL, 'vswayselements', 'Elemental Gems Megaways', 'vswayselements', NULL, NULL, 'fivers/vswayselements.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:40', '2024-08-31 15:33:16'),
(3070, 16, NULL, 'vswayschilheat', 'Chilli Heat Megaways', 'vswayschilheat', NULL, NULL, 'fivers/vswayschilheat.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:41', '2024-08-31 15:33:16'),
(3071, 16, NULL, 'vs10luckcharm', 'Lucky Grace And Charm', 'vs10luckcharm', NULL, NULL, 'fivers/vs10luckcharm.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:41', '2024-08-31 15:33:16'),
(3072, 16, NULL, 'vswaysaztecking', 'Aztec King Megaways', 'vswaysaztecking', NULL, NULL, 'fivers/vswaysaztecking.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:42', '2024-08-31 15:33:16'),
(3073, 16, NULL, 'vs20phoenixf', 'Phoenix Forge', 'vs20phoenixf', NULL, NULL, 'fivers/vs20phoenixf.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:42', '2024-08-31 15:33:16'),
(3074, 16, NULL, 'vs576hokkwolf', 'Hokkaido Wolf', 'vs576hokkwolf', NULL, NULL, 'fivers/vs576hokkwolf.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:42', '2024-08-31 15:33:16'),
(3075, 16, NULL, 'vs20trsbox', 'Treasure Wild', 'vs20trsbox', NULL, NULL, 'fivers/vs20trsbox.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:43', '2024-08-31 15:33:16'),
(3076, 16, NULL, 'vs243chargebull', 'Raging Bull', 'vs243chargebull', NULL, NULL, 'fivers/vs243chargebull.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:43', '2024-08-31 15:33:16'),
(3077, 16, NULL, 'vswaysbankbonz', 'Cash Bonanza', 'vswaysbankbonz', NULL, NULL, 'fivers/vswaysbankbonz.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:44', '2024-08-31 15:33:16'),
(3078, 16, NULL, 'vs20pbonanza', 'Pyramid Bonanza', 'vs20pbonanza', NULL, NULL, 'fivers/vs20pbonanza.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:44', '2024-08-31 15:33:16'),
(3079, 16, NULL, 'vs243empcaishen', 'Emperor Caishen', 'vs243empcaishen', NULL, NULL, 'fivers/vs243empcaishen.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:44', '2024-08-31 15:33:16'),
(3080, 16, NULL, 'vs25tigeryear', 'New Year Tiger Treasures ™', 'vs25tigeryear', NULL, NULL, 'fivers/vs25tigeryear.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:45', '2024-08-31 15:33:16'),
(3081, 16, NULL, 'vs20amuleteg', 'Fortune of Giza™', 'vs20amuleteg', NULL, NULL, 'fivers/vs20amuleteg.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:45', '2024-08-31 15:33:16'),
(3082, 16, NULL, 'vs10runes', 'Gates of Valhalla™', 'vs10runes', NULL, NULL, 'fivers/vs10runes.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:45', '2024-08-31 15:33:16'),
(3083, 16, NULL, 'vs25goldparty', 'Gold Party®', 'vs25goldparty', 'Slot', NULL, '01J31SV4S3R7839G7KZT2VW9E9.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 1, 1, '2024-07-17 23:06:46', '2024-10-17 13:48:05'),
(3084, 16, NULL, 'vswaysxjuicy', 'Extra Juicy Megaways™', 'vswaysxjuicy', NULL, NULL, 'fivers/vswaysxjuicy.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:46', '2024-08-31 15:33:16'),
(3085, 16, NULL, 'vs40wanderw', 'Wild Depths™', 'vs40wanderw', NULL, NULL, 'fivers/vs40wanderw.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:46', '2024-08-31 15:33:16'),
(3086, 16, NULL, 'vs4096magician', 'Magician\'s Secrets™', 'vs4096magician', NULL, NULL, 'fivers/vs4096magician.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:47', '2024-08-31 15:33:16'),
(3087, 16, NULL, 'vs20smugcove', 'Smugglers Cove™', 'vs20smugcove', NULL, NULL, 'fivers/vs20smugcove.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:47', '2024-08-31 15:33:16'),
(3088, 16, NULL, 'vswayscryscav', 'Crystal Caverns Megaways™', 'vswayscryscav', NULL, NULL, 'fivers/vswayscryscav.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:47', '2024-08-31 15:33:16'),
(3089, 16, NULL, 'vs20superx', 'Super X™', 'vs20superx', NULL, NULL, 'fivers/vs20superx.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:48', '2024-08-31 15:33:16'),
(3090, 16, NULL, 'vs20rockvegas', 'Rock Vegas Mega Hold & Spin', 'vs20rockvegas', NULL, NULL, 'fivers/vs20rockvegas.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:48', '2024-08-31 15:33:16'),
(3091, 16, NULL, 'vs25copsrobbers', 'Cash Patrol', 'vs25copsrobbers', 'Slot', NULL, '01JADP7HKH3YEMZ9T7RBN0VCFN.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:06:49', '2024-10-17 13:51:00'),
(3092, 16, NULL, 'vs20colcashzone', 'Colossal Cash Zone', 'vs20colcashzone', NULL, NULL, 'fivers/vs20colcashzone.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:49', '2024-08-31 15:33:16'),
(3093, 16, NULL, 'vs20ultim5', 'The Ultimate 5', 'vs20ultim5', NULL, NULL, 'fivers/vs20ultim5.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:50', '2024-08-31 15:33:16'),
(3094, 16, NULL, 'vs20bchprty', 'Wild Beach Party', 'vs20bchprty', NULL, NULL, 'fivers/vs20bchprty.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:50', '2024-08-31 15:33:16'),
(3095, 16, NULL, 'vs10bookazteck', 'Book of Aztec King', 'vs10bookazteck', NULL, NULL, 'fivers/vs10bookazteck.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:51', '2024-08-31 15:33:16'),
(3096, 16, NULL, 'vs10snakeladd', 'Snakes and Ladders Megadice', 'vs10snakeladd', NULL, NULL, 'fivers/vs10snakeladd.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:51', '2024-08-31 15:33:16'),
(3097, 16, NULL, 'vs50mightra', 'Might of Ra', 'vs50mightra', NULL, NULL, 'fivers/vs50mightra.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:51', '2024-08-31 15:33:16'),
(3098, 16, NULL, 'vs25bullfiesta', 'Bull Fiesta', 'vs25bullfiesta', NULL, NULL, 'fivers/vs25bullfiesta.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:52', '2024-08-31 15:33:16'),
(3099, 16, NULL, 'vs20rainbowg', 'Rainbow Gold', 'vs20rainbowg', NULL, NULL, 'fivers/vs20rainbowg.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:52', '2024-08-31 15:33:16'),
(3100, 16, NULL, 'vs10tictac', 'Tic Tac Take', 'vs10tictac', NULL, NULL, 'fivers/vs10tictac.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:52', '2024-08-31 15:33:16'),
(3101, 16, NULL, 'vs243discolady', 'Disco Lady', 'vs243discolady', NULL, NULL, 'fivers/vs243discolady.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:53', '2024-08-31 15:33:16'),
(3102, 16, NULL, 'vs243queenie', 'Queenie', 'vs243queenie', NULL, NULL, 'fivers/vs243queenie.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:53', '2024-08-31 15:33:16'),
(3103, 16, NULL, 'vs20farmfest', 'Barn Festival', 'vs20farmfest', NULL, NULL, 'fivers/vs20farmfest.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:54', '2024-08-31 15:33:16'),
(3104, 16, NULL, 'vs10chkchase', 'Chicken Chase', 'vs10chkchase', NULL, NULL, 'fivers/vs10chkchase.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:54', '2024-08-31 15:33:16');
INSERT INTO `games` (`id`, `provider_id`, `game_server_url`, `game_id`, `game_name`, `game_code`, `game_type`, `description`, `cover`, `status`, `technology`, `has_lobby`, `is_mobile`, `has_freespins`, `has_tables`, `only_demo`, `rtp`, `distribution`, `views`, `is_featured`, `show_home`, `created_at`, `updated_at`) VALUES
(3105, 16, NULL, 'vswayswildwest', 'Wild West Gold Megaways', 'vswayswildwest', NULL, NULL, 'fivers/vswayswildwest.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:54', '2024-08-31 15:33:16'),
(3106, 16, NULL, 'vs20mustanggld2', 'Clover Gold', 'vs20mustanggld2', 'Slot', NULL, '01J31SV3G59WS9RWNP6W1P5FE1.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 1, 1, '2024-07-17 23:06:55', '2024-10-17 13:48:05'),
(3107, 16, NULL, 'vs20drtgold', 'Drill That Gold', 'vs20drtgold', NULL, NULL, 'fivers/vs20drtgold.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:55', '2024-08-31 15:33:16'),
(3108, 16, NULL, 'vs10spiritadv', 'Spirit of Adventure', 'vs10spiritadv', NULL, NULL, 'fivers/vs10spiritadv.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:56', '2024-08-31 15:33:16'),
(3109, 16, NULL, 'vs10firestrike2', 'Fire Strike 2', 'vs10firestrike2', NULL, NULL, 'fivers/vs10firestrike2.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:56', '2024-08-31 15:33:16'),
(3110, 16, NULL, 'vs40cleoeye', 'Eye of Cleopatra', 'vs40cleoeye', 'Slot', NULL, '01JADP8623E0GQV9SR11X2DS9B.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:06:57', '2024-10-17 13:51:21'),
(3111, 16, NULL, 'vs20gobnudge', 'Goblin Heist Powernudge', 'vs20gobnudge', NULL, NULL, 'fivers/vs20gobnudge.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:57', '2024-08-31 15:33:16'),
(3112, 16, NULL, 'vs20stickysymbol', 'The Great Stick-up', 'vs20stickysymbol', NULL, NULL, 'fivers/vs20stickysymbol.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:57', '2024-08-31 15:33:16'),
(3113, 16, NULL, 'vswayszombcarn', 'Zombie Carnival', 'vswayszombcarn', NULL, NULL, 'fivers/vswayszombcarn.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:58', '2024-08-31 15:33:16'),
(3114, 16, NULL, 'vs50northgard', 'North Guardians', 'vs50northgard', NULL, NULL, 'fivers/vs50northgard.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:06:59', '2024-08-31 15:33:16'),
(3115, 16, NULL, 'vs20sugarrush', 'Sugar Rush', 'vs20sugarrush', 'Slot', NULL, '01JADP3N3EG5RTTY8CWK1Y1RMV.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:07:00', '2024-10-17 13:49:21'),
(3116, 16, NULL, 'vs20cleocatra', 'Cleocatra', 'vs20cleocatra', NULL, NULL, 'fivers/vs20cleocatra.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:00', '2024-08-31 15:33:16'),
(3117, 16, NULL, 'vs5littlegem', 'Little Gem Hold and Spin', 'vs5littlegem', NULL, NULL, 'fivers/vs5littlegem.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:00', '2024-08-31 15:33:16'),
(3118, 16, NULL, 'vs10egrich', 'Queen of Gods', 'vs10egrich', NULL, NULL, 'fivers/vs10egrich.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:01', '2024-08-31 15:33:16'),
(3119, 16, NULL, 'vs243koipond', 'Koi Pond', 'vs243koipond', NULL, NULL, 'fivers/vs243koipond.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:01', '2024-08-31 15:33:16'),
(3120, 16, NULL, 'vs40samurai3', 'Rise of Samurai 3', 'vs40samurai3', NULL, NULL, 'fivers/vs40samurai3.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:02', '2024-08-31 15:33:16'),
(3121, 16, NULL, 'vs40cosmiccash', 'Cosmic Cash', 'vs40cosmiccash', NULL, NULL, 'fivers/vs40cosmiccash.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:02', '2024-08-31 15:33:16'),
(3122, 16, NULL, 'vs25bomb', 'Bomb Bonanza', 'vs25bomb', NULL, NULL, 'fivers/vs25bomb.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:03', '2024-08-31 15:33:16'),
(3123, 16, NULL, 'vs1024mahjpanda', 'Mahjong Panda', 'vs1024mahjpanda', NULL, NULL, 'fivers/vs1024mahjpanda.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:03', '2024-08-31 15:33:16'),
(3124, 16, NULL, 'vs10coffee', 'Coffee Wild', 'vs10coffee', NULL, NULL, 'fivers/vs10coffee.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:04', '2024-08-31 15:33:16'),
(3125, 16, NULL, 'vs100sh', 'Shining Hot 100', 'vs100sh', NULL, NULL, 'fivers/vs100sh.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:04', '2024-08-31 15:33:16'),
(3126, 16, NULL, 'vs20sh', 'Shining Hot 20', 'vs20sh', NULL, NULL, 'fivers/vs20sh.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:04', '2024-08-31 15:33:16'),
(3127, 16, NULL, 'vs40sh', 'Shining Hot 40', 'vs40sh', NULL, NULL, 'fivers/vs40sh.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:05', '2024-08-31 15:33:16'),
(3128, 16, NULL, 'vs5sh', 'Shining Hot 5', 'vs5sh', NULL, NULL, 'fivers/vs5sh.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:05', '2024-08-31 15:33:16'),
(3129, 16, NULL, 'vswaysjkrdrop', 'Tropical Tiki', 'vswaysjkrdrop', NULL, NULL, 'fivers/vswaysjkrdrop.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:05', '2024-08-31 15:33:16'),
(3130, 16, NULL, 'vs243ckemp', 'Cheeky Emperor', 'vs243ckemp', NULL, NULL, 'fivers/vs243ckemp.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:06', '2024-08-31 15:33:16'),
(3131, 16, NULL, 'vs40hotburnx', 'Hot To Burn Extreme', 'vs40hotburnx', NULL, NULL, 'fivers/vs40hotburnx.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:06', '2024-08-31 15:33:16'),
(3132, 16, NULL, 'vs1024gmayhem', 'Gorilla Mayhem', 'vs1024gmayhem', NULL, NULL, 'fivers/vs1024gmayhem.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:06', '2024-08-31 15:33:16'),
(3133, 16, NULL, 'vs20octobeer', 'Octobeer Fortunes', 'vs20octobeer', NULL, NULL, 'fivers/vs20octobeer.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:07', '2024-08-31 15:33:16'),
(3134, 14, NULL, 'vs10txbigbass', 'Big Bass Splash', 'vs10txbigbass', 'Slot', NULL, '01J31SY94THQT6CEN82N90G90F.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 1, 1, '2024-07-17 23:07:07', '2024-10-17 13:47:49'),
(3135, 16, NULL, 'vs100firehot', 'Fire Hot 100', 'vs100firehot', NULL, NULL, 'fivers/vs100firehot.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:08', '2024-08-31 15:33:16'),
(3136, 16, NULL, 'vs20fh', 'Fire Hot 20', 'vs20fh', NULL, NULL, 'fivers/vs20fh.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:08', '2024-08-31 15:33:16'),
(3137, 16, NULL, 'vs40firehot', 'Fire Hot 40', 'vs40firehot', NULL, NULL, 'fivers/vs40firehot.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:09', '2024-08-31 15:33:16'),
(3138, 16, NULL, 'vs5firehot', 'Fire Hot 5', 'vs5firehot', NULL, NULL, 'fivers/vs5firehot.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:09', '2024-08-31 15:33:16'),
(3139, 16, NULL, 'vs20wolfie', 'Greedy Wolf', 'vs20wolfie', NULL, NULL, 'fivers/vs20wolfie.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:09', '2024-08-31 15:33:16'),
(3140, 16, NULL, 'vs20underground', 'Down the Rails', 'vs20underground', NULL, NULL, 'fivers/vs20underground.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:10', '2024-08-31 15:33:16'),
(3141, 16, NULL, 'vs10mmm', 'Magic Money Maze', 'vs10mmm', NULL, NULL, 'fivers/vs10mmm.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:10', '2024-08-31 15:33:16'),
(3142, 16, NULL, 'vswaysfltdrg', 'Floating Dragon Hold & Spin Megaways', 'vswaysfltdrg', NULL, NULL, 'fivers/vswaysfltdrg.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:11', '2024-08-31 15:33:16'),
(3143, 16, NULL, 'vs20wildman', 'Wildman Super Bonanza', 'vs20wildman', NULL, NULL, 'fivers/vs20wildman.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:11', '2024-08-31 15:33:16'),
(3144, 16, NULL, 'vs20trswild2', 'Black Bull', 'vs20trswild2', NULL, NULL, 'fivers/vs20trswild2.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:12', '2024-08-31 15:33:16'),
(3145, 16, NULL, 'vswaysstrwild', 'Candy Stars', 'vswaysstrwild', NULL, NULL, 'fivers/vswaysstrwild.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:12', '2024-08-31 15:33:16'),
(3146, 16, NULL, 'vs10crownfire', 'Crown of Fire', 'vs10crownfire', NULL, NULL, 'fivers/vs10crownfire.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:13', '2024-08-31 15:33:16'),
(3147, 16, NULL, 'vs20muertos', 'Muertos Multiplier Megaways', 'vs20muertos', 'Slot', NULL, '01JADP90WHEAAS98ZK34VGS9B2.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:07:13', '2024-10-17 13:51:48'),
(3148, 16, NULL, 'vswayslofhero', 'Legend of Heroes', 'vswayslofhero', NULL, NULL, 'fivers/vswayslofhero.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:13', '2024-08-31 15:33:16'),
(3149, 16, NULL, 'vs5strh', 'Striking Hot 5', 'vs5strh', NULL, NULL, 'fivers/vs5strh.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:14', '2024-08-31 15:33:16'),
(3150, 16, NULL, 'vs10snakeeyes', 'Snakes & Ladders - Snake Eyes', 'vs10snakeeyes', NULL, NULL, 'fivers/vs10snakeeyes.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:14', '2024-08-31 15:33:16'),
(3151, 16, NULL, 'vswaysbook', 'Book of Golden Sands', 'vswaysbook', NULL, NULL, 'fivers/vswaysbook.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:15', '2024-08-31 15:33:16'),
(3152, 16, NULL, 'vs20mparty', 'Wild Hop and Drop', 'vs20mparty', NULL, NULL, 'fivers/vs20mparty.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:15', '2024-08-31 15:33:16'),
(3153, 16, NULL, 'vs20swordofares', 'Sword of Ares', 'vs20swordofares', NULL, NULL, 'fivers/vs20swordofares.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:15', '2024-08-31 15:33:16'),
(3154, 16, NULL, 'vswaysfrywld', 'Spin & Score Megaways', 'vswaysfrywld', NULL, NULL, 'fivers/vswaysfrywld.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:16', '2024-08-31 15:33:16'),
(3155, 16, NULL, 'vs10tut', 'Book of Tut Respin', 'vs10tut', NULL, NULL, 'fivers/vs10tut.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:16', '2024-08-31 15:33:16'),
(3156, 16, NULL, 'vs20porbs', 'Santa\'s Great Gifts', 'vs20porbs', NULL, NULL, 'fivers/vs20porbs.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:17', '2024-08-31 15:33:16'),
(3157, 16, NULL, 'vs12bbbxmas', 'Bigger Bass Blizzaro', 'vs12bbbxmas', NULL, NULL, 'fivers/vs12bbbxmas.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:17', '2024-08-31 15:33:16'),
(3158, 16, NULL, 'vs20asgard', 'Kingdom of Asgard™', 'vs20asgard', NULL, NULL, 'fivers/vs20asgard.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:18', '2024-08-31 15:33:16'),
(3159, 16, NULL, 'vs25kfruit', 'Aztec Blaze', 'vs25kfruit', NULL, NULL, 'fivers/vs25kfruit.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:18', '2024-08-31 15:33:16'),
(3160, 16, NULL, 'vs20kraken2', 'Release the Kraken 2™', 'vs20kraken2', NULL, NULL, 'fivers/vs20kraken2.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:18', '2024-08-31 15:33:16'),
(3161, 16, NULL, 'vswaysconcoll', 'Sweet PowerNudge™', 'vswaysconcoll', NULL, NULL, 'fivers/vswaysconcoll.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:19', '2024-08-31 15:33:16'),
(3162, 16, NULL, 'vs20schristmas', 'Starlight Chrismas', 'vs20schristmas', NULL, NULL, 'fivers/vs20schristmas.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:19', '2024-08-31 15:33:16'),
(3163, 16, NULL, 'vs20theights', 'Towering Fortunes™', 'vs20theights', NULL, NULL, 'fivers/vs20theights.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:20', '2024-08-31 15:33:16'),
(3164, 16, NULL, 'vs20gatotgates', 'Gates of Gatotkaca™', 'vs20gatotgates', NULL, NULL, 'fivers/vs20gatotgates.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:20', '2024-08-31 15:33:16'),
(3165, 16, NULL, 'vs20lcount', 'Gems of Serengeti™', 'vs20lcount', NULL, NULL, 'fivers/vs20lcount.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:20', '2024-08-31 15:33:16'),
(3166, 16, NULL, 'vs20mtreasure', 'Pirate Golden Age™', 'vs20mtreasure', NULL, NULL, 'fivers/vs20mtreasure.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:21', '2024-08-31 15:33:16'),
(3167, 16, NULL, 'vs20sparta', 'Shield of Sparta', 'vs20sparta', NULL, NULL, 'fivers/vs20sparta.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:21', '2024-08-31 15:33:16'),
(3168, 16, NULL, 'vs10bbkir', 'Big Bass Bonanza Keeping it Reel', 'vs10bbkir', NULL, NULL, 'fivers/vs10bbkir.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:22', '2024-08-31 15:33:16'),
(3169, 16, NULL, 'vswaysluckyfish', 'Lucky Fishing Megaways™', 'vswaysluckyfish', NULL, NULL, 'fivers/vswaysluckyfish.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:22', '2024-08-31 15:33:16'),
(3170, 16, NULL, 'vswaysrabbits', '5 Rabbits Megaways™', 'vswaysrabbits', NULL, NULL, 'fivers/vswaysrabbits.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:23', '2024-08-31 15:33:16'),
(3171, 16, NULL, 'vs20drgbless', 'Dragon Hero', 'vs20drgbless', NULL, NULL, 'fivers/vs20drgbless.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:23', '2024-08-31 15:33:16'),
(3172, 16, NULL, 'vswayspizza', 'Pizza Pizza Pizza', 'vswayspizza', NULL, NULL, 'fivers/vswayspizza.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:23', '2024-08-31 15:33:16'),
(3173, 16, NULL, 'vs25rlbank', 'Reel Banks™', 'vs25rlbank', NULL, NULL, 'fivers/vs25rlbank.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:24', '2024-08-31 15:33:16'),
(3174, 16, NULL, 'vs20aztecgates', 'Gates of Aztec™', 'vs20aztecgates', NULL, NULL, 'fivers/vs20aztecgates.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:24', '2024-08-31 15:33:16'),
(3175, 16, NULL, 'vs20dugems', 'Hot Pepper™\r\n', 'vs20dugems', NULL, NULL, 'fivers/vs20dugems.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:24', '2024-08-31 15:33:16'),
(3176, 16, NULL, 'vs20clspwrndg', 'Sweet PowerNudge', 'vs20clspwrndg', NULL, NULL, 'fivers/vs20clspwrndg.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:25', '2024-08-31 15:33:16'),
(3177, 16, NULL, 'vswaysfuryodin', 'Fury of Odin Megaways™', 'vswaysfuryodin', NULL, NULL, 'fivers/vswaysfuryodin.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:25', '2024-08-31 15:33:16'),
(3178, 16, NULL, 'vs20ltng', 'Pinup Girls', 'vs20ltng', NULL, NULL, 'fivers/vs20ltng.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:25', '2024-08-31 15:33:16'),
(3179, 16, NULL, 'vs12tropicana', 'Club Tropicana', 'vs12tropicana', NULL, NULL, 'fivers/vs12tropicana.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:26', '2024-08-31 15:33:16'),
(3180, 16, NULL, 'vs20gatotfury', 'Gatot Kaca\'s Fury', 'vs20gatotfury', NULL, NULL, 'fivers/vs20gatotfury.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:26', '2024-08-31 15:33:16'),
(3181, 16, NULL, 'vs20superlanche', 'Monster Superlanche', 'vs20superlanche', NULL, NULL, 'fivers/vs20superlanche.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:26', '2024-08-31 15:33:16'),
(3182, 16, NULL, 'vs25archer', 'Fire Archer', 'vs25archer', NULL, NULL, 'fivers/vs25archer.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:27', '2024-08-31 15:33:16'),
(3183, 16, NULL, 'vs25spgldways', 'Secret City Gold', 'vs25spgldways', NULL, NULL, 'fivers/vs25spgldways.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:27', '2024-08-31 15:33:16'),
(3184, 16, NULL, 'vswayswwhex', 'Wild Wild Bananas', 'vswayswwhex', NULL, NULL, 'fivers/vswayswwhex.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:27', '2024-08-31 15:33:16'),
(3185, 16, NULL, 'vs20mochimon', 'Mochimon', 'vs20mochimon', NULL, NULL, 'fivers/vs20mochimon.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:28', '2024-08-31 15:33:16'),
(3186, 16, NULL, 'vs20pistols', 'Wild West Duels', 'vs20pistols', 'Slot', NULL, '01JADP3RWN6ADH0HHVCRN6FQG2.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:07:28', '2024-10-17 13:49:17'),
(3187, 16, NULL, 'vswaysmorient', 'Mystery of the Orient', 'vswaysmorient', NULL, NULL, 'fivers/vswaysmorient.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:29', '2024-08-31 15:33:16'),
(3188, 16, NULL, 'vs10powerlines', 'Peak Power', 'vs10powerlines', NULL, NULL, 'fivers/vs10powerlines.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:30', '2024-08-31 15:33:16'),
(3189, 16, NULL, 'vs20goldclust', 'Rabbit Garden', 'vs20goldclust', NULL, NULL, 'fivers/vs20goldclust.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:30', '2024-08-31 15:33:16'),
(3190, 16, NULL, 'vs10fisheye', 'Fish Eye', 'vs10fisheye', NULL, NULL, 'fivers/vs10fisheye.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:31', '2024-08-31 15:33:16'),
(3191, 16, NULL, 'vs20doghousemh', 'The Dog House Multihold', 'vs20doghousemh', NULL, NULL, 'fivers/vs20doghousemh.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:31', '2024-08-31 15:33:16'),
(3192, 16, NULL, 'vs20mammoth', 'Mammoth Gold Megaways', 'vs20mammoth', NULL, NULL, 'fivers/vs20mammoth.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:31', '2024-08-31 15:33:16'),
(3193, 16, NULL, 'vswayswwriches', 'Wild Wild Riches Megaways', 'vswayswwriches', NULL, NULL, 'fivers/vswayswwriches.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:32', '2024-08-31 15:33:16'),
(3194, 16, NULL, 'vs20framazon', 'Fruits of the Amazon™', 'vs20framazon', NULL, NULL, 'fivers/vs20framazon.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:32', '2024-08-31 15:33:16'),
(3195, 16, NULL, 'vs20sknights', 'The Knight King™', 'vs20sknights', NULL, NULL, 'fivers/vs20sknights.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:33', '2024-08-31 15:33:16'),
(3196, 14, NULL, 'vs10bbhas', 'Big Bass - Hold & Spinner™', 'vs10bbhas', 'Slot', NULL, '01J31SXMZPZRHAAAMCGC9YKXC3.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 1, 1, '2024-07-17 23:07:33', '2024-10-17 13:47:49'),
(3197, 16, NULL, 'vswaysredqueen', 'The Red Queen™', 'vswaysredqueen', NULL, NULL, 'fivers/vswaysredqueen.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:34', '2024-08-31 15:33:16'),
(3198, 16, NULL, 'vswaysmonkey', '3 Dancing Monkeys', 'vswaysmonkey', NULL, NULL, 'fivers/vswaysmonkey.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:34', '2024-08-31 15:33:16'),
(3199, 16, NULL, 'vs20hotzone', 'African Elephant', 'vs20hotzone', NULL, NULL, 'fivers/vs20hotzone.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:35', '2024-08-31 15:33:16'),
(3200, 16, NULL, 'vswaysrsm', 'Wild Celebrity Bus Megaways', 'vswaysrsm', NULL, NULL, 'fivers/vswaysrsm.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:35', '2024-08-31 15:33:16'),
(3201, 16, NULL, 'vs10gizagods', 'Gods of Giza', 'vs10gizagods', NULL, NULL, 'fivers/vs10gizagods.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:36', '2024-08-31 15:33:16'),
(3202, 16, NULL, 'vs1024moonsh', 'Moonshot', 'vs1024moonsh', NULL, NULL, 'fivers/vs1024moonsh.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:36', '2024-08-31 15:33:16'),
(3203, 16, NULL, 'vs10jnmntzma', 'Jane Hunter and the Mask of Montezuma', 'vs10jnmntzma', NULL, NULL, 'fivers/vs10jnmntzma.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:36', '2024-08-31 15:33:16'),
(3204, 16, NULL, 'vswaysultrcoin', '	Cowboy Coins', 'vswaysultrcoin', NULL, NULL, 'fivers/vswaysultrcoin.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:37', '2024-08-31 15:33:16'),
(3205, 16, NULL, 'vs20mvwild', 'Jasmine Dreams', 'vs20mvwild', NULL, NULL, 'fivers/vs20mvwild.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:37', '2024-08-31 15:33:16'),
(3206, 16, NULL, 'vs10kingofdth', 'Kingdom of the Dead', 'vs10kingofdth', NULL, NULL, 'fivers/vs10kingofdth.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:38', '2024-08-31 15:33:16'),
(3207, 16, NULL, 'vswayseternity', 'Diamonds of Egypt', 'vswayseternity', NULL, NULL, 'fivers/vswayseternity.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:38', '2024-08-31 15:33:16'),
(3208, 16, NULL, 'vs25holiday', 'Holiday Ride', 'vs25holiday', NULL, NULL, 'fivers/vs25holiday.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:39', '2024-08-31 15:33:16'),
(3209, 16, NULL, 'vs20excalibur', 'Excalibur Unleashed', 'vs20excalibur', NULL, NULL, 'fivers/vs20excalibur.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:39', '2024-08-31 15:33:16'),
(3210, 16, NULL, 'vs20stickywild', 'Wild Bison Charge', 'vs20stickywild', NULL, NULL, 'fivers/vs20stickywild.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:39', '2024-08-31 15:33:16'),
(3211, 16, NULL, 'vs25spotz', 'Knight Hot Spotz', 'vs25spotz', NULL, NULL, 'fivers/vs25spotz.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:40', '2024-08-31 15:33:16'),
(3212, 16, NULL, 'vs15godsofwar', 'Zeus vs Hades - Gods of War', 'vs15godsofwar', 'Slot', NULL, '01JADPCTNAZ35472SREXVH71HN.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'fivers', 0, 1, 1, '2024-07-17 23:07:40', '2024-10-17 13:53:53'),
(3213, 16, NULL, 'vs20clustwild', 'Sticky Bees', 'vs20clustwild', NULL, NULL, 'fivers/vs20clustwild.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:40', '2024-08-31 15:33:16'),
(3214, 16, NULL, 'vs10fdrasbf', 'Floating Dragon - Dragon Boat Festival', 'vs10fdrasbf', NULL, NULL, 'fivers/vs10fdrasbf.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:41', '2024-08-31 15:33:16'),
(3215, 16, NULL, 'vs4096robber', 'Robber Strike', 'vs4096robber', NULL, NULL, 'fivers/vs4096robber.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:41', '2024-08-31 15:33:16'),
(3216, 16, NULL, 'vswaysfrbugs', 'Frogs & Bugs', 'vswaysfrbugs', NULL, NULL, 'fivers/vswaysfrbugs.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:42', '2024-08-31 15:33:16'),
(3217, 16, NULL, 'vs20lampinf', 'Lamp Of Infinity', 'vs20lampinf', NULL, NULL, 'fivers/vs20lampinf.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:42', '2024-08-31 15:33:16'),
(3218, 16, NULL, 'vs20jewelparty', 'Jewel Rush', 'vs20jewelparty', NULL, NULL, 'fivers/vs20jewelparty.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:42', '2024-08-31 15:33:16'),
(3219, 16, NULL, 'vs9outlaw', 'Pirates Pub', 'vs9outlaw', NULL, NULL, 'fivers/vs9outlaw.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:43', '2024-08-31 15:33:16'),
(3220, 16, NULL, 'vs20beefed', 'Fat Panda', 'vs20beefed', NULL, NULL, 'fivers/vs20beefed.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:43', '2024-08-31 15:33:16'),
(3221, 16, NULL, 'vs20procount', 'Wisdom of Athena', 'vs20procount', NULL, NULL, 'fivers/vs20procount.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:44', '2024-08-31 15:33:16'),
(3222, 14, NULL, 'vs10bbextreme', 'Big Bass Amazon Xtreme', 'vs10bbextreme', 'Slot', NULL, '01J31SXKFN7CXYTKPSK1M3EB25.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 1, 1, '2024-07-17 23:07:44', '2024-10-17 13:47:49'),
(3223, 16, NULL, 'vs20hstgldngt', 'Heist for the Golden Nuggets', 'vs20hstgldngt', NULL, NULL, 'fivers/vs20hstgldngt.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:45', '2024-08-31 15:33:16'),
(3224, 16, NULL, 'vs243nudge4gold', 'Hellvis Wild', 'vs243nudge4gold', NULL, NULL, 'fivers/vs243nudge4gold.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:45', '2024-08-31 15:33:16'),
(3225, 16, NULL, 'vs25jokrace', 'Joker Race', 'vs25jokrace', NULL, NULL, 'fivers/vs25jokrace.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:45', '2024-08-31 15:33:16'),
(3226, 16, NULL, 'vs20cashmachine', 'Cash Box', 'vs20cashmachine', NULL, NULL, 'fivers/vs20cashmachine.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:46', '2024-08-31 15:33:16'),
(3227, 16, NULL, 'vs50jucier', 'Sky Bounty', 'vs50jucier', NULL, NULL, 'fivers/vs50jucier.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:46', '2024-08-31 15:33:16'),
(3228, 16, NULL, 'vswayspowzeus', 'Power of Merlin Megaways', 'vswayspowzeus', NULL, NULL, 'fivers/vswayspowzeus.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:47', '2024-08-31 15:33:16'),
(3229, 16, NULL, 'vs20splmystery', 'Spellbinding Mystery', 'vs20splmystery', NULL, NULL, 'fivers/vs20splmystery.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:47', '2024-08-31 15:33:16'),
(3230, 16, NULL, 'vs20starlightx', 'Starlight Princess 1000', 'vs20starlightx', NULL, NULL, 'fivers/vs20starlightx.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:47', '2024-08-31 15:33:16'),
(3231, 16, NULL, 'vs20wildparty', '3 Buzzing Wilds', 'vs20wildparty', 'Slot', NULL, '01J31SVHND6EFZ9AJW5VWPESX9.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 1, 1, '2024-07-17 23:07:48', '2024-10-17 13:48:05'),
(3232, 16, NULL, 'vs50dmdcascade', 'Diamond Cascade', 'vs50dmdcascade', NULL, NULL, 'fivers/vs50dmdcascade.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:48', '2024-08-31 15:33:16'),
(3233, 16, NULL, 'vs20supermania', 'Supermania', 'vs20supermania', NULL, NULL, 'fivers/vs20supermania.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:48', '2024-08-31 15:33:16'),
(3234, 16, NULL, 'vs20lobcrab', 'Lobster Bob\'s Crazy Crab Shack', 'vs20lobcrab', NULL, NULL, 'fivers/vs20lobcrab.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:49', '2024-08-31 15:33:16'),
(3235, 16, NULL, 'vs10trail', 'Mustang Trail', 'vs10trail', NULL, NULL, 'fivers/vs10trail.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:49', '2024-08-31 15:33:16'),
(3236, 16, NULL, 'vswaysrockblst', 'Rocket Blast Megaways', 'vswaysrockblst', NULL, NULL, 'fivers/vswaysrockblst.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:50', '2024-08-31 15:33:16'),
(3237, 16, NULL, 'vs20piggybank', 'Piggy Bankers', 'vs20piggybank', NULL, NULL, 'fivers/vs20piggybank.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:50', '2024-08-31 15:33:16'),
(3238, 16, NULL, 'vs20lvlup', 'Pub Kings', 'vs20lvlup', NULL, NULL, 'fivers/vs20lvlup.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:51', '2024-08-31 15:33:16'),
(3239, 16, NULL, 'vs20forge', 'Forge of Olympus', 'vs20forge', NULL, NULL, 'fivers/vs20forge.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:51', '2024-08-31 15:33:16'),
(3240, 16, NULL, 'vs1024mahjwins', 'Mahjong Wins', 'vs1024mahjwins', NULL, NULL, 'fivers/vs1024mahjwins.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:51', '2024-08-31 15:33:16'),
(3241, 16, NULL, 'vs20earthquake', 'Cyclops Smash', 'vs20earthquake', NULL, NULL, 'fivers/vs20earthquake.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:52', '2024-08-31 15:33:16'),
(3242, 16, NULL, 'vs20saiman', 'Saiyan Mania', 'vs20saiman', NULL, NULL, 'fivers/vs20saiman.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:52', '2024-08-31 15:33:16'),
(3243, 16, NULL, 'vswaysbbhas', 'Big Bass Hold & Spinner Megaways', 'vswaysbbhas', NULL, NULL, 'fivers/vswaysbbhas.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:52', '2024-08-31 15:33:16'),
(3244, 16, NULL, 'vs20yisunshin', 'Yi Sun Shin', 'vs20yisunshin', NULL, NULL, 'fivers/vs20yisunshin.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:52', '2024-08-31 15:33:16'),
(3245, 16, NULL, 'vswaysincwnd', 'Gold Oasis', 'vswaysincwnd', NULL, NULL, 'fivers/vswaysincwnd.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:53', '2024-08-31 15:33:16'),
(3246, 16, NULL, 'vswaysftropics', 'Frozen Tropics', 'vswaysftropics', NULL, NULL, 'fivers/vswaysftropics.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:53', '2024-08-31 15:33:16'),
(3247, 16, NULL, 'vs10gdchalleng', '8 Golden Dragon Challenge', 'vs10gdchalleng', NULL, NULL, 'fivers/vs10gdchalleng.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:53', '2024-08-31 15:33:16'),
(3248, 16, NULL, 'vswaystut', 'Book of Tut Megaways', 'vswaystut', NULL, NULL, 'fivers/vswaystut.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:54', '2024-08-31 15:33:16'),
(3249, 16, NULL, 'vs20gravity', 'Gravity Bonanza', 'vs20gravity', NULL, NULL, 'fivers/vs20gravity.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:54', '2024-08-31 15:33:16'),
(3250, 16, NULL, 'vs40infwild', 'Infective Wild', 'vs40infwild', NULL, NULL, 'fivers/vs40infwild.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:55', '2024-08-31 15:33:16'),
(3251, 16, NULL, 'vs20candyblitz', 'Candy Blitz', 'vs20candyblitz', NULL, NULL, 'fivers/vs20candyblitz.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:55', '2024-08-31 15:33:16'),
(3252, 16, NULL, 'vswaysstrlght', 'Fortunes of Aztec', 'vswaysstrlght', NULL, NULL, 'fivers/vswaysstrlght.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:56', '2024-08-31 15:33:16'),
(3253, 16, NULL, 'vs20maskgame', 'Cash Chips', 'vs20maskgame', NULL, NULL, 'fivers/vs20maskgame.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:56', '2024-08-31 15:33:16'),
(3254, 16, NULL, 'vs5gemstone', 'Gemstone', 'vs5gemstone', NULL, NULL, 'fivers/vs5gemstone.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:56', '2024-08-31 15:33:16'),
(3255, 16, NULL, 'vswaysraghex', 'Tundra\'s Fortune', 'vswaysraghex', NULL, NULL, 'fivers/vswaysraghex.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:57', '2024-08-31 15:33:16'),
(3256, 16, NULL, 'vs40rainbowr', 'Rainbow Reels', 'vs40rainbowr', NULL, NULL, 'fivers/vs40rainbowr.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:57', '2024-08-31 15:33:16'),
(3257, 16, NULL, 'vs20bnnzdice', 'Sweet Bonanza Dice', 'vs20bnnzdice', NULL, NULL, 'fivers/vs20bnnzdice.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:58', '2024-08-31 15:33:16'),
(3258, 16, NULL, 'vs10bhallbnza', 'Big Bass Halloween', 'vs10bhallbnza', NULL, NULL, 'fivers/vs10bhallbnza.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:58', '2024-08-31 15:33:16'),
(3259, 16, NULL, 'vs20dhcluster', 'Twilight Princess', 'vs20dhcluster', NULL, NULL, 'fivers/vs20dhcluster.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:58', '2024-08-31 15:33:16'),
(3260, 16, NULL, 'vs40demonpots', 'Demon Pots ', 'vs40demonpots', NULL, NULL, 'fivers/vs40demonpots.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:58', '2024-08-31 15:33:16'),
(3261, 16, NULL, 'vs243goldfor', '888 Bonanza', 'vs243goldfor', NULL, NULL, 'fivers/vs243goldfor.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:58', '2024-08-31 15:33:16'),
(3262, 16, NULL, 'vswaysmoneyman', 'The Money Men Megaways', 'vswaysmoneyman', NULL, NULL, 'fivers/vswaysmoneyman.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:59', '2024-08-31 15:33:16'),
(3263, 16, NULL, 'vs20olympgrace', 'Grace of Ebisu', 'vs20olympgrace', NULL, NULL, 'fivers/vs20olympgrace.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:59', '2024-08-31 15:33:16'),
(3264, 16, NULL, 'vs20rujakbnz', 'Rujak Bonanza', 'vs20rujakbnz', NULL, NULL, 'fivers/vs20rujakbnz.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:07:59', '2024-08-31 15:33:16'),
(3265, 16, NULL, 'vs20sugarcoins', 'Viking Forge', 'vs20sugarcoins', NULL, NULL, 'fivers/vs20sugarcoins.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:00', '2024-08-31 15:33:16'),
(3266, 16, NULL, 'vs20sugarnudge', 'Sugar Supreme Powernudge', 'vs20sugarnudge', NULL, NULL, 'fivers/vs20sugarnudge.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:00', '2024-08-31 15:33:16'),
(3267, 16, NULL, 'vswayscfglory', 'Chase For Glory', 'vswayscfglory', NULL, NULL, 'fivers/vswayscfglory.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:01', '2024-08-31 15:33:16'),
(3268, 16, NULL, 'vs5jokerdice', 'Joker\'s Jewel Dice', 'vs5jokerdice', NULL, NULL, 'fivers/vs5jokerdice.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:01', '2024-08-31 15:33:16'),
(3269, 16, NULL, 'vswaystimber', 'Timber Stacks', 'vswaystimber', NULL, NULL, 'fivers/vswaystimber.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:02', '2024-08-31 15:33:16'),
(3270, 16, NULL, 'vs10bbsplxmas', 'Big Bass Christmas Bash', 'vs10bbsplxmas', NULL, NULL, 'fivers/vs10bbsplxmas.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:02', '2024-08-31 15:33:16'),
(3271, 16, NULL, 'vs20mahjxbnz', 'Mahjong X', 'vs20mahjxbnz', NULL, NULL, 'fivers/vs20mahjxbnz.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:02', '2024-08-31 15:33:16'),
(3272, 16, NULL, 'vs20nilefort', 'Nile Fortune', 'vs20nilefort', NULL, NULL, 'fivers/vs20nilefort.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:03', '2024-08-31 15:33:16'),
(3273, 16, NULL, 'vs20sugrux', 'Sugar Rush Xmas', 'vs20sugrux', NULL, NULL, NULL, '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:04', '2024-08-31 15:33:16'),
(3274, 16, NULL, 'vswayscharms', '5 Frozen Charms Megaways', 'vswayscharms', NULL, NULL, 'fivers/vswayscharms.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:04', '2024-08-31 15:33:16'),
(3275, 16, NULL, 'vs10ddcbells', 'Ding Dong Christmas Bells', 'vs10ddcbells', NULL, NULL, 'fivers/vs10ddcbells.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:05', '2024-08-31 15:33:16'),
(3276, 16, NULL, 'vs20dhdice', 'The Dog House Dice Show', 'vs20dhdice', NULL, NULL, 'fivers/vs20dhdice.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:05', '2024-08-31 15:33:16'),
(3277, 16, NULL, 'vs20cjcluster', 'Candy Jar Clusters', 'vs20cjcluster', NULL, NULL, NULL, '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:06', '2024-08-31 15:33:16'),
(3278, 16, NULL, 'vswaysseastory', 'Sea Fantasy', 'vswaysseastory', NULL, NULL, NULL, '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:07', '2024-08-31 15:33:16'),
(3279, 16, NULL, 'vswaysstampede', 'Fire Stampede', 'vswaysstampede', NULL, NULL, 'fivers/vswaysstampede.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:07', '2024-08-31 15:33:16'),
(3280, 16, NULL, 'vs20olympx', 'Gates of Olympus 1000', 'vs20olympx', NULL, NULL, 'fivers/vs20olympx.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:08', '2024-08-31 15:33:16'),
(3281, 16, NULL, 'vswayswildgang', 'The Wild Gang', 'vswayswildgang', NULL, NULL, 'fivers/vswayswildgang.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:09', '2024-08-31 15:33:16'),
(3282, 16, NULL, 'vs50jfmulthold', 'Juicy Fruits Multihold', 'vs50jfmulthold', NULL, NULL, 'fivers/vs50jfmulthold.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:09', '2024-08-31 15:33:16'),
(3283, 16, NULL, 'vswaysfltdrgny', 'Floating Dragon New Year Festival Ultra Megaways Hold & Spin', 'vswaysfltdrgny', NULL, NULL, 'fivers/vswaysfltdrgny.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:09', '2024-08-31 15:33:16'),
(3284, 16, NULL, 'vs20laughluck', 'Happy Fortune', 'vs20laughluck', NULL, NULL, 'fivers/vs20laughluck.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:09', '2024-08-31 15:33:16'),
(3285, 16, NULL, 'vs20yotdk', 'Year Of The Dragon King', 'vs20yotdk', NULL, NULL, 'fivers/vs20yotdk.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:10', '2024-08-31 15:33:16'),
(3286, 16, NULL, 'vs10luckfort', 'Good Luck & Good Fortune', 'vs10luckfort', NULL, NULL, 'fivers/vs10luckfort.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:10', '2024-08-31 15:33:16'),
(3287, 16, NULL, 'vswaysexpandng', 'Castle of Fire', 'vswaysexpandng', NULL, NULL, 'fivers/vswaysexpandng.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:10', '2024-08-31 15:33:16'),
(3288, 16, NULL, 'vs243fdragon', 'Fortune Dragon', 'vs243fdragon', NULL, NULL, 'fivers/vs243fdragon.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:11', '2024-08-31 15:33:16'),
(3289, 16, NULL, 'vs20bigdawgs', 'The Big Dawgs', 'vs20bigdawgs', NULL, NULL, 'fivers/vs20bigdawgs.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:11', '2024-08-31 15:33:16'),
(3290, 16, NULL, 'vs20mergedwndw', 'Blade & Fangs', 'vs20mergedwndw', NULL, NULL, 'fivers/vs20mergedwndw.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:11', '2024-08-31 15:33:16'),
(3291, 16, NULL, 'vs20loksriches', 'Loki\'s Riches', 'vs20loksriches', NULL, NULL, 'fivers/vs20loksriches.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:12', '2024-08-31 15:33:16'),
(3292, 16, NULL, 'vs1024mjwinbns', 'Mahjong Wins Bonus', 'vs1024mjwinbns', NULL, NULL, 'fivers/vs1024mjwinbns.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:12', '2024-08-31 15:33:16'),
(3293, 16, NULL, 'vs20treesot', 'Trees of Treasure', 'vs20treesot', NULL, NULL, 'fivers/vs20treesot.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:13', '2024-08-31 15:33:16'),
(3294, 16, NULL, 'vswaysfirewmw', 'Blazing Wilds Megaways', 'vswaysfirewmw', NULL, NULL, 'fivers/vswaysfirewmw.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:13', '2024-08-31 15:33:16'),
(3295, 16, NULL, 'vs1024fortune', 'Fortune Ace', 'vs1024fortune', NULL, NULL, 'fivers/vs1024fortune.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:13', '2024-08-31 15:33:16'),
(3296, 16, NULL, 'vs25lagoon', 'Great Lagoon', 'vs25lagoon', NULL, NULL, 'fivers/vs25lagoon.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:13', '2024-08-31 15:33:16'),
(3297, 16, NULL, 'vs10bbfloats', 'Big Bass Floats my Boat', 'vs10bbfloats', NULL, NULL, 'fivers/vs10bbfloats.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:14', '2024-08-31 15:33:16'),
(3298, 16, NULL, 'vswaysalterego', 'The Alter Ego', 'vswaysalterego', NULL, NULL, 'fivers/vswaysalterego.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:14', '2024-08-31 15:33:16'),
(3299, 16, NULL, 'vs5balidragon', 'Bali Dragon', 'vs5balidragon', NULL, NULL, 'fivers/vs5balidragon.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:14', '2024-08-31 15:33:16'),
(3300, 16, NULL, 'vs20multiup', 'Wheel O\'Gold', 'vs20multiup', NULL, NULL, 'fivers/vs20multiup.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:15', '2024-08-31 15:33:16'),
(3301, 16, NULL, 'vswaysmegareel', 'Pompeii Megareels Megaways', 'vswaysmegareel', NULL, NULL, 'fivers/vswaysmegareel.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:15', '2024-08-31 15:33:16'),
(3302, 16, NULL, 'vs20mmmelon', 'Mighty Munching Melons', 'vs20mmmelon', NULL, NULL, 'fivers/vs20mmmelon.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:15', '2024-08-31 15:33:16'),
(3303, 16, NULL, 'vs10strawberry', 'Strawberry Cocktail', 'vs10strawberry', NULL, NULL, 'fivers/vs10strawberry.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:16', '2024-08-31 15:33:16'),
(3304, 16, NULL, 'vs15seoultrain', 'Train to Seoul', 'vs15seoultrain', NULL, NULL, 'fivers/vs15seoultrain.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:16', '2024-08-31 15:33:16'),
(3305, 16, NULL, 'vs20ninjapower', 'Power of Ninja', 'vs20ninjapower', NULL, NULL, 'fivers/vs20ninjapower.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:16', '2024-08-31 15:33:16'),
(3306, 16, NULL, 'vs20olympdice', 'Gates of Olympus Dice', 'vs20olympdice', NULL, NULL, 'fivers/vs20olympdice.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:16', '2024-08-31 15:33:16'),
(3307, 16, NULL, 'vs20clustext', 'Gears of Horus', 'vs20clustext', NULL, NULL, 'fivers/vs20clustext.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:17', '2024-08-31 15:33:16'),
(3308, 16, NULL, 'vswayscheist', 'Casino Heist Megaways', 'vswayscheist', NULL, NULL, 'fivers/vswayscheist.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:17', '2024-08-31 15:33:16'),
(3309, 16, NULL, 'vs20gatotx', 'Gates of Gatot Kaca 1000', 'vs20gatotx', NULL, NULL, 'fivers/vs20gatotx.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:18', '2024-08-31 15:33:16'),
(3310, 16, NULL, 'vswaysbewaretd', 'Beware The Deep Megaways', 'vswaysbewaretd', NULL, NULL, 'fivers/vswaysbewaretd.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:18', '2024-08-31 15:33:16'),
(3311, 16, NULL, 'vs10bbbnz', 'Big Bass Day at the Races', 'vs10bbbnz', NULL, NULL, 'fivers/vs10bbbnz.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:18', '2024-08-31 15:33:16'),
(3312, 16, NULL, 'vs20stckwldsc', 'Pot of Fortune', 'vs20stckwldsc', NULL, NULL, 'fivers/vs20stckwldsc.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:19', '2024-08-31 15:33:16'),
(3313, 16, NULL, 'vs15samurai4', 'Rise of Samurai 4', 'vs15samurai4', NULL, NULL, 'fivers/vs15samurai4.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:19', '2024-08-31 15:33:16'),
(3314, 16, NULL, 'vs20portals', 'Fire Portals', 'vs20portals', NULL, NULL, 'fivers/vs20portals.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:20', '2024-08-31 15:33:16'),
(3315, 16, NULL, 'vs20sugarrushx', 'Sugar Rush 1000', 'vs20sugarrushx', NULL, NULL, 'fivers/vs20sugarrushx.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:20', '2024-08-31 15:33:16'),
(3316, 16, NULL, 'vs20cbrhst', 'Cyber Heist', 'vs20cbrhst', NULL, NULL, 'fivers/vs20cbrhst.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:20', '2024-08-31 15:33:16'),
(3317, 16, NULL, 'vs20doghouse2', 'The Dog House - Dog or Alive', 'vs20doghouse2', NULL, NULL, 'fivers/vs20doghouse2.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:08:21', '2024-08-31 15:33:16'),
(3318, 16, NULL, 'vs10bburger', 'Big Burger Load it up with Xtra Cheese', 'vs10bburger', NULL, NULL, 'fivers/vs10bburger.png', '0', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:31', '2024-08-31 15:33:16'),
(3319, 17, NULL, 'diaochan', 'Honey Trap of Diao Chan', 'diaochan', NULL, NULL, 'fivers/diaochan.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:32', '2024-07-17 23:09:32'),
(3320, 17, NULL, 'gem-saviour', 'Gem Saviour', 'gem-saviour', NULL, NULL, 'fivers/gem-saviour.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:33', '2024-07-17 23:09:33'),
(3321, 17, NULL, 'fortune-gods', 'Fortune Gods', 'fortune-gods', NULL, NULL, 'fivers/fortune-gods.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:33', '2024-07-17 23:09:33'),
(3322, 17, NULL, 'medusa2', 'Medusa II', 'medusa2', NULL, NULL, 'fivers/medusa2.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:34', '2024-07-17 23:09:34'),
(3323, 17, NULL, 'medusa', 'Medusa', 'medusa', NULL, NULL, 'fivers/medusa.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:34', '2024-07-17 23:09:34'),
(3324, 17, NULL, 'hood-wolf', 'Hood vs Wolf', 'hood-wolf', NULL, NULL, 'fivers/hood-wolf.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:35', '2024-07-17 23:09:35'),
(3325, 17, NULL, 'reel-love', 'Reel Love', 'reel-love', NULL, NULL, 'fivers/reel-love.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:35', '2024-07-17 23:09:35'),
(3326, 17, NULL, 'win-win-won', 'Win Win Won', 'win-win-won', NULL, NULL, 'fivers/win-win-won.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:35', '2024-07-17 23:09:35'),
(3327, 17, NULL, 'plushie-frenzy', 'Plushie Frenzy', 'plushie-frenzy', NULL, NULL, 'fivers/plushie-frenzy.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:36', '2024-07-17 23:09:36'),
(3328, 17, NULL, 'fortune-tree', 'Tree of Fortune', 'fortune-tree', NULL, NULL, 'fivers/fortune-tree.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:36', '2024-07-17 23:09:36'),
(3329, 17, NULL, 'hotpot', 'Hotpot', 'hotpot', NULL, NULL, 'fivers/hotpot.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:37', '2024-07-17 23:09:37'),
(3330, 17, NULL, 'dragon-legend', 'Dragon Legend', 'dragon-legend', NULL, NULL, 'fivers/dragon-legend.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:37', '2024-07-17 23:09:37'),
(3331, 17, NULL, 'hip-hop-panda', 'Hip Hop Panda', 'hip-hop-panda', NULL, NULL, 'fivers/hip-hop-panda.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:38', '2024-07-17 23:09:38'),
(3332, 17, NULL, 'legend-of-hou-yi', 'Legend of Hou Yi', 'legend-of-hou-yi', NULL, NULL, 'fivers/legend-of-hou-yi.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:38', '2024-07-17 23:09:38'),
(3333, 17, NULL, 'mr-hallow-win', 'Mr. Hallow-Win', 'mr-hallow-win', NULL, NULL, 'fivers/mr-hallow-win.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:38', '2024-07-17 23:09:38'),
(3334, 17, NULL, 'prosperity-lion', 'Prosperity Lion', 'prosperity-lion', NULL, NULL, 'fivers/prosperity-lion.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:39', '2024-07-17 23:09:39'),
(3335, 17, NULL, 'santas-gift-rush', 'Santa\'s Gift Rush', 'santas-gift-rush', NULL, NULL, 'fivers/santas-gift-rush.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:40', '2024-07-17 23:09:40'),
(3336, 17, NULL, 'gem-saviour-sword', 'Gem Saviour Sword', 'gem-saviour-sword', NULL, NULL, 'fivers/gem-saviour-sword.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:40', '2024-07-17 23:09:40'),
(3337, 17, NULL, 'piggy-gold', 'Piggy Gold', 'piggy-gold', NULL, NULL, 'fivers/piggy-gold.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:40', '2024-07-17 23:09:40'),
(3338, 17, NULL, 'jungle-delight', 'Jungle Delight', 'jungle-delight', NULL, NULL, 'fivers/jungle-delight.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:41', '2024-07-17 23:09:41'),
(3339, 17, NULL, 'symbols-of-egypt', 'Symbols of Egypt', 'symbols-of-egypt', NULL, NULL, 'fivers/symbols-of-egypt.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:41', '2024-07-17 23:09:41'),
(3340, 17, NULL, 'ganesha-gold', 'Ganesha Gold', 'ganesha-gold', NULL, NULL, 'fivers/ganesha-gold.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:41', '2024-07-17 23:09:41'),
(3341, 17, NULL, 'emperors-favour', 'Emperor\'s Favour', 'emperors-favour', NULL, NULL, 'fivers/emperors-favour.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:42', '2024-07-17 23:09:42'),
(3342, 17, NULL, 'double-fortune', 'Double Fortune', 'double-fortune', NULL, NULL, 'fivers/double-fortune.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:42', '2024-07-17 23:09:42');
INSERT INTO `games` (`id`, `provider_id`, `game_server_url`, `game_id`, `game_name`, `game_code`, `game_type`, `description`, `cover`, `status`, `technology`, `has_lobby`, `is_mobile`, `has_freespins`, `has_tables`, `only_demo`, `rtp`, `distribution`, `views`, `is_featured`, `show_home`, `created_at`, `updated_at`) VALUES
(3343, 17, NULL, 'journey-to-the-wealth', 'Journey to the Wealth', 'journey-to-the-wealth', NULL, NULL, 'fivers/journey-to-the-wealth.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:43', '2024-07-17 23:09:43'),
(3344, 17, NULL, 'the-great-icescape', 'The Great Icescape', 'the-great-icescape', NULL, NULL, 'fivers/the-great-icescape.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:43', '2024-07-17 23:09:43'),
(3345, 17, NULL, 'captains-bounty', 'Captain\'s Bounty', 'captains-bounty', NULL, NULL, 'fivers/captains-bounty.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:44', '2024-07-17 23:09:44'),
(3346, 17, NULL, 'dragon-hatch', 'Dragon Hatch', 'dragon-hatch', NULL, NULL, 'fivers/dragon-hatch.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:44', '2024-07-17 23:09:44'),
(3347, 17, NULL, 'vampires-charm', 'Vampire\'s Charm', 'vampires-charm', NULL, NULL, 'fivers/vampires-charm.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:45', '2024-07-17 23:09:45'),
(3348, 17, NULL, 'ninja-vs-samurai', 'Ninja vs Samurai', 'ninja-vs-samurai', NULL, NULL, 'fivers/ninja-vs-samurai.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:45', '2024-07-17 23:09:45'),
(3349, 17, NULL, 'leprechaun-riches', 'Leprechaun Riches', 'leprechaun-riches', NULL, NULL, 'fivers/leprechaun-riches.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:45', '2024-07-17 23:09:45'),
(3350, 17, NULL, 'flirting-scholar', 'Flirting Scholar', 'flirting-scholar', NULL, NULL, 'fivers/flirting-scholar.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:46', '2024-07-17 23:09:46'),
(3351, 17, NULL, 'gem-saviour-conquest', 'Gem Saviour Conquest', 'gem-saviour-conquest', NULL, NULL, 'fivers/gem-saviour-conquest.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:46', '2024-07-17 23:09:46'),
(3352, 17, NULL, 'dragon-tiger-luck', 'Dragon Tiger Luck', 'dragon-tiger-luck', NULL, NULL, 'fivers/dragon-tiger-luck.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:47', '2024-07-17 23:09:47'),
(3353, 17, NULL, 'muay-thai-champion', 'Muay Thai Champion', 'muay-thai-champion', NULL, NULL, 'fivers/muay-thai-champion.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:47', '2024-07-17 23:09:47'),
(3354, 17, NULL, 'mahjong-ways', 'Mahjong Ways', 'mahjong-ways', NULL, NULL, 'fivers/mahjong-ways.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:48', '2024-07-17 23:09:48'),
(3355, 17, NULL, 'shaolin-soccer', 'Shaolin Soccer', 'shaolin-soccer', NULL, NULL, 'fivers/shaolin-soccer.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:48', '2024-07-17 23:09:48'),
(3356, 17, NULL, 'fortune-mouse', 'Fortune Mouse', 'fortune-mouse', NULL, NULL, 'fivers/fortune-mouse.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:48', '2024-07-17 23:09:48'),
(3357, 17, NULL, 'bikini-paradise', 'Bikini Paradise ', 'bikini-paradise', NULL, NULL, 'fivers/bikini-paradise.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:49', '2024-07-17 23:09:49'),
(3358, 17, NULL, 'candy-burst', 'Candy Burst', 'candy-burst', NULL, NULL, 'fivers/candy-burst.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:50', '2024-07-17 23:09:50'),
(3359, 17, NULL, 'cai-shen-wins', 'Caishen Wins', 'cai-shen-wins', NULL, NULL, 'fivers/cai-shen-wins.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:50', '2024-07-17 23:09:50'),
(3360, 17, NULL, 'egypts-book-mystery', 'Egypt\'s Book of Mystery', 'egypts-book-mystery', NULL, NULL, 'fivers/egypts-book-mystery.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:50', '2024-07-17 23:09:50'),
(3361, 17, NULL, 'mahjong-ways2', 'Mahjong Ways 2', 'mahjong-ways2', NULL, NULL, 'fivers/mahjong-ways2.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:51', '2024-07-17 23:09:51'),
(3362, 17, NULL, 'ganesha-fortune', 'Ganesha Fortune', 'ganesha-fortune', NULL, NULL, 'fivers/ganesha-fortune.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:51', '2024-07-17 23:09:51'),
(3363, 17, NULL, 'dreams-of-macau', 'Dreams of Macau', 'dreams-of-macau', NULL, NULL, 'fivers/dreams-of-macau.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:52', '2024-07-17 23:09:52'),
(3364, 17, NULL, 'circus-delight', 'Circus Delight', 'circus-delight', NULL, NULL, 'fivers/circus-delight.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:52', '2024-07-17 23:09:52'),
(3365, 17, NULL, 'phoenix-rises', 'Phoenix Rises', 'phoenix-rises', NULL, NULL, 'fivers/phoenix-rises.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:53', '2024-07-17 23:09:53'),
(3366, 17, NULL, 'wild-fireworks', 'Wild Fireworks', 'wild-fireworks', NULL, NULL, 'fivers/wild-fireworks.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:53', '2024-07-17 23:09:53'),
(3367, 17, NULL, 'queen-bounty', 'Queen of Bounty ', 'queen-bounty', NULL, NULL, 'fivers/queen-bounty.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:53', '2024-07-17 23:09:53'),
(3368, 17, NULL, 'genies-wishes', 'Genie\'s 3 Wishes', 'genies-wishes', NULL, NULL, 'fivers/genies-wishes.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:54', '2024-07-17 23:09:54'),
(3369, 17, NULL, 'galactic-gems', 'Galactic Gems', 'galactic-gems', NULL, NULL, 'fivers/galactic-gems.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:54', '2024-07-17 23:09:54'),
(3370, 17, NULL, 'treasures-aztec', 'Treasures of Aztec', 'treasures-aztec', NULL, NULL, 'fivers/treasures-aztec.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:55', '2024-07-17 23:09:55'),
(3371, 17, NULL, 'jewels-prosper', 'Jewels of Prosperity', 'jewels-prosper', NULL, NULL, 'fivers/jewels-prosper.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:55', '2024-07-17 23:09:55'),
(3372, 17, NULL, 'lucky-neko', 'Lucky Neko', 'lucky-neko', NULL, NULL, 'fivers/lucky-neko.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:55', '2024-07-17 23:09:55'),
(3373, 17, NULL, 'sct-cleopatra', 'Secrets of Cleopatra', 'sct-cleopatra', NULL, NULL, 'fivers/sct-cleopatra.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:56', '2024-07-17 23:09:56'),
(3374, 17, NULL, 'gdn-ice-fire', 'Guardians of Ice and Fire', 'gdn-ice-fire', NULL, NULL, 'fivers/gdn-ice-fire.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:56', '2024-07-17 23:09:56'),
(3375, 17, NULL, 'thai-river', 'Thai River Wonders', 'thai-river', NULL, NULL, 'fivers/thai-river.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:56', '2024-07-17 23:09:56'),
(3376, 17, NULL, 'opera-dynasty', 'Opera Dynasty', 'opera-dynasty', NULL, NULL, 'fivers/opera-dynasty.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:57', '2024-07-17 23:09:57'),
(3377, 17, NULL, 'bali-vacation', 'Bali Vacation', 'bali-vacation', NULL, NULL, 'fivers/bali-vacation.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:57', '2024-07-17 23:09:57'),
(3378, 17, NULL, 'majestic-ts', 'Majestic Treasures', 'majestic-ts', NULL, NULL, 'fivers/majestic-ts.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:58', '2024-07-17 23:09:58'),
(3379, 17, NULL, 'jack-frosts', 'Jack Frost\'s Winter', 'jack-frosts', NULL, NULL, 'fivers/jack-frosts.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:58', '2024-07-17 23:09:58'),
(3380, 17, NULL, 'fortune-ox', 'Fortune Ox', 'fortune-ox', NULL, NULL, 'fivers/fortune-ox.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:58', '2024-07-17 23:09:58'),
(3381, 17, NULL, 'candy-bonanza', 'Candy Bonanza', 'candy-bonanza', NULL, NULL, 'fivers/candy-bonanza.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:59', '2024-07-17 23:09:59'),
(3382, 17, NULL, 'rise-of-apollo', 'Rise of Apollo', 'rise-of-apollo', NULL, NULL, 'fivers/rise-of-apollo.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:09:59', '2024-07-17 23:09:59'),
(3383, 17, NULL, 'mermaid-riches', 'Mermaid Riches', 'mermaid-riches', NULL, NULL, 'fivers/mermaid-riches.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:00', '2024-07-17 23:10:00'),
(3384, 17, NULL, 'crypto-gold', 'Crypto Gold', 'crypto-gold', NULL, NULL, 'fivers/crypto-gold.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:00', '2024-07-17 23:10:00'),
(3385, 17, NULL, 'wild-bandito', 'Wild Bandito', 'wild-bandito', NULL, NULL, 'fivers/wild-bandito.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:00', '2024-07-17 23:10:00'),
(3386, 17, NULL, 'heist-stakes', 'Heist  Stakes', 'heist-stakes', NULL, NULL, 'fivers/heist-stakes.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:01', '2024-07-17 23:10:01'),
(3387, 17, NULL, 'ways-of-qilin', 'Ways of the Qilin', 'ways-of-qilin', NULL, NULL, 'fivers/ways-of-qilin.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:01', '2024-07-17 23:10:01'),
(3388, 17, NULL, 'lgd-monkey-kg', 'Legendary Monkey King', 'lgd-monkey-kg', NULL, NULL, 'fivers/lgd-monkey-kg.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:02', '2024-07-17 23:10:02'),
(3389, 17, NULL, 'buffalo-win', 'Buffalo Win', 'buffalo-win', NULL, NULL, 'fivers/buffalo-win.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:02', '2024-07-17 23:10:02'),
(3390, 17, NULL, 'jurassic-kdm', 'Jurassic Kingdom', 'jurassic-kdm', NULL, NULL, 'fivers/jurassic-kdm.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:03', '2024-07-17 23:10:03'),
(3391, 17, NULL, 'oriental-pros', 'Oriental Prosperity', 'oriental-pros', NULL, NULL, 'fivers/oriental-pros.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:03', '2024-07-17 23:10:03'),
(3392, 17, NULL, 'crypt-fortune', 'Raider Jane\'s Crypt of Fortune', 'crypt-fortune', NULL, NULL, 'fivers/crypt-fortune.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:03', '2024-07-17 23:10:03'),
(3393, 17, NULL, 'emoji-riches', 'Emoji Riches', 'emoji-riches', NULL, NULL, 'fivers/emoji-riches.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:04', '2024-07-17 23:10:04'),
(3394, 17, NULL, 'sprmkt-spree', 'Supermarket Spree', 'sprmkt-spree', NULL, NULL, 'fivers/sprmkt-spree.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:04', '2024-07-17 23:10:04'),
(3395, 17, NULL, 'cocktail-nite', 'Cocktail Nights', 'cocktail-nite', NULL, NULL, 'fivers/cocktail-nite.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:04', '2024-07-17 23:10:04'),
(3396, 17, NULL, 'mask-carnival', 'Mask Carnival', 'mask-carnival', NULL, NULL, 'fivers/mask-carnival.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:05', '2024-07-17 23:10:05'),
(3397, 17, NULL, 'spirit-wonder', 'Spirited Wonders', 'spirit-wonder', NULL, NULL, 'fivers/spirit-wonder.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:05', '2024-07-17 23:10:05'),
(3398, 17, NULL, 'queen-banquet', 'The Queen\'s Banquet', 'queen-banquet', NULL, NULL, 'fivers/queen-banquet.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:06', '2024-07-17 23:10:06'),
(3399, 17, NULL, 'dest-sun-moon', 'Destiny of Sun & Moon', 'dest-sun-moon', NULL, NULL, 'fivers/dest-sun-moon.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:06', '2024-07-17 23:10:06'),
(3400, 17, NULL, 'garuda-gems', 'Garuda Gems', 'garuda-gems', NULL, NULL, 'fivers/garuda-gems.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:07', '2024-07-17 23:10:07'),
(3401, 17, NULL, 'rooster-rbl', 'Rooster Rumble', 'rooster-rbl', NULL, NULL, 'fivers/rooster-rbl.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:07', '2024-07-17 23:10:07'),
(3402, 17, NULL, 'battleground', 'Battleground Royale', 'battleground', NULL, NULL, 'fivers/battleground.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:07', '2024-07-17 23:10:07'),
(3403, 17, NULL, 'btrfly-blossom', 'Butterfly Blossom', 'btrfly-blossom', NULL, NULL, 'fivers/btrfly-blossom.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:08', '2024-07-17 23:10:08'),
(3404, 17, NULL, 'fortune-tiger', 'Fortune Tiger', 'fortune-tiger', NULL, NULL, 'fivers/fortune-tiger.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:08', '2024-07-17 23:10:08'),
(3405, 17, NULL, 'speed-winner', 'Speed Winner', 'speed-winner', NULL, NULL, 'fivers/speed-winner.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:09', '2024-07-17 23:10:09'),
(3406, 17, NULL, 'legend-perseus', 'Legend of Perseus', 'legend-perseus', NULL, NULL, 'fivers/legend-perseus.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:09', '2024-07-17 23:10:09'),
(3407, 17, NULL, 'win-win-fpc', 'Win Win Fish Prawn Crab', 'win-win-fpc', NULL, NULL, 'fivers/win-win-fpc.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:09', '2024-07-17 23:10:09'),
(3408, 17, NULL, 'lucky-piggy', 'Lucky Piggy', 'lucky-piggy', NULL, NULL, 'fivers/lucky-piggy.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:10', '2024-07-17 23:10:10'),
(3409, 17, NULL, 'wild-coaster', 'Wild Coaster', 'wild-coaster', NULL, NULL, 'fivers/wild-coaster.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:10', '2024-07-17 23:10:10'),
(3410, 17, NULL, 'wild-bounty-sd', 'Wild Bounty Showdown', 'wild-bounty-sd', NULL, NULL, 'fivers/wild-bounty-sd.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:10', '2024-07-17 23:10:10'),
(3411, 17, NULL, 'prosper-ftree', 'Prosperity Fortune Tree', 'prosper-ftree', NULL, NULL, 'fivers/prosper-ftree.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:11', '2024-07-17 23:10:11'),
(3412, 17, NULL, 'totem-wonders', 'Totem Wonders', 'totem-wonders', NULL, NULL, 'fivers/totem-wonders.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:11', '2024-07-17 23:10:11'),
(3413, 17, NULL, 'asgardian-rs', 'Asgardian Rising', 'asgardian-rs', NULL, NULL, 'fivers/asgardian-rs.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:11', '2024-07-17 23:10:11'),
(3414, 17, NULL, 'alchemy-gold', 'Alchemy Gold', 'alchemy-gold', NULL, NULL, 'fivers/alchemy-gold.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:12', '2024-07-17 23:10:12'),
(3415, 17, NULL, 'diner-delights', 'Diner Delights', 'diner-delights', NULL, NULL, 'fivers/diner-delights.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:12', '2024-07-17 23:10:12'),
(3416, 17, NULL, 'hawaiian-tiki', 'Hawaiian Tiki', 'hawaiian-tiki', NULL, NULL, 'fivers/hawaiian-tiki.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:13', '2024-07-17 23:10:13'),
(3417, 17, NULL, 'fruity-candy', 'Fruity Candy', 'fruity-candy', NULL, NULL, 'fivers/fruity-candy.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:13', '2024-07-17 23:10:13'),
(3418, 17, NULL, 'midas-fortune', 'Midas Fortune', 'midas-fortune', NULL, NULL, 'fivers/midas-fortune.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:13', '2024-07-17 23:10:13'),
(3419, 17, NULL, 'bakery-bonanza', 'Bakery Bonanza', 'bakery-bonanza', NULL, NULL, 'fivers/bakery-bonanza.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:14', '2024-07-17 23:10:14'),
(3420, 17, NULL, 'rave-party-fvr', 'Rave Party Fever', 'rave-party-fvr', NULL, NULL, 'fivers/rave-party-fvr.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:14', '2024-07-17 23:10:14'),
(3421, 17, NULL, 'myst-spirits', 'Mystical Spirits', 'myst-spirits', NULL, NULL, 'fivers/myst-spirits.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:15', '2024-07-17 23:10:15'),
(3422, 17, NULL, 'songkran-spl', 'Songkran Splash', 'songkran-spl', NULL, NULL, 'fivers/songkran-spl.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:15', '2024-07-17 23:10:15'),
(3423, 17, NULL, 'dragon-hatch2', 'Dragon Hatch 2', 'dragon-hatch2', NULL, NULL, 'fivers/dragon-hatch2.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:15', '2024-07-17 23:10:15'),
(3424, 17, NULL, 'cruise-royale', 'Cruise Royale', 'cruise-royale', NULL, NULL, 'fivers/cruise-royale.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:16', '2024-07-17 23:10:16'),
(3425, 17, NULL, 'ult-striker', 'Ultimate Striker', 'ult-striker', NULL, NULL, 'fivers/ult-striker.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:16', '2024-07-17 23:10:16'),
(3426, 17, NULL, 'spr-golf-drive', 'Super Golf Drive', 'spr-golf-drive', NULL, NULL, 'fivers/spr-golf-drive.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:17', '2024-07-17 23:10:17'),
(3427, 17, NULL, 'fortune-rabbit', 'Fortune Rabbit', 'fortune-rabbit', NULL, NULL, 'fivers/fortune-rabbit.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:18', '2024-07-17 23:10:18'),
(3428, 17, NULL, 'wild-heist-co', 'Wild Heist Cashout', 'wild-heist-co', NULL, NULL, 'fivers/wild-heist-co.jpg', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:18', '2024-07-17 23:10:18'),
(3429, 17, NULL, 'mafia-mayhem', 'Mafia Mayhem', 'mafia-mayhem', NULL, NULL, 'fivers/mafia-mayhem.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:18', '2024-07-17 23:10:18'),
(3430, 17, NULL, 'safari-wilds', 'Safari Wilds', 'safari-wilds', NULL, NULL, 'fivers/safari-wilds.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:19', '2024-07-17 23:10:19'),
(3431, 17, NULL, 'lucky-clover', 'Lucky Clover Lady', 'lucky-clover', NULL, NULL, 'fivers/lucky-clover.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:20', '2024-07-17 23:10:20'),
(3432, 17, NULL, 'werewolf-hunt', 'Werewolf\'s Hunt', 'werewolf-hunt', NULL, NULL, 'fivers/werewolf-hunt.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:20', '2024-07-17 23:10:20'),
(3433, 17, NULL, 'tsar-treasures', 'Tsar Treasures', 'tsar-treasures', NULL, NULL, 'fivers/tsar-treasures.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:20', '2024-07-17 23:10:20'),
(3434, 17, NULL, 'gemstones-gold', 'Gemstones Gold', 'gemstones-gold', NULL, NULL, 'fivers/gemstones-gold.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:21', '2024-07-17 23:10:21'),
(3435, 17, NULL, 'fortune-dragon', 'Fortune Dragon', 'fortune-dragon', NULL, NULL, 'fivers/fortune-dragon.png', '1', 'html5', 0, 0, 0, 0, 0, 90, 'worldslot', 0, 0, 0, '2024-07-17 23:10:21', '2024-07-17 23:10:21');

-- --------------------------------------------------------

--
-- Estrutura para tabela `games_keys`
--

CREATE TABLE `games_keys` (
  `id` bigint UNSIGNED NOT NULL,
  `merchant_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `merchant_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `merchant_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agent_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agent_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agent_secret_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_endpoint` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salsa_base_uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salsa_pn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salsa_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `vibra_site_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vibra_game_mode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `worldslot_agent_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `worldslot_agent_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `worldslot_agent_secret_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `worldslot_api_endpoint` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'https://api.worldslotgame.com/api/v2/',
  `games2_agent_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `games2_agent_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `games2_agent_secret_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `games2_api_endpoint` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'api.games2api.xyz',
  `evergame_agent_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `evergame_agent_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `evergame_api_endpoint` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `venix_agent_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `venix_agent_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `venix_agent_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pig_agent_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pig_agent_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pig_agent_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `play_gaming_hall` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `play_gaming_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `play_gaming_login` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `games_keys`
--

INSERT INTO `games_keys` (`id`, `merchant_url`, `merchant_id`, `merchant_key`, `agent_code`, `agent_token`, `agent_secret_key`, `api_endpoint`, `salsa_base_uri`, `salsa_pn`, `salsa_key`, `created_at`, `updated_at`, `vibra_site_id`, `vibra_game_mode`, `worldslot_agent_code`, `worldslot_agent_token`, `worldslot_agent_secret_key`, `worldslot_api_endpoint`, `games2_agent_code`, `games2_agent_token`, `games2_agent_secret_key`, `games2_api_endpoint`, `evergame_agent_code`, `evergame_agent_token`, `evergame_api_endpoint`, `venix_agent_code`, `venix_agent_token`, `venix_agent_secret`, `pig_agent_code`, `pig_agent_token`, `pig_agent_secret`, `play_gaming_hall`, `play_gaming_key`, `play_gaming_login`) VALUES
(1, 'https://gis.slotegrator.com/api/index.php/v1', NULL, NULL, '', '', NULL, 'https://api.apisemggrprag.xyz', NULL, NULL, NULL, '2023-11-30 18:03:08', '2025-03-28 20:15:25', NULL, NULL, '', '', '', 'https://api.tigridy.com/api/v2/', '', '', '', 'https://api.pgsoft-gaming.co/api/v1/', '', '', 'https://m.pgsoft-games.xyz/api/v1/game_launch', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `game_favorites`
--

CREATE TABLE `game_favorites` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `game_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=FIXED;

--
-- Despejando dados para a tabela `game_favorites`
--

INSERT INTO `game_favorites` (`id`, `user_id`, `game_id`, `created_at`, `updated_at`) VALUES
(1, 158, 2869, '2024-03-25 12:42:13', '2024-03-25 12:42:13'),
(2, 174, 1797, '2024-03-25 20:05:28', '2024-03-25 20:05:28'),
(3, 195, 1821, '2024-03-26 12:52:40', '2024-03-26 12:52:40'),
(4, 214, 1821, '2024-03-26 23:20:38', '2024-03-26 23:20:38'),
(5, 218, 1797, '2024-03-27 11:46:23', '2024-03-27 11:46:23'),
(6, 184, 1797, '2024-03-28 13:23:02', '2024-03-28 13:23:02'),
(8, 277, 2869, '2024-03-30 00:13:31', '2024-03-30 00:13:31'),
(9, 277, 1821, '2024-03-30 00:20:00', '2024-03-30 00:20:00');

-- --------------------------------------------------------

--
-- Estrutura para tabela `game_likes`
--

CREATE TABLE `game_likes` (
  `user_id` bigint UNSIGNED NOT NULL,
  `game_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=FIXED;

--
-- Despejando dados para a tabela `game_likes`
--

INSERT INTO `game_likes` (`user_id`, `game_id`, `created_at`, `updated_at`) VALUES
(158, 2869, '2024-03-25 12:42:12', '2024-03-25 12:42:12'),
(174, 1797, '2024-03-25 20:05:27', '2024-03-25 20:05:27'),
(195, 1821, '2024-03-26 12:52:39', '2024-03-26 12:52:39'),
(206, 1821, '2024-03-26 14:24:08', '2024-03-26 14:24:08'),
(211, 2869, '2024-03-26 18:56:30', '2024-03-26 18:56:30'),
(214, 1821, '2024-03-26 23:20:37', '2024-03-26 23:20:37'),
(218, 1797, '2024-03-27 11:46:24', '2024-03-27 11:46:24'),
(228, 1821, '2024-03-27 15:31:53', '2024-03-27 15:31:53'),
(184, 1797, '2024-03-28 13:23:01', '2024-03-28 13:23:01'),
(277, 2869, '2024-03-30 00:13:28', '2024-03-30 00:13:28'),
(277, 1821, '2024-03-30 00:20:01', '2024-03-30 00:20:01');

-- --------------------------------------------------------

--
-- Estrutura para tabela `game_reviews`
--

CREATE TABLE `game_reviews` (
  `user_id` bigint UNSIGNED NOT NULL,
  `game_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `gateways`
--

CREATE TABLE `gateways` (
  `id` bigint UNSIGNED NOT NULL,
  `suitpay_uri` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `suitpay_cliente_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `suitpay_cliente_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_production` tinyint DEFAULT '0',
  `stripe_public_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_secret_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_webhook_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bspay_uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bspay_cliente_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bspay_cliente_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `digitopay_uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `digitopay_cliente_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `digitopay_cliente_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `public_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `private_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `gateways`
--

INSERT INTO `gateways` (`id`, `suitpay_uri`, `suitpay_cliente_id`, `suitpay_cliente_secret`, `stripe_production`, `stripe_public_key`, `stripe_secret_key`, `stripe_webhook_key`, `bspay_uri`, `bspay_cliente_id`, `bspay_cliente_secret`, `created_at`, `updated_at`, `digitopay_uri`, `digitopay_cliente_id`, `digitopay_cliente_secret`, `public_key`, `private_key`) VALUES
(1, 'https://api.pixupbr.com/v2/', '.', '.', 0, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-18 19:19:25', '2025-07-18 10:24:51', '', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `ggds_spin_config`
--

CREATE TABLE `ggds_spin_config` (
  `id` bigint UNSIGNED NOT NULL,
  `prizes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Despejando dados para a tabela `ggds_spin_config`
--

INSERT INTO `ggds_spin_config` (`id`, `prizes`, `created_at`, `updated_at`) VALUES
(1, '[{\"currency\":\"BRL\",\"value\":5},{\"currency\":\"BRL\",\"value\":10},{\"currency\":\"BRL\",\"value\":25},{\"currency\":\"BRL\",\"value\":30},{\"currency\":\"BRL\",\"value\":40},{\"currency\":\"BRL\",\"value\":50},{\"currency\":\"BRL\",\"value\":90},{\"currency\":\"BRL\",\"value\":100},{\"currency\":\"BRL\",\"value\":140},{\"currency\":\"BRL\",\"value\":15},{\"currency\":\"BRL\",\"value\":30},{\"currency\":\"BRL\",\"value\":500},{\"currency\":\"BRL\",\"value\":1000},{\"currency\":\"BRL\",\"value\":1500},{\"currency\":\"BRL\",\"value\":2000},{\"currency\":\"BRL\",\"value\":2500}]', '2024-01-11 20:52:59', '2024-01-14 17:07:12');

-- --------------------------------------------------------

--
-- Estrutura para tabela `ggds_spin_runs`
--

CREATE TABLE `ggds_spin_runs` (
  `id` bigint UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nonce` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `possibilities` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `prize` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Despejando dados para a tabela `ggds_spin_runs`
--

INSERT INTO `ggds_spin_runs` (`id`, `key`, `nonce`, `possibilities`, `prize`, `created_at`, `updated_at`) VALUES
(1, 'bccec5b62ab37e996470f8bb36ff83ea127a73f17f31cba275453f5ed7b24c34', '592f4304-4837-4a81-8f27-6c3ac412c7dc', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":2000}', '2024-01-12 15:49:28', '2024-01-12 15:49:28'),
(2, '93f0c422ecb15337d358cca690529c9db7d9b7a52acc0727092b938ade4e1c9b', 'eff5d8c3-475b-4994-a49d-778cf06aebf4', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":25}', '2024-01-12 15:51:01', '2024-01-12 15:51:01'),
(3, 'c7f0b2cc871954aa3a03f680969f029034d111e5550ee0769389fefe3fd6f9fd', '203098ef-3347-4938-813e-91be82891cbc', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":105}', '2024-01-12 15:51:34', '2024-01-12 15:51:34'),
(4, '5b4059c88237be6a78ff1fb35e427fd1e4e1a30184ced8d3e4ed9044a0939663', '65cf85de-3dee-48f4-a1d3-d26a8f89ba16', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":2000}', '2024-01-12 16:56:56', '2024-01-12 16:56:56'),
(5, '0901814bf6598c5c7e1072abcc8fa16290dff49b3c2aa44a9346cee34444f98f', '79519214-2125-4ed5-a672-45973c8af5eb', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":2500}', '2024-01-12 16:57:47', '2024-01-12 16:57:47'),
(6, '7b5642d63b3081907a3b7489794ba74f3052fe490095e7354d98570f6c4e5a6c', 'e5b728db-07e3-4531-910b-7c85f1555973', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":9.79}', '2024-01-12 18:51:25', '2024-01-12 18:51:25'),
(7, '001f8f60f30e431a9f28d39a4db43e0b3e03d0379816fe04ff5007aca5d0a14e', '4ab2acba-57f3-46f4-9dc6-c32e993fb995', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":1500}', '2024-01-12 19:13:25', '2024-01-12 19:13:25'),
(8, '8a801a13e786df312b4d3a2a023b5472cfca776b2b9524af3c12fac4e00bb935', 'e050a5ad-ab8a-4922-95cc-6fae7f62be99', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":2500}', '2024-01-12 19:40:12', '2024-01-12 19:40:12'),
(9, '3432d11c1efd935afcf84fba6c3466c3c98aee06c63163368a18b7d07749ea66', 'de330a3f-b3d0-41ef-94ae-2cee7686f341', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":15}', '2024-01-12 20:01:33', '2024-01-12 20:01:33'),
(10, 'cf741c182225f003f16fb815517a3d94d9cde7e16d767766864c7536ae51e101', 'ec3a409c-159f-4723-848c-7a45fe838c65', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":105}', '2024-01-12 20:26:04', '2024-01-12 20:26:04'),
(11, 'f7a528bd425441c09093c146b4456acc0391b2aaf6af26ed7282dd8b153411df', 'b9e39a17-328e-4730-979f-bd37714552f1', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":5.02}', '2024-01-13 01:02:21', '2024-01-13 01:02:21'),
(12, '7ec6e7dea1750162832a02bbcb986e3a77e4ea3ece5110b0c8c746e9ab586d27', '876d2835-b5c5-4c2f-997d-007fa566d356', '[{\"currency\":\"brl\",\"value\":5.02},{\"currency\":\"brl\",\"value\":9.79},{\"currency\":\"brl\",\"value\":25},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":40},{\"currency\":\"brl\",\"value\":50},{\"currency\":\"brl\",\"value\":90},{\"currency\":\"brl\",\"value\":105},{\"currency\":\"brl\",\"value\":140},{\"currency\":\"brl\",\"value\":15},{\"currency\":\"brl\",\"value\":30},{\"currency\":\"brl\",\"value\":500},{\"currency\":\"brl\",\"value\":980},{\"currency\":\"brl\",\"value\":1500},{\"currency\":\"brl\",\"value\":2000},{\"currency\":\"brl\",\"value\":2500}]', '{\"currency\":\"brl\",\"value\":980}', '2024-01-13 13:40:26', '2024-01-13 13:40:26'),
(13, '7980558afa73f95c09d898c3f40a488de06097822831729b21659e6e330d6f92', '19962ee0-52f1-45dd-b858-4003deb2eb43', '[{\"currency\":\"BRL\",\"value\":5},{\"currency\":\"BRL\",\"value\":10},{\"currency\":\"BRL\",\"value\":25},{\"currency\":\"BRL\",\"value\":30},{\"currency\":\"BRL\",\"value\":40},{\"currency\":\"BRL\",\"value\":50},{\"currency\":\"BRL\",\"value\":90},{\"currency\":\"BRL\",\"value\":100},{\"currency\":\"BRL\",\"value\":140},{\"currency\":\"BRL\",\"value\":15},{\"currency\":\"BRL\",\"value\":30},{\"currency\":\"BRL\",\"value\":500},{\"currency\":\"BRL\",\"value\":1000},{\"currency\":\"BRL\",\"value\":1500},{\"currency\":\"BRL\",\"value\":2000},{\"currency\":\"BRL\",\"value\":2500}]', '{\"currency\":\"BRL\",\"value\":30}', '2024-01-15 19:28:00', '2024-01-15 19:28:00');

-- --------------------------------------------------------

--
-- Estrutura para tabela `ggr_games`
--

CREATE TABLE `ggr_games` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `game` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance_bet` decimal(20,2) NOT NULL DEFAULT '0.00',
  `balance_win` decimal(20,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `aggregator` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fivers',
  `type` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'loss',
  `operation_id` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change_bonus` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance_loss` decimal(15,2) NOT NULL DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ggr_games_fivers`
--

CREATE TABLE `ggr_games_fivers` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `game` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance_bet` decimal(20,2) NOT NULL DEFAULT '0.00',
  `balance_win` decimal(20,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ggr_games_world_slots`
--

CREATE TABLE `ggr_games_world_slots` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `game` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance_bet` decimal(20,2) NOT NULL DEFAULT '0.00',
  `balance_win` decimal(20,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRL',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `likes`
--

CREATE TABLE `likes` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `liked_user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=FIXED;

--
-- Despejando dados para a tabela `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `liked_user_id`, `created_at`, `updated_at`) VALUES
(1, 31, 31, '2024-02-16 14:49:20', '2024-02-16 14:49:20'),
(2, 95, 95, '2024-03-23 12:58:07', '2024-03-23 12:58:07');

-- --------------------------------------------------------

--
-- Estrutura para tabela `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0000_00_00_000000_create_websockets_statistics_entries_table', 1),
(2, '2014_10_12_000000_create_users_table', 1),
(3, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(15, '2023_10_30_034921_create_settings_table', 6),
(7, '2023_11_03_205251_create_sport_categories_table', 1),
(8, '2023_11_03_205252_create_sports_table', 1),
(10, '2023_11_04_001342_create_sport_events_table', 2),
(11, '2023_11_04_213841_add_fields_to_users_table', 3),
(12, '2023_11_07_202919_create_currencies_table', 4),
(13, '2023_11_07_210310_create_wallets_table', 5),
(16, '2023_11_07_214236_create_withdrawals_table', 7),
(17, '2023_11_07_214240_create_deposits_table', 7),
(18, '2023_11_07_214244_create_orders_table', 7),
(19, '2023_11_07_214708_create_suit_pay_payments_table', 7),
(20, '2023_11_07_215204_create_notifications_table', 8),
(21, '2023_11_07_202919_create_currency_alloweds_table', 9),
(22, '2023_11_11_205824_create_casino_categories_table', 9),
(23, '2023_11_11_205834_create_casino_providers_table', 9),
(24, '2023_11_11_205938_create_casino_games_slotgrators_table', 9),
(25, '2023_11_11_210018_create_casino_games_kscinuses_table', 9),
(26, '2023_11_12_225424_create_transactions_table', 10),
(27, '2023_11_12_225431_create_affiliate_histories_table', 10),
(28, '2023_11_12_234643_add_field_to_wallet_table', 11),
(29, '2023_11_14_203632_create_likes_table', 12),
(30, '2023_09_27_214903_create_wallet_changes_table', 13),
(31, '2023_11_16_155140_create_permission_tables', 14),
(32, '2023_11_17_012533_add_language_to_users_table', 15),
(33, '2023_11_22_171616_create_football_leagues_table', 16),
(34, '2023_11_22_175530_create_football_venues_table', 17),
(35, '2023_11_22_175547_create_football_teams_table', 17),
(36, '2023_11_23_143637_create_football_events_table', 18),
(38, '2023_11_29_134520_create_sport_bets_table', 19),
(39, '2023_11_29_135451_create_sport_bets_odds_table', 19),
(40, '2023_11_30_195548_create_gateways_table', 20),
(41, '2023_11_30_195557_create_games_keys_table', 20),
(42, '2023_11_30_195609_create_setting_mails_table', 20),
(43, '2023_10_08_111755_add_fields_to_game_exclusives_table', 20),
(44, '2023_10_07_183921_create_game_exclusives_table', 21),
(45, '2023_10_11_144956_create_system_wallets_table', 22),
(46, '2023_12_18_172721_create_banners_table', 23),
(47, '2023_12_20_135908_create_casino_games_salsas_table', 24),
(48, '2023_12_23_224032_create_fivers_providers_table', 25),
(49, '2023_12_23_224105_create_fivers_games_table', 25),
(50, '2023_12_31_121453_create_custom_layouts_table', 26),
(51, '2024_01_01_193712_create_g_g_r_games_fivers_table', 27),
(52, '2024_01_14_155144_create_missions_table', 28),
(53, '2024_01_14_155150_create_mission_users_table', 28),
(54, '2024_01_19_120728_create_ka_gamings_table', 29),
(55, '2024_01_19_170650_create_categories_table', 30),
(56, '2024_01_19_170657_create_providers_table', 30),
(57, '2024_01_19_170658_create_games_table', 31),
(58, '2023_10_07_183920_create_categories_table', 32),
(59, '2023_10_07_183921_create_providers_table', 33),
(60, '2023_10_07_183922_create_games_table', 34),
(61, '2024_01_20_144529_create_category_games_table', 35),
(62, '2024_01_20_182155_add_vibra_to_games_keys_table', 36),
(63, '2024_01_21_173742_create_game_favorites_table', 37),
(64, '2024_01_21_173752_create_game_likes_table', 37),
(65, '2024_01_21_173803_create_game_reviews_table', 37),
(66, '2024_01_11_231932_create_vibra_casino_games_table', 38),
(69, '2024_01_28_194456_add_vip_to_wallet_table', 40),
(68, '2024_01_28_194645_create_vips_table', 39),
(70, '2024_01_28_231843_create_vip_users_table', 41),
(71, '2024_01_29_102939_add_paid_to_limits_table', 41),
(72, '2024_01_10_001705_create_sub_affiliates_table', 42),
(73, '2024_01_30_120547_create_affiliate_withdraws_table', 43),
(74, '2024_02_09_233936_add_worldslot_to_games_keys_table', 44),
(75, '2024_02_10_191215_add_disable_spin_to_settings_table', 45),
(76, '2024_02_17_210822_add_games2_to_games_keys_table', 46),
(78, '2024_02_20_004853_add_sub_to_settings_table', 47),
(79, '2024_02_24_121146_add_header_to_custom_layouts_table', 48),
(80, '2024_02_26_144235_create_ggr_games_world_slots_table', 49);

-- --------------------------------------------------------

--
-- Estrutura para tabela `missions`
--

CREATE TABLE `missions` (
  `id` bigint UNSIGNED NOT NULL,
  `challenge_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `challenge_description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `challenge_rules` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `challenge_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'game',
  `challenge_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `challenge_start_date` datetime NOT NULL,
  `challenge_end_date` datetime NOT NULL,
  `challenge_bonus` decimal(20,2) NOT NULL DEFAULT '0.00',
  `challenge_total` bigint NOT NULL DEFAULT '1',
  `challenge_currency` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `challenge_provider` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `challenge_gameid` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `missions`
--

INSERT INTO `missions` (`id`, `challenge_name`, `challenge_description`, `challenge_rules`, `challenge_type`, `challenge_link`, `challenge_start_date`, `challenge_end_date`, `challenge_bonus`, `challenge_total`, `challenge_currency`, `challenge_provider`, `challenge_gameid`, `created_at`, `updated_at`) VALUES
(1, 'Mestre da Roda', '<p>&nbsp;Sequência de vitórias de 3 rodadas na Roda com apostas maiores que R$ 1.00.</p><p><br>&nbsp;</p>', '<p>Sequência de vitórias de 3 rodadas na Roda com apostas maiores que R$ 1.00.</p>', 'game', NULL, '2024-01-26 20:38:25', '2024-01-27 20:38:29', 20.00, 3, 'BRL', NULL, NULL, '2024-01-14 20:38:49', '2024-01-26 22:28:34'),
(2, 'Jogue 3 jogos Slots', '<p>Escolha 3 jogos slots para jogar</p>', '<p>&nbsp;Escolha 3 jogos slots para jogar&nbsp;</p>', 'game', NULL, '2024-01-26 20:39:42', '2024-01-27 20:39:47', 50.00, 3, 'BRL', NULL, NULL, '2024-01-14 20:40:00', '2024-01-26 22:29:09'),
(3, 'Jogos da Fortuna', '<p>&nbsp;<strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p><p><br><br></p>', '<p>&nbsp;<strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p><p><br><br></p>', 'game', NULL, '2024-01-26 18:57:20', '2024-01-27 18:57:26', 150.00, 3, 'BRL', '9', 'fortune', '2024-01-15 18:57:31', '2024-01-26 22:29:37');

-- --------------------------------------------------------

--
-- Estrutura para tabela `mission_users`
--

CREATE TABLE `mission_users` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `mission_id` int UNSIGNED NOT NULL,
  `rounds` bigint DEFAULT '0',
  `rewards` decimal(10,2) DEFAULT '0.00',
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=FIXED;

--
-- Despejando dados para a tabela `mission_users`
--

INSERT INTO `mission_users` (`id`, `user_id`, `mission_id`, `rounds`, `rewards`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 0, 0.00, 0, '2024-01-15 19:20:10', '2024-01-15 19:20:10');

-- --------------------------------------------------------

--
-- Estrutura para tabela `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estrutura para tabela `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Despejando dados para a tabela `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 10),
(2, 'App\\Models\\User', 16),
(2, 'App\\Models\\User', 40),
(2, 'App\\Models\\User', 51),
(2, 'App\\Models\\User', 52),
(2, 'App\\Models\\User', 54),
(2, 'App\\Models\\User', 55),
(2, 'App\\Models\\User', 56),
(2, 'App\\Models\\User', 57),
(2, 'App\\Models\\User', 59),
(2, 'App\\Models\\User', 60),
(2, 'App\\Models\\User', 62),
(2, 'App\\Models\\User', 63),
(2, 'App\\Models\\User', 64),
(2, 'App\\Models\\User', 65),
(2, 'App\\Models\\User', 67),
(2, 'App\\Models\\User', 69),
(2, 'App\\Models\\User', 70),
(2, 'App\\Models\\User', 72),
(2, 'App\\Models\\User', 74),
(2, 'App\\Models\\User', 76),
(2, 'App\\Models\\User', 82),
(2, 'App\\Models\\User', 84),
(2, 'App\\Models\\User', 95),
(2, 'App\\Models\\User', 99),
(2, 'App\\Models\\User', 156),
(2, 'App\\Models\\User', 158),
(2, 'App\\Models\\User', 167),
(2, 'App\\Models\\User', 193),
(2, 'App\\Models\\User', 199),
(2, 'App\\Models\\User', 209),
(2, 'App\\Models\\User', 229),
(2, 'App\\Models\\User', 243),
(2, 'App\\Models\\User', 265),
(2, 'App\\Models\\User', 266),
(2, 'App\\Models\\User', 272),
(2, 'App\\Models\\User', 295),
(2, 'App\\Models\\User', 300),
(2, 'App\\Models\\User', 304),
(2, 'App\\Models\\User', 309),
(2, 'App\\Models\\User', 310),
(2, 'App\\Models\\User', 99882156),
(2, 'App\\Models\\User', 248939439),
(2, 'App\\Models\\User', 394396228),
(2, 'App\\Models\\User', 613828057),
(2, 'App\\Models\\User', 696497212),
(2, 'App\\Models\\User', 789371170);

-- --------------------------------------------------------

--
-- Estrutura para tabela `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `session_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `game` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `game_uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_money` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `providers` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `refunded` tinyint NOT NULL DEFAULT '0',
  `status` tinyint NOT NULL DEFAULT '0',
  `round_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Despejando dados para a tabela `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'games-exclusive-edit', 'web', '2023-10-12 16:23:45', '2023-10-12 18:12:28'),
(2, 'games-exclusive-view', 'web', '2023-10-12 16:23:56', '2023-10-12 18:11:25'),
(3, 'games-exclusive-create', 'web', '2023-10-12 16:25:06', '2023-10-12 18:11:10'),
(4, 'admin-view', 'web', '2023-10-12 17:56:35', '2023-10-12 17:56:35'),
(5, 'admin-create', 'web', '2023-10-12 18:56:02', '2023-10-12 18:56:02'),
(6, 'admin-edit', 'web', '2023-10-12 18:56:27', '2023-10-12 18:56:27'),
(7, 'admin-delete', 'web', '2023-10-12 18:56:55', '2023-10-12 18:56:55'),
(8, 'category-view', 'web', '2023-10-12 19:01:31', '2023-10-12 19:01:31'),
(9, 'category-create', 'web', '2023-10-12 19:01:46', '2023-10-12 19:01:46'),
(10, 'category-edit', 'web', '2023-10-12 19:01:59', '2023-10-12 19:01:59'),
(11, 'category-delete', 'web', '2023-10-12 19:02:09', '2023-10-12 19:02:09'),
(12, 'game-view', 'web', '2023-10-12 19:02:27', '2023-10-12 19:02:27'),
(13, 'game-create', 'web', '2023-10-12 19:02:36', '2023-10-12 19:02:36'),
(14, 'game-edit', 'web', '2023-10-12 19:02:44', '2023-10-12 19:02:44'),
(15, 'game-delete', 'web', '2023-10-12 19:02:54', '2023-10-12 19:02:54'),
(16, 'wallet-view', 'web', '2023-10-12 19:05:49', '2023-10-12 19:05:49'),
(17, 'wallet-create', 'web', '2023-10-12 19:06:01', '2023-10-12 19:06:01'),
(18, 'wallet-edit', 'web', '2023-10-12 19:06:11', '2023-10-12 19:06:11'),
(19, 'wallet-delete', 'web', '2023-10-12 19:06:18', '2023-10-12 19:06:18'),
(20, 'deposit-view', 'web', '2023-10-12 19:06:44', '2023-10-12 19:06:44'),
(21, 'deposit-create', 'web', '2023-10-12 19:06:56', '2023-10-12 19:06:56'),
(22, 'deposit-edit', 'web', '2023-10-12 19:07:05', '2023-10-12 19:07:05'),
(23, 'deposit-update', 'web', '2023-10-12 19:08:00', '2023-10-12 19:08:00'),
(24, 'deposit-delete', 'web', '2023-10-12 19:08:11', '2023-10-12 19:08:11'),
(25, 'withdrawal-view', 'web', '2023-10-12 19:09:31', '2023-10-12 19:09:31'),
(26, 'withdrawal-create', 'web', '2023-10-12 19:09:40', '2023-10-12 19:09:40'),
(27, 'withdrawal-edit', 'web', '2023-10-12 19:09:51', '2023-10-12 19:09:51'),
(28, 'withdrawal-update', 'web', '2023-10-12 19:10:00', '2023-10-12 19:10:00'),
(29, 'withdrawal-delete', 'web', '2023-10-12 19:10:09', '2023-10-12 19:10:09'),
(30, 'order-view', 'web', '2023-10-12 19:12:36', '2023-10-12 19:12:36'),
(31, 'order-create', 'web', '2023-10-12 19:12:47', '2023-10-12 19:12:47'),
(32, 'order-edit', 'web', '2023-10-12 19:12:56', '2023-10-12 19:12:56'),
(33, 'order-update', 'web', '2023-10-12 19:13:06', '2023-10-12 19:13:06'),
(34, 'order-delete', 'web', '2023-10-12 19:13:19', '2023-10-12 19:13:19'),
(35, 'admin-menu-view', 'web', '2023-10-12 20:26:06', '2023-10-12 20:26:06'),
(36, 'setting-view', 'web', '2023-10-12 21:25:46', '2023-10-12 21:25:46'),
(37, 'setting-create', 'web', '2023-10-12 21:25:57', '2023-10-12 21:25:57'),
(38, 'setting-edit', 'web', '2023-10-12 21:26:06', '2023-10-12 21:26:06'),
(39, 'setting-update', 'web', '2023-10-12 21:26:19', '2023-10-12 21:26:19'),
(40, 'setting-delete', 'web', '2023-10-12 21:26:33', '2023-10-12 21:26:33');

-- --------------------------------------------------------

--
-- Estrutura para tabela `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pix_accounts`
--

CREATE TABLE `pix_accounts` (
  `id` int NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('document','phoneNumber','email') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `pix_accounts`
--

INSERT INTO `pix_accounts` (`id`, `user_id`, `name`, `cpf`, `email`, `phone`, `type`, `created_at`, `updated_at`) VALUES
(15, 1, 'Garanty', NULL, NULL, '31999323232', 'phoneNumber', '2025-02-22 16:00:51', '2025-02-22 16:00:51');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pix_complaints`
--

CREATE TABLE `pix_complaints` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `pix_account` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `complaint` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_deposito` date NOT NULL,
  `status` enum('pendente','resolvido','recusado') COLLATE utf8mb4_unicode_ci DEFAULT 'pendente',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `providers`
--

CREATE TABLE `providers` (
  `id` bigint UNSIGNED NOT NULL,
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `rtp` bigint DEFAULT '90',
  `views` bigint DEFAULT '1',
  `distribution` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `ggr_clone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ggr_official` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `providers`
--

INSERT INTO `providers` (`id`, `cover`, `code`, `name`, `status`, `rtp`, `views`, `distribution`, `created_at`, `updated_at`, `ggr_clone`, `ggr_official`) VALUES
(1, NULL, 'Big_Casino', 'Big', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(2, NULL, 'Dream_Casino', 'Dream', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(3, NULL, 'Evolution_Casino', 'Evolution', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(4, NULL, 'Ezugi_Casino', 'Ezugi', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(5, NULL, 'Micro_Casino', 'Micro', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(6, NULL, 'Booongo_Slot', 'Booongo', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(7, NULL, 'CQ9_Slot', 'CQ9', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(8, NULL, 'DreamTech_Slot', 'DreamTech', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(9, NULL, 'Evoplay_Slot', 'Evoplay', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(10, NULL, 'Habanero_Slot', 'Habanero', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(11, NULL, 'PGSoft_Slot', 'PGSoft', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(12, NULL, 'Playson_Slot', 'Playson', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(13, NULL, 'Pragmatic_Slot', 'Pragmatic', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(14, NULL, 'PRAGMATIC', 'ReelKingDom', 1, 80, 1, 'worldslot', '2024-03-08 21:26:06', '2024-07-17 23:14:10', NULL, NULL),
(15, NULL, 'TopTrend_Slot', 'TopTrend', 1, 80, 1, 'evergame', '2024-03-08 21:26:06', '2024-03-08 21:26:06', NULL, NULL),
(16, NULL, 'PRAGMATIC', 'PragmaticPlay', 1, 90, 1, 'worldslot', '2024-07-17 23:05:20', '2024-07-17 23:05:20', NULL, NULL),
(17, NULL, 'PGSOFT', 'PGSoft', 1, 90, 1, 'worldslot', '2024-07-17 23:05:20', '2024-07-17 23:05:20', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Despejando dados para a tabela `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2023-10-12 16:20:41', '2023-10-12 16:20:41'),
(2, 'afiliado', 'web', '2023-10-12 16:21:08', '2023-10-12 16:21:08');

-- --------------------------------------------------------

--
-- Estrutura para tabela `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estrutura para tabela `savings`
--

CREATE TABLE `savings` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `earned_interest` decimal(10,2) DEFAULT '0.00',
  `last_interest_update` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `software_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_favicon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_logo_white` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_logo_black` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_background` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BRL',
  `decimal_format` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'dot',
  `currency_position` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'left',
  `revshare_percentage` bigint DEFAULT '20',
  `ngr_percent` bigint DEFAULT '20',
  `soccer_percentage` bigint DEFAULT '30',
  `prefix` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'R$',
  `storage` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local',
  `initial_bonus` bigint DEFAULT '0',
  `min_deposit` decimal(10,2) DEFAULT '20.00',
  `max_deposit` decimal(10,2) DEFAULT '0.00',
  `min_withdrawal` decimal(10,2) DEFAULT '20.00',
  `max_withdrawal` decimal(10,2) DEFAULT '0.00',
  `rollover` bigint DEFAULT '10',
  `rollover_deposit` bigint DEFAULT '1',
  `suitpay_is_enable` tinyint DEFAULT '1',
  `stripe_is_enable` tinyint DEFAULT '1',
  `bspay_is_enable` tinyint DEFAULT '0',
  `turn_on_football` tinyint DEFAULT '1',
  `revshare_reverse` tinyint(1) DEFAULT '1',
  `bonus_vip` bigint DEFAULT '100',
  `activate_vip_bonus` tinyint(1) DEFAULT '1',
  `updated_at` timestamp NULL DEFAULT NULL,
  `maintenance_mode` tinyint DEFAULT '0',
  `withdrawal_limit` bigint DEFAULT NULL,
  `withdrawal_period` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disable_spin` tinyint(1) NOT NULL DEFAULT '0',
  `perc_sub_lv1` bigint NOT NULL DEFAULT '4',
  `perc_sub_lv2` bigint NOT NULL DEFAULT '2',
  `perc_sub_lv3` bigint NOT NULL DEFAULT '3',
  `promotion_text` text COLLATE utf8mb4_unicode_ci,
  `promotion_button_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disable_rollover` int NOT NULL DEFAULT '0',
  `rollover_protection` int NOT NULL DEFAULT '5',
  `cpa_baseline` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cpa_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_login` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_register` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `digitopay_is_enable` tinyint(1) DEFAULT NULL,
  `sharkpay_is_enable` tinyint(1) DEFAULT NULL,
  `mercadopago_is_enable` tinyint(1) DEFAULT NULL,
  `default_gateway` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `minimum_bets` int DEFAULT '200'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `settings`
--

INSERT INTO `settings` (`id`, `software_name`, `software_description`, `software_favicon`, `software_logo_white`, `software_logo_black`, `software_background`, `currency_code`, `decimal_format`, `currency_position`, `revshare_percentage`, `ngr_percent`, `soccer_percentage`, `prefix`, `storage`, `initial_bonus`, `min_deposit`, `max_deposit`, `min_withdrawal`, `max_withdrawal`, `rollover`, `rollover_deposit`, `suitpay_is_enable`, `stripe_is_enable`, `bspay_is_enable`, `turn_on_football`, `revshare_reverse`, `bonus_vip`, `activate_vip_bonus`, `updated_at`, `maintenance_mode`, `withdrawal_limit`, `withdrawal_period`, `disable_spin`, `perc_sub_lv1`, `perc_sub_lv2`, `perc_sub_lv3`, `promotion_text`, `promotion_button_text`, `disable_rollover`, `rollover_protection`, `cpa_baseline`, `cpa_value`, `image_login`, `image_register`, `digitopay_is_enable`, `sharkpay_is_enable`, `mercadopago_is_enable`, `default_gateway`, `minimum_bets`) VALUES
(1, 'RIFADASORTE', 'RIFADASORTE', 'uploads/0q8BLnzdhXZHJcoP4anUKmzpyJMzerEF6nSKQ4HA.webp', 'uploads/2XnoAMgsYqt9T22x6R9II3aVFXjbFPkBdF67Dc0d.webp', 'uploads/wCxrYUIr92yC5Tb8sD4Ya70zP62mW3zio2waiBxC.webp', '[]', 'BRL', 'dot', 'left', 0, 0, 30, 'R$', 'local', 0, 10.00, 50000.00, 10.00, 50000.00, 10, 1, 1, 0, 0, 0, 1, 100, 1, '2025-07-21 12:53:25', 0, 5, 'daily', 0, 4, 3, 2, 'RIFADASORTE dá as boas-vindas aos membros! Atualmente, muitas pessoas fingem ser o serviço de atendimento ao cliente da GalaxsysGaming o objetivo de desviar propriedades. Espero que os membros sejam mais vigilantes, não enviem mensagens privadas para reembolsos e não acreditem que não haja promoções de alto valor a serem evitadas perdas de bens pessoais.', NULL, 0, 5, '10', '10', '[]', '[]', 0, 0, 0, 'suitpay', 200);

-- --------------------------------------------------------

--
-- Estrutura para tabela `setting_mails`
--

CREATE TABLE `setting_mails` (
  `id` bigint UNSIGNED NOT NULL,
  `software_smtp_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_smtp_mail_host` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_smtp_mail_port` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_smtp_mail_username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_smtp_mail_password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_smtp_mail_encryption` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_smtp_mail_from_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_smtp_mail_from_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sub_affiliates`
--

CREATE TABLE `sub_affiliates` (
  `id` bigint UNSIGNED NOT NULL,
  `affiliate_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Estrutura para tabela `suit_pay_payments`
--

CREATE TABLE `suit_pay_payments` (
  `id` bigint UNSIGNED NOT NULL,
  `payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `withdrawal_id` bigint UNSIGNED NOT NULL,
  `pix_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pix_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `observation` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_wallets`
--

CREATE TABLE `system_wallets` (
  `id` bigint UNSIGNED NOT NULL,
  `label` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(27,12) NOT NULL DEFAULT '0.000000000000',
  `balance_min` decimal(27,12) NOT NULL DEFAULT '10000.100000000000',
  `pay_upto_percentage` decimal(4,2) NOT NULL DEFAULT '45.00',
  `mode` enum('balance_min','percentage') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'percentage',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=FIXED;

--
-- Despejando dados para a tabela `system_wallets`
--

INSERT INTO `system_wallets` (`id`, `label`, `balance`, `balance_min`, `pay_upto_percentage`, `mode`, `created_at`, `updated_at`) VALUES
(1, 'system', 261.800000000000, 10000.100000000000, 45.00, 'percentage', '2023-10-11 16:11:15', '2023-10-16 18:42:00');

-- --------------------------------------------------------

--
-- Estrutura para tabela `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `payment_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(20,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'usd',
  `status` tinyint DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `accept_bonus` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_savings` tinyint(1) DEFAULT '0',
  `savings_amount` decimal(10,2) DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `transactions`
--

INSERT INTO `transactions` (`id`, `payment_id`, `user_id`, `payment_method`, `price`, `currency`, `status`, `created_at`, `updated_at`, `accept_bonus`, `deposit_savings`, `savings_amount`) VALUES
(13, 'aa3911862933df8cfba7mcxlpqw63afj', 927613841, 'pix', 20.00, 'BRL', 0, '2025-07-10 13:27:37', '2025-07-10 13:27:37', '686fe9f9ac2e3', 0, 0.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `withdraw_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `oauth_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oauth_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cpf` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logged_in` tinyint NOT NULL DEFAULT '0',
  `banned` tinyint NOT NULL DEFAULT '0',
  `inviter` int DEFAULT NULL,
  `inviter_code` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `affiliate_revenue_share` bigint NOT NULL DEFAULT '2',
  `affiliate_revenue_share_fake` bigint DEFAULT NULL,
  `affiliate_cpa` decimal(20,2) NOT NULL DEFAULT '10.00',
  `affiliate_baseline` decimal(20,2) NOT NULL DEFAULT '40.00',
  `is_demo_agent` tinyint NOT NULL DEFAULT '0',
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `language` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pt_BR',
  `role_id` int DEFAULT '3',
  `indicated_count` int NOT NULL DEFAULT '0',
  `total_deposit_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `distinct_inviters_count` int NOT NULL DEFAULT '0',
  `inviters_count` int DEFAULT '0',
  `open_chests` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `whatsapp` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telegram_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `earnings` decimal(12,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `withdraw_password`, `remember_token`, `created_at`, `updated_at`, `oauth_id`, `oauth_type`, `avatar`, `last_name`, `cpf`, `phone`, `logged_in`, `banned`, `inviter`, `inviter_code`, `affiliate_revenue_share`, `affiliate_revenue_share_fake`, `affiliate_cpa`, `affiliate_baseline`, `is_demo_agent`, `status`, `language`, `role_id`, `indicated_count`, `total_deposit_amount`, `distinct_inviters_count`, `inviters_count`, `open_chests`, `whatsapp`, `facebook_id`, `telegram_id`, `line_id`, `twitter_id`, `birthdate`, `earnings`) VALUES
(1, 'Admin', 'suporteapi@gmail.com', NULL, '$2y$10$gBDn8fImc4Apr/ymodQNMODDTcGscYl/gf7Qf9jtVm0vtyLb4GeIe', '$2y$10$gBDn8fImc4Apr/ymodQNMODDTcGscYl/gf7Qf9jtVm0vtyLb4GeIe', 'MuBUAPcKAjs6b2ZaOvFTcaUEn30Bvsm4M2WvycKSgPr3ruR7szwavrL9RiWU', '2023-11-07 22:15:13', '2025-07-21 12:56:01', NULL, NULL, 'uploads/Oc4rg3FThMWKSEkZSMvtgVztKPe7E829rzXLFOX1.jpg', NULL, NULL, '(31) 98690-4249', 0, 0, NULL, 'IL9O93HOCY', 20, 20, 20.00, 40.00, 0, 'active', 'pt_BR', 1, 1, 0.00, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2.00),
(23803085, 'anderson costa', 'ancosta1995', NULL, '$2y$10$.4Y/vsMRoKt7WgNd8m93Y.fdy8phwFRZ../BeVfSse592BkAuhqhW', NULL, NULL, '2025-07-21 10:46:00', '2025-07-21 10:46:00', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, 10.00, 10.00, 0, 'active', 'pt_BR', 3, 0, 0.00, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00),
(248939439, 'solution', 'cbou', NULL, '$2y$10$VSyjCx1OMjZ4JuLV2ca16Ojb9tPbfvr96v7RUOfZJhsdQGysV9GUK', NULL, NULL, '2025-07-21 13:03:29', '2025-07-21 13:05:08', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, '62KM1Z17WX', 0, NULL, 10.00, 10.00, 0, 'active', 'pt_BR', 3, 0, 0.00, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00),
(405530471, 'Euanxjc', 'Tests', NULL, '$2y$10$BWVShhQnIBAqbhS5N8wwBub2eXF.XAPDB3jCDa/YKGJG4hpy3/1R6', NULL, NULL, '2025-07-21 13:01:14', '2025-07-21 13:01:14', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, 10.00, 10.00, 0, 'active', 'pt_BR', 3, 0, 0.00, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00),
(420876639, 'Gabriel Tiago', 'Colennn', NULL, '$2y$10$bt31yMMXCIHCoHirLvIjq.cxT/pkp6/U6EjQmZ1FYetbRAjcvTsli', NULL, NULL, '2025-07-18 20:28:49', '2025-07-18 20:28:49', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, NULL, 10.00, 10.00, 0, 'active', 'pt_BR', 3, 0, 0.00, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00),
(613828057, 'teseg ewgwgw', 'testeee4', NULL, '$2y$10$BfrtfmBCsFrW6eN0iloA/e4KZmKWpGWLEkF2klK5xGA3fe3w72quO', NULL, NULL, '2025-07-21 14:10:27', '2025-07-21 14:10:46', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 'T0JG3ZYJE4', 0, NULL, 10.00, 10.00, 0, 'active', 'pt_BR', 3, 0, 0.00, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `vips`
--

CREATE TABLE `vips` (
  `id` bigint UNSIGNED NOT NULL,
  `bet_symbol` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bet_level` bigint NOT NULL DEFAULT '1',
  `bet_required` bigint DEFAULT NULL,
  `bet_period` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bet_bonus` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `vips`
--

INSERT INTO `vips` (`id`, `bet_symbol`, `bet_level`, `bet_required`, `bet_period`, `bet_bonus`, `created_at`, `updated_at`) VALUES
(1, '01HN992NSPXKG4G9SR20NHR848.png', 0, 5000, NULL, 7, '2024-01-28 21:14:33', '2024-07-23 14:09:53');

-- --------------------------------------------------------

--
-- Estrutura para tabela `vip_users`
--

CREATE TABLE `vip_users` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `vip_id` int UNSIGNED NOT NULL,
  `level` bigint NOT NULL,
  `points` bigint NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=FIXED;

--
-- Despejando dados para a tabela `vip_users`
--

INSERT INTO `vip_users` (`id`, `user_id`, `vip_id`, `level`, `points`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0, 0, 1, '2024-03-23 12:22:51', '2024-03-23 12:22:51'),
(2, 99, 1, 0, 0, 1, '2024-03-23 13:46:00', '2024-03-23 13:46:00'),
(3, 125, 1, 0, 0, 1, '2024-03-24 03:17:55', '2024-03-24 03:17:55'),
(4, 157, 1, 0, 0, 1, '2024-03-25 13:04:11', '2024-03-25 13:04:11'),
(5, 131, 1, 0, 0, 1, '2024-03-25 17:25:18', '2024-03-25 17:25:18'),
(6, 133, 1, 0, 0, 1, '2024-03-25 21:35:37', '2024-03-25 21:35:37'),
(7, 187, 1, 0, 0, 1, '2024-03-26 09:15:35', '2024-03-26 09:15:35'),
(8, 208, 1, 0, 0, 1, '2024-03-26 15:53:22', '2024-03-26 15:53:22'),
(9, 237, 1, 0, 0, 1, '2024-03-28 12:37:41', '2024-03-28 12:37:41'),
(10, 236, 1, 0, 0, 1, '2024-03-28 14:05:38', '2024-03-28 14:05:38'),
(11, 266, 1, 0, 0, 1, '2024-03-29 13:30:01', '2024-03-29 13:30:01'),
(12, 198, 1, 0, 0, 1, '2024-03-29 16:22:56', '2024-03-29 16:22:56'),
(13, 696497212, 0, 0, 0, 0, '2025-07-10 11:49:17', '2025-07-10 11:49:17'),
(14, 789371170, 0, 0, 0, 0, '2025-07-10 12:30:19', '2025-07-10 12:30:19'),
(15, 99882156, 0, 0, 0, 0, '2025-07-10 12:40:33', '2025-07-10 12:40:33'),
(16, 927613841, 0, 0, 0, 0, '2025-07-10 13:27:23', '2025-07-10 13:27:23'),
(17, 420876639, 0, 0, 0, 0, '2025-07-18 20:28:49', '2025-07-18 20:28:49'),
(18, 23803085, 0, 0, 0, 0, '2025-07-21 10:46:00', '2025-07-21 10:46:00'),
(19, 405530471, 0, 0, 0, 0, '2025-07-21 13:01:14', '2025-07-21 13:01:14'),
(20, 248939439, 0, 0, 0, 0, '2025-07-21 13:03:30', '2025-07-21 13:03:30'),
(21, 613828057, 0, 0, 0, 0, '2025-07-21 14:10:27', '2025-07-21 14:10:27');

-- --------------------------------------------------------

--
-- Estrutura para tabela `wallets`
--

CREATE TABLE `wallets` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `currency` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(20,2) NOT NULL DEFAULT '0.00',
  `balance_bonus_rollover` decimal(10,2) DEFAULT '0.00',
  `balance_deposit_rollover` decimal(10,2) DEFAULT '0.00',
  `balance_withdrawal` decimal(10,2) DEFAULT '0.00',
  `partnership` decimal(16,2) NOT NULL DEFAULT '0.00',
  `balance_savings` decimal(10,2) NOT NULL DEFAULT '0.00',
  `savings_interest` decimal(10,2) NOT NULL DEFAULT '0.00',
  `last_interest_update` datetime DEFAULT NULL,
  `last_deposit_update` timestamp NULL DEFAULT NULL,
  `balance_bonus` decimal(20,2) NOT NULL DEFAULT '0.00',
  `balance_cryptocurrency` decimal(20,8) NOT NULL DEFAULT '0.00000000',
  `balance_demo` decimal(20,8) DEFAULT '1000.00000000',
  `refer_rewards` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hide_balance` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `total_bet` decimal(20,2) NOT NULL DEFAULT '0.00',
  `total_won` bigint NOT NULL DEFAULT '0',
  `total_lose` bigint NOT NULL DEFAULT '0',
  `last_won` bigint NOT NULL DEFAULT '0',
  `last_lose` bigint NOT NULL DEFAULT '0',
  `vip_level` bigint DEFAULT '0',
  `vip_points` bigint DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Despejando dados para a tabela `wallets`
--

INSERT INTO `wallets` (`id`, `user_id`, `currency`, `symbol`, `balance`, `balance_bonus_rollover`, `balance_deposit_rollover`, `balance_withdrawal`, `partnership`, `balance_savings`, `savings_interest`, `last_interest_update`, `last_deposit_update`, `balance_bonus`, `balance_cryptocurrency`, `balance_demo`, `refer_rewards`, `hide_balance`, `active`, `created_at`, `updated_at`, `total_bet`, `total_won`, `total_lose`, `last_won`, `last_lose`, `vip_level`, `vip_points`) VALUES
(1, 1, 'BRL', 'R$', 0.00, 0.00, 0.00, 98.00, 0.00, 0.00, 0.00, '2025-02-22 15:59:03', '2025-02-07 14:13:08', 0.00, 0.00000000, 1000.00000000, 0.00, 0, 1, '2023-11-07 22:15:13', '2025-07-21 13:08:01', 0.00, 0, 0, 0, 0, 1, 10000),
(410, 696497212, 'BRL', 'R$', 100.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '2025-07-10 11:54:50', NULL, 0.00, 0.00000000, 1000.00000000, 0.00, 0, 1, '2025-07-10 11:49:17', '2025-07-10 12:01:49', 0.00, 0, 0, 0, 0, 0, 0),
(411, 789371170, 'BRL', 'R$', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00000000, 1000.00000000, 0.00, 0, 1, '2025-07-10 12:30:19', '2025-07-10 12:30:19', 0.00, 0, 0, 0, 0, 0, 0),
(412, 99882156, 'BRL', 'R$', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00000000, 1000.00000000, 0.00, 0, 1, '2025-07-10 12:40:33', '2025-07-10 12:40:33', 0.00, 0, 0, 0, 0, 0, 0),
(413, 927613841, 'BRL', 'R$', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00000000, 1000.00000000, 0.00, 0, 1, '2025-07-10 13:27:23', '2025-07-10 13:27:23', 0.00, 0, 0, 0, 0, 0, 0),
(414, 420876639, 'BRL', 'R$', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '2025-07-18 20:28:55', NULL, 0.00, 0.00000000, 1000.00000000, 0.00, 0, 1, '2025-07-18 20:28:49', '2025-07-18 20:28:55', 0.00, 0, 0, 0, 0, 0, 0),
(415, 23803085, 'BRL', 'R$', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00000000, 1000.00000000, 0.00, 0, 1, '2025-07-21 10:46:00', '2025-07-21 10:46:00', 0.00, 0, 0, 0, 0, 0, 0),
(416, 405530471, 'BRL', 'R$', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00000000, 1000.00000000, 0.00, 0, 1, '2025-07-21 13:01:14', '2025-07-21 13:01:14', 0.00, 0, 0, 0, 0, 0, 0),
(417, 248939439, 'BRL', 'R$', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '2025-07-21 13:05:03', NULL, 0.00, 0.00000000, 1000.00000000, 0.00, 0, 1, '2025-07-21 13:03:29', '2025-07-21 13:05:03', 0.00, 0, 0, 0, 0, 0, 0),
(418, 613828057, 'BRL', 'R$', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '2025-07-21 14:10:35', NULL, 0.00, 0.00000000, 1000.00000000, 0.00, 0, 1, '2025-07-21 14:10:27', '2025-07-21 14:10:35', 0.00, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `wallet_changes`
--

CREATE TABLE `wallet_changes` (
  `id` bigint UNSIGNED NOT NULL,
  `reason` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_bonus` decimal(20,2) NOT NULL DEFAULT '0.00',
  `value_total` decimal(20,2) NOT NULL DEFAULT '0.00',
  `value_roi` decimal(20,2) NOT NULL DEFAULT '0.00',
  `value_entry` decimal(20,2) NOT NULL DEFAULT '0.00',
  `refer_rewards` decimal(20,2) NOT NULL DEFAULT '0.00',
  `game` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `websockets_statistics_entries`
--

CREATE TABLE `websockets_statistics_entries` (
  `id` int UNSIGNED NOT NULL,
  `app_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `peak_connection_count` int NOT NULL,
  `websocket_message_count` int NOT NULL,
  `api_message_count` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estrutura para tabela `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` bigint UNSIGNED NOT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proof` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `pix_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pix_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_info` text COLLATE utf8mb4_unicode_ci,
  `currency` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `affiliate_histories`
--
ALTER TABLE `affiliate_histories`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `affiliate_histories_user_id_index` (`user_id`) USING BTREE,
  ADD KEY `affiliate_histories_inviter_index` (`inviter`) USING BTREE;

--
-- Índices de tabela `affiliate_withdraws`
--
ALTER TABLE `affiliate_withdraws`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `affiliate_withdraws_user_id_foreign` (`user_id`) USING BTREE;

--
-- Índices de tabela `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `casino_categories_slug_unique` (`slug`) USING BTREE;

--
-- Índices de tabela `category_game`
--
ALTER TABLE `category_game`
  ADD KEY `category_games_category_id_foreign` (`category_id`) USING BTREE,
  ADD KEY `category_games_game_id_foreign` (`game_id`) USING BTREE;

--
-- Índices de tabela `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `currency_alloweds`
--
ALTER TABLE `currency_alloweds`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `currency_alloweds_currency_id_foreign` (`currency_id`) USING BTREE;

--
-- Índices de tabela `custom_layouts`
--
ALTER TABLE `custom_layouts`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `daily_checkins`
--
ALTER TABLE `daily_checkins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `daily_checkins_user_date_unique` (`user_id`,`checkin_date`);

--
-- Índices de tabela `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `deposits_user_id_foreign` (`user_id`) USING BTREE;

--
-- Índices de tabela `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`) USING BTREE;

--
-- Índices de tabela `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `games_provider_id_index` (`provider_id`) USING BTREE,
  ADD KEY `games_game_code_index` (`game_code`) USING BTREE;

--
-- Índices de tabela `game_favorites`
--
ALTER TABLE `game_favorites`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `game_favorites_user_id_game_id_unique` (`user_id`,`game_id`) USING BTREE,
  ADD KEY `game_favorites_game_id_foreign` (`game_id`) USING BTREE;

--
-- Índices de tabela `game_likes`
--
ALTER TABLE `game_likes`
  ADD UNIQUE KEY `game_likes_user_id_game_id_unique` (`user_id`,`game_id`) USING BTREE,
  ADD KEY `game_likes_game_id_foreign` (`game_id`) USING BTREE;

--
-- Índices de tabela `game_reviews`
--
ALTER TABLE `game_reviews`
  ADD UNIQUE KEY `game_reviews_user_id_game_id_unique` (`user_id`,`game_id`) USING BTREE,
  ADD KEY `game_reviews_game_id_foreign` (`game_id`) USING BTREE;

--
-- Índices de tabela `gateways`
--
ALTER TABLE `gateways`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `ggds_spin_config`
--
ALTER TABLE `ggds_spin_config`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `ggds_spin_runs`
--
ALTER TABLE `ggds_spin_runs`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `ggr_games_fivers`
--
ALTER TABLE `ggr_games_fivers`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `ggr_games_fivers_user_id_index` (`user_id`) USING BTREE;

--
-- Índices de tabela `ggr_games_world_slots`
--
ALTER TABLE `ggr_games_world_slots`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `ggr_games_world_slots_user_id_index` (`user_id`) USING BTREE;

--
-- Índices de tabela `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `likes_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `likes_liked_user_id_foreign` (`liked_user_id`) USING BTREE;

--
-- Índices de tabela `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `missions`
--
ALTER TABLE `missions`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `mission_users`
--
ALTER TABLE `mission_users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `mission_users_user_id_index` (`user_id`) USING BTREE,
  ADD KEY `mission_users_mission_id_index` (`mission_id`) USING BTREE;

--
-- Índices de tabela `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`) USING BTREE,
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`) USING BTREE;

--
-- Índices de tabela `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`) USING BTREE,
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`) USING BTREE;

--
-- Índices de tabela `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`) USING BTREE;

--
-- Índices de tabela `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `orders_user_id_foreign` (`user_id`) USING BTREE;

--
-- Índices de tabela `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`) USING BTREE;

--
-- Índices de tabela `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`) USING BTREE;

--
-- Índices de tabela `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`) USING BTREE,
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`) USING BTREE;

--
-- Índices de tabela `pix_accounts`
--
ALTER TABLE `pix_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `pix_complaints`
--
ALTER TABLE `pix_complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`) USING BTREE;

--
-- Índices de tabela `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`) USING BTREE,
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`) USING BTREE;

--
-- Índices de tabela `savings`
--
ALTER TABLE `savings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `setting_mails`
--
ALTER TABLE `setting_mails`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `sub_affiliates`
--
ALTER TABLE `sub_affiliates`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `sub_affiliates_affiliate_id_index` (`affiliate_id`) USING BTREE,
  ADD KEY `sub_affiliates_user_id_index` (`user_id`) USING BTREE;

--
-- Índices de tabela `suit_pay_payments`
--
ALTER TABLE `suit_pay_payments`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `suit_pay_payments_user_id_foreign` (`user_id`) USING BTREE,
  ADD KEY `suit_pay_payments_withdrawal_id_foreign` (`withdrawal_id`) USING BTREE;

--
-- Índices de tabela `system_wallets`
--
ALTER TABLE `system_wallets`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `transactions_user_id_index` (`user_id`) USING BTREE;

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `users_email_unique` (`email`) USING BTREE;

--
-- Índices de tabela `vips`
--
ALTER TABLE `vips`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `vip_users`
--
ALTER TABLE `vip_users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `vip_users_user_id_index` (`user_id`) USING BTREE,
  ADD KEY `vip_users_vip_id_index` (`vip_id`) USING BTREE;

--
-- Índices de tabela `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `wallets_user_id_index` (`user_id`) USING BTREE;

--
-- Índices de tabela `wallet_changes`
--
ALTER TABLE `wallet_changes`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `wallet_changes_user_id_foreign` (`user_id`) USING BTREE;

--
-- Índices de tabela `websockets_statistics_entries`
--
ALTER TABLE `websockets_statistics_entries`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Índices de tabela `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `withdrawals_user_id_foreign` (`user_id`) USING BTREE;

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `affiliate_histories`
--
ALTER TABLE `affiliate_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `affiliate_withdraws`
--
ALTER TABLE `affiliate_withdraws`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `banners`
--
ALTER TABLE `banners`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de tabela `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT de tabela `currency_alloweds`
--
ALTER TABLE `currency_alloweds`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `custom_layouts`
--
ALTER TABLE `custom_layouts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `daily_checkins`
--
ALTER TABLE `daily_checkins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `games`
--
ALTER TABLE `games`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3436;

--
-- AUTO_INCREMENT de tabela `game_favorites`
--
ALTER TABLE `game_favorites`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `gateways`
--
ALTER TABLE `gateways`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `ggds_spin_config`
--
ALTER TABLE `ggds_spin_config`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `ggds_spin_runs`
--
ALTER TABLE `ggds_spin_runs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `ggr_games_fivers`
--
ALTER TABLE `ggr_games_fivers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ggr_games_world_slots`
--
ALTER TABLE `ggr_games_world_slots`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de tabela `missions`
--
ALTER TABLE `missions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `mission_users`
--
ALTER TABLE `mission_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de tabela `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pix_accounts`
--
ALTER TABLE `pix_accounts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `pix_complaints`
--
ALTER TABLE `pix_complaints`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `providers`
--
ALTER TABLE `providers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `savings`
--
ALTER TABLE `savings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `setting_mails`
--
ALTER TABLE `setting_mails`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sub_affiliates`
--
ALTER TABLE `sub_affiliates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `suit_pay_payments`
--
ALTER TABLE `suit_pay_payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `system_wallets`
--
ALTER TABLE `system_wallets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=613828058;

--
-- AUTO_INCREMENT de tabela `vips`
--
ALTER TABLE `vips`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `vip_users`
--
ALTER TABLE `vip_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de tabela `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=419;

--
-- AUTO_INCREMENT de tabela `wallet_changes`
--
ALTER TABLE `wallet_changes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `websockets_statistics_entries`
--
ALTER TABLE `websockets_statistics_entries`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `daily_checkins`
--
ALTER TABLE `daily_checkins`
  ADD CONSTRAINT `daily_checkins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `pix_accounts`
--
ALTER TABLE `pix_accounts`
  ADD CONSTRAINT `pix_accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `pix_complaints`
--
ALTER TABLE `pix_complaints`
  ADD CONSTRAINT `pix_complaints_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `savings`
--
ALTER TABLE `savings`
  ADD CONSTRAINT `savings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
