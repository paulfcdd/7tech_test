-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Янв 15 2018 г., 13:07
-- Версия сервера: 10.1.28-MariaDB
-- Версия PHP: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `7tech`
--

-- --------------------------------------------------------

--
-- Структура таблицы `articles`
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` varchar(10000) COLLATE utf8_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `date_removed` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `articles`
--

INSERT INTO `articles` (`id`, `author_id`, `title`, `content`, `date_created`, `date_updated`, `date_removed`) VALUES
(20, 18, 'Lorem Ipsum', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut auctor purus metus, at lacinia nisi faucibus ac. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus iaculis vulputate enim nec molestie. Aliquam id urna augue. Aenean ornare, lorem nec rutrum efficitur, nisi leo consequat mi, id congue mauris sem vitae odio. Fusce eu ante congue, placerat arcu at, dignissim augue. Fusce in ex tristique, vehicula dui eget, suscipit ante. Curabitur volutpat ante sit amet quam tempor feugiat. Curabitur in risus tincidunt dolor condimentum aliquet ac eget elit. Cras varius vulputate tincidunt. Donec placerat diam dolor, eu tempus neque venenatis sed. Duis egestas faucibus pretium. Fusce scelerisque gravida urna, ac placerat risus tristique ac.</p>', '2018-01-15 12:58:38', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `date_removed` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `name`, `date_created`, `date_updated`, `date_removed`) VALUES
(1, NULL, 'category 1', '2018-01-15 01:04:46', '2018-01-15 12:58:38', NULL),
(2, 1, 'category 2', '2018-01-15 01:05:03', '2018-01-15 13:00:10', NULL),
(3, NULL, 'category 3', '2018-01-15 01:09:33', '2018-01-15 12:39:36', NULL),
(4, 1, 'category 4', '2018-01-15 01:10:02', '2018-01-15 12:41:48', NULL),
(5, 2, 'category 5', '2018-01-15 01:10:18', NULL, NULL),
(6, 4, 'category 6', '2018-01-15 01:10:31', '2018-01-15 12:58:38', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `category_articles`
--

CREATE TABLE `category_articles` (
  `category_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `category_articles`
--

INSERT INTO `category_articles` (`category_id`, `article_id`) VALUES
(1, 20),
(2, 20),
(6, 20);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `confirmation_token` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `username_canonical`, `email_canonical`, `enabled`, `salt`, `last_login`, `confirmation_token`, `password_requested_at`, `roles`) VALUES
(14, 'pavelesmi@yandex.ru', 'test', '$2y$13$RYJ0KGN/WAAGilOghxKu6.0pwNCzr9HzX13u7dizABng4AS8JNLqO', 'test', 'pavelesmi@yandex.ru', 1, NULL, '2018-01-14 16:46:11', NULL, NULL, 'a:0:{}'),
(16, 'paulfcdd@gmail.com', 'paul', '$2y$13$1GEbrxE.pWYOY00U4utfaevdR6utO.mKrZDi9MVuY7yhfFOHAy0Su', 'paul', 'paulfcdd@gmail.com', 1, NULL, '2018-01-14 19:37:14', NULL, NULL, 'a:0:{}'),
(18, 'pavelesmi@yandex.ruf', 'test1', '$2y$13$I3Pmw34x6uQrplqLv7q/jukQ4Mpeuqv0Qq8fytBtYsmcgZFkNmCVG', 'test1', 'pavelesmi@yandex.ruf', 1, NULL, '2018-01-14 19:46:21', NULL, NULL, 'a:0:{}');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_BFDD3168F675F31B` (`author_id`);

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_3AF346685E237E06` (`name`),
  ADD KEY `IDX_3AF34668727ACA70` (`parent_id`);

--
-- Индексы таблицы `category_articles`
--
ALTER TABLE `category_articles`
  ADD PRIMARY KEY (`category_id`,`article_id`),
  ADD KEY `IDX_8A7B51312469DE2` (`category_id`),
  ADD KEY `IDX_8A7B5137294869C` (`article_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_1483A5E992FC23A8` (`username_canonical`),
  ADD UNIQUE KEY `UNIQ_1483A5E9A0D96FBF` (`email_canonical`),
  ADD UNIQUE KEY `UNIQ_1483A5E9C05FB297` (`confirmation_token`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `FK_BFDD3168F675F31B` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `FK_3AF34668727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`);

--
-- Ограничения внешнего ключа таблицы `category_articles`
--
ALTER TABLE `category_articles`
  ADD CONSTRAINT `FK_8A7B51312469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_8A7B5137294869C` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
