-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Окт 25 2026 г., 17:12
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `task 3`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `request 1` (IN `Customer_Name1` TEXT, IN `Quantity1` INT)   SELECT goods.`Barcode`,`Product Name`,`Product Type`,`Price`,`Quantity`
FROM goods
INNER JOIN orders
ON goods.`Barcode`=orders.`Barcode`
INNER JOIN customers
ON orders.`Customer ID`=customers.`Customer ID`
WHERE `Customer Name`=Customer_Name1 AND `Quantity`>Quantity1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `request 2` (IN `type` BOOLEAN)   UPDATE goods 
SET `Price`=`Price`*1.1
WHERE `Price`<(SELECT AVG(`Price`) FROM goods)
AND `Product Type`=type$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `request 3` (IN `product_name` TEXT)   SELECT COUNT(*) AS 'Quantity of orders with' FROM orders 
WHERE `Barcode` IN 
(SELECT `Barcode` FROM goods 
 WHERE `Product Name`=product_name)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `request 5` ()   SELECT `Order ID`,`Order Date`,orders.`Barcode`,`Product Name`,`Batch Number`,`Customer Name`,`request 4`(`Price`,`Quantity`) AS 'Total Price'
FROM orders 
INNER JOIN goods
ON orders.`Barcode`=goods.`Barcode`
INNER JOIN customers
ON orders.`Customer ID`=customers.`Customer ID`
ORDER BY `Order Date`$$

--
-- Функции
--
CREATE DEFINER=`root`@`localhost` FUNCTION `request 4` (`price` FLOAT, `quantity` INT) RETURNS FLOAT  RETURN price*quantity$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `currentyearorders`
--

CREATE TABLE `currentyearorders` (
  `Order ID` int(5) NOT NULL,
  `Order Date` date NOT NULL,
  `Barcode` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Customer ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `currentyearorders`
--

INSERT INTO `currentyearorders` (`Order ID`, `Order Date`, `Barcode`, `Quantity`, `Customer ID`) VALUES
(1, '2025-01-15', 62812284, 10, 103),
(2, '2025-01-15', 63608282, 10, 103),
(3, '2025-03-06', 93337357, 51, 104),
(4, '2025-03-06', 28289844, 100, 104),
(5, '2025-02-23', 14774246, 1, 107),
(6, '2025-03-08', 14774246, 1, 108),
(8, '2025-03-30', 81677579, 18, 110),
(9, '2025-03-30', 87967249, 12, 110),
(10, '2025-03-30', 42355275, 100, 109),
(11, '2025-03-31', 93337357, 2, 102),
(12, '2025-03-31', 63608282, 1, 102),
(13, '2025-03-31', 18781269, 1, 101),
(15, '2025-01-15', 63608282, 1, 108),
(16, '2025-05-22', 63608282, 45, 103);

-- --------------------------------------------------------

--
-- Структура таблицы `customers`
--

CREATE TABLE `customers` (
  `Customer ID` int(3) NOT NULL,
  `Customer Name` varchar(30) NOT NULL,
  `Address` varchar(40) NOT NULL,
  `Customer Type` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `customers`
--

INSERT INTO `customers` (`Customer ID`, `Customer Name`, `Address`, `Customer Type`) VALUES
(101, 'Вяточкин П.М', 'Красноясрк', 0),
(102, 'Мелич Д.В', 'Красноясрк', 0),
(103, 'ООО \"The Game World\"', 'Новосибирск', 1),
(104, 'ООО \"NRG Gym\"', 'Красноярск', 1),
(105, 'Тихин И.А', 'Красноясрк', 0),
(106, 'Говоров Я.С', 'Красноясрк', 0),
(107, 'Немоляев К.Ф', 'Томск', 0),
(108, 'Князева А.А', 'Иркутск', 0),
(109, 'ИП Молокова Я.В', 'Красноясрк', 1),
(110, 'ООО \"Книжная Лавка\"', 'Новосибирск', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `customerstest`
--

CREATE TABLE `customerstest` (
  `Customer ID` int(3) NOT NULL,
  `Customer Name` varchar(30) NOT NULL,
  `Address` varchar(40) NOT NULL,
  `Customer Type` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `customerstest`
--

INSERT INTO `customerstest` (`Customer ID`, `Customer Name`, `Address`, `Customer Type`) VALUES
(101, 'Вяточкин П.М', 'Красноясрк', 0),
(102, 'Мелич Д.В', 'Красноясрк', 0),
(103, 'ООО \"The Game World\"', 'Новосибирск', 1),
(104, 'ООО \"NRG Gym\"', 'Красноярск', 1),
(105, 'Тихин И.А', 'Красноясрк', 0),
(106, 'Говоров Я.С', 'Красноясрк', 0),
(107, 'Немоляев К.Ф', 'Томск', 0),
(108, 'Князева А.А', 'Иркутск', 0),
(109, 'ИП Молокова Я.В', 'Красноясрк', 1),
(110, 'ООО \"Книжная Лавка\"', 'Новосибирск', 1),
(111, 'Поляков А.В', 'Томск', 0),
(988, 'Поляков А.В', 'Томск', 0),
(575, 'Поляков А.В', 'Томск', 0);

--
-- Триггеры `customerstest`
--
DELIMITER $$
CREATE TRIGGER `trigger 8` BEFORE INSERT ON `customerstest` FOR EACH ROW BEGIN
IF new.`Customer ID`>999 OR new.`Customer ID`<100 THEN
SET new.`Customer ID`=FLOOR(RAND()*(999-100+1))+100;
END IF;
IF new.`Customer Type`!=0 OR new.`Customer Type`!=1 THEN
SET new.`Customer Type`=0;
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger 9` BEFORE UPDATE ON `customerstest` FOR EACH ROW BEGIN
IF new.`Customer ID`>999 OR new.`Customer ID`<100 THEN
SET new.`Customer ID`=FLOOR(RAND()*(999-100+1))+100;
END IF;
IF new.`Customer Type`!=0 OR new.`Customer Type`!=1 THEN
SET new.`Customer Type`=0;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `goods`
--

CREATE TABLE `goods` (
  `Barcode` int(11) NOT NULL,
  `Product Name` varchar(30) NOT NULL,
  `Product Type` tinyint(1) NOT NULL,
  `Batch Number` int(11) NOT NULL,
  `Best Before` date DEFAULT NULL,
  `Price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `goods`
--

INSERT INTO `goods` (`Barcode`, `Product Name`, `Product Type`, `Batch Number`, `Best Before`, `Price`) VALUES
(14774246, 'D&G glasses', 0, 23, NULL, 34000),
(18781269, 'Casio Watch', 0, 11, NULL, 11350),
(28289844, 'Creatine', 1, 32, '2027-11-15', 1320),
(35645478, 'Peanut Butter', 1, 67, '0000-00-00', 460),
(42355275, 'Jerky Meat', 1, 77, '2025-06-06', 170),
(62812284, 'The Last Of Us', 0, 55, NULL, 2420),
(63608282, 'The Last Of Us Part 2', 0, 55, NULL, 4620),
(66127562, 'Blossom Soap', 0, 23, NULL, 264),
(81677579, 'Brave New Word', 0, 76, NULL, 825),
(87967249, 'The Old Man And The Sea', 0, 76, NULL, 1595),
(93337357, 'Whey Protein', 1, 32, '2026-06-12', 2750);

-- --------------------------------------------------------

--
-- Структура таблицы `goodstest`
--

CREATE TABLE `goodstest` (
  `Barcode` int(11) NOT NULL,
  `Product Name` varchar(30) NOT NULL,
  `Product Type` tinyint(1) NOT NULL,
  `Batch Number` int(11) NOT NULL,
  `Best Before` date DEFAULT NULL,
  `Price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `goodstest`
--

INSERT INTO `goodstest` (`Barcode`, `Product Name`, `Product Type`, `Batch Number`, `Best Before`, `Price`) VALUES
(14774246, 'D&G glasses', 0, 23, NULL, 34000),
(18781269, 'Casio Watch', 0, 11, NULL, 11350),
(28289844, 'Creatine', 1, 32, '2027-11-15', 1320),
(35645478, 'Peanut Butter', 1, 67, '0000-00-00', 460),
(42355275, 'Jerky Meat', 1, 77, '2025-06-06', 170),
(62812284, 'The Last Of Us', 0, 55, NULL, 2420),
(63608282, 'The Last Of Us Part 2', 0, 55, NULL, 4620),
(66127562, 'Blossom Soap', 0, 23, NULL, 264),
(81677579, 'Brave New Word', 0, 76, NULL, 825),
(87967249, 'The Old Man And The Sea', 0, 76, NULL, 1595),
(93337357, 'Whey Protein', 1, 32, '2026-06-12', 2750),
(73646926, 'The Masque Of The Red Death', 0, 79, NULL, 1200),
(2147483647, 'The Masque Of The Red Death', 0, 79, NULL, 1200),
(99999999, 'The Masque Of The Red Death', 0, 79, NULL, 1200),
(34184675, 'The Masque Of The Red Death', 0, 79, NULL, 1200),
(57062909, 'The Masque Of The Red Death', 0, 79, NULL, 50),
(74500992, 'The Masque Of The Red Death', 0, 79, NULL, 50);

--
-- Триггеры `goodstest`
--
DELIMITER $$
CREATE TRIGGER `trigger 6` BEFORE INSERT ON `goodstest` FOR EACH ROW BEGIN
IF new.`Barcode`>99999999 OR new.`Barcode`<10000000 THEN
SET new.`Barcode`=FLOOR(RAND()*(99999999-10000000+1))+10000000;
END IF;
IF new.`Price`<0 THEN
SET new.`Price`=50;
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger 7` BEFORE UPDATE ON `goodstest` FOR EACH ROW BEGIN
IF new.`Barcode`>99999999 OR new.`Barcode`<10000000 THEN
SET new.`Barcode`=FLOOR(RAND()*(99999999-10000000+1))+10000000;
END IF;
IF new.`Price`<0 THEN
SET new.`Price`=50;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `multytableview`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `multytableview` (
`Order ID` int(5)
,`Order Date` date
,`Barcode` int(11)
,`Product Name` varchar(30)
,`Quantity` int(11)
);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `Order ID` int(5) NOT NULL,
  `Order Date` date NOT NULL,
  `Barcode` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Customer ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`Order ID`, `Order Date`, `Barcode`, `Quantity`, `Customer ID`) VALUES
(1, '2025-01-15', 62812284, 10, 103),
(2, '2025-01-15', 63608282, 10, 103),
(3, '2025-03-06', 93337357, 51, 104),
(4, '2025-03-06', 28289844, 100, 104),
(5, '2025-02-23', 14774246, 1, 107),
(6, '2025-03-08', 14774246, 1, 108),
(8, '2025-03-30', 81677579, 18, 110),
(9, '2025-03-30', 87967249, 12, 110),
(10, '2025-03-30', 42355275, 100, 109),
(11, '2025-03-31', 93337357, 2, 102),
(12, '2025-03-31', 63608282, 1, 102),
(13, '2025-03-31', 18781269, 1, 101),
(14, '2024-11-14', 66127562, 2, 105),
(15, '2025-01-15', 63608282, 1, 108),
(16, '2025-05-22', 63608282, 45, 103);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `viewgoods`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `viewgoods` (
`Barcode` int(11)
,`Product Name` varchar(30)
,`Product Type` tinyint(1)
,`Batch Number` int(11)
,`Best Before` date
,`Price` float
);

-- --------------------------------------------------------

--
-- Структура для представления `multytableview`
--
DROP TABLE IF EXISTS `multytableview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `multytableview`  AS SELECT `orders`.`Order ID` AS `Order ID`, `orders`.`Order Date` AS `Order Date`, `orders`.`Barcode` AS `Barcode`, `goods`.`Product Name` AS `Product Name`, `orders`.`Quantity` AS `Quantity` FROM (`goods` join `orders`) WHERE `orders`.`Barcode` = `goods`.`Barcode` ;

-- --------------------------------------------------------

--
-- Структура для представления `viewgoods`
--
DROP TABLE IF EXISTS `viewgoods`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewgoods`  AS SELECT `goods`.`Barcode` AS `Barcode`, `goods`.`Product Name` AS `Product Name`, `goods`.`Product Type` AS `Product Type`, `goods`.`Batch Number` AS `Batch Number`, `goods`.`Best Before` AS `Best Before`, `goods`.`Price` AS `Price` FROM `goods` WHERE `goods`.`Price` > 1000 AND `goods`.`Barcode` in (select `orders`.`Barcode` from `orders` where `orders`.`Customer ID` in (select `customers`.`Customer ID` from `customers` where `customers`.`Customer Type` = 1)) ORDER BY `goods`.`Price` ASC ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`Customer ID`),
  ADD UNIQUE KEY `Customer ID` (`Customer ID`);

--
-- Индексы таблицы `goods`
--
ALTER TABLE `goods`
  ADD PRIMARY KEY (`Barcode`),
  ADD UNIQUE KEY `Barcode` (`Barcode`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Order ID`,`Order Date`),
  ADD UNIQUE KEY `Order ID` (`Order ID`),
  ADD KEY `orders_ibfk_1` (`Barcode`),
  ADD KEY `orders_ibfk_2` (`Customer ID`);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Barcode`) REFERENCES `goods` (`Barcode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`Customer ID`) REFERENCES `customers` (`Customer ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
