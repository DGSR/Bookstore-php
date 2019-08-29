SET NAMES 'utf8';
-- Set default database
USE `base-bookstore`;
DROP TABLE IF EXISTS shopping_cart;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS registry;
DROP TABLE IF EXISTS receipts;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS publishers;
DROP TABLE IF EXISTS branch;
DROP TABLE IF EXISTS cities;
-- Set default database
USE `base-bookstore`;
-- Create table `cities`
--
CREATE TABLE cities (
  ID_City INT(11) NOT NULL AUTO_INCREMENT,
  City_Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID_City)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_general_ci;
-- Create table `branch`
--
CREATE TABLE branch (
  ID_Branch INT(11) NOT NULL AUTO_INCREMENT,
  Address VARCHAR(255) NOT NULL,
  ID_City INT(11) NOT NULL,
  PRIMARY KEY (ID_Branch)
)
ENGINE = INNODB,
AUTO_INCREMENT = 5,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create foreign key
--
ALTER TABLE branch 
  ADD CONSTRAINT FK_branch_ID_City FOREIGN KEY (ID_City)
    REFERENCES cities(ID_City) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Create table `publishers`
--
CREATE TABLE publishers (
  ID_Publisher INT(11) NOT NULL AUTO_INCREMENT,
  Publisher_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID_Publisher)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create table `genres`
--
CREATE TABLE genres (
  ID_Genre INT(11) NOT NULL AUTO_INCREMENT,
  Genre_Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID_Genre)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_general_ci;
--
-- Create table `authors`
--
CREATE TABLE authors (
  ID_Author INT(11) NOT NULL AUTO_INCREMENT,
  Author_Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID_Author)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_general_ci;
--
-- Create table `book`
--
CREATE TABLE book (
  ID_Book INT(11) NOT NULL AUTO_INCREMENT,
  Vendor_Code VARCHAR(255) NOT NULL,
  Publication_Year INT(11) NOT NULL,
  Book_Name VARCHAR(255) NOT NULL,
  ID_Genre INT(11) NOT NULL,
  ID_Author INT(11) NOT NULL,
  ID_Publisher INT(11) NOT NULL,
  PRIMARY KEY (ID_Book)
)
ENGINE = INNODB,
AUTO_INCREMENT = 9,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8,
COLLATE utf8_general_ci;
--
-- Create index `UK_book_Vendor_Code` on table `book`
--
ALTER TABLE book 
  ADD UNIQUE INDEX UK_book_Vendor_Code(Vendor_Code);
--
-- Create foreign key
--
ALTER TABLE book 
  ADD CONSTRAINT FK_book_ID_Author FOREIGN KEY (ID_Author)
    REFERENCES authors(ID_Author) ON DELETE NO ACTION;
--
-- Create foreign key
--
ALTER TABLE book 
  ADD CONSTRAINT FK_book_ID_Genre FOREIGN KEY (ID_Genre)
    REFERENCES genres(ID_Genre) ON DELETE NO ACTION;
--
-- Create foreign key
--
ALTER TABLE book 
  ADD CONSTRAINT FK_book_ID_Publisher FOREIGN KEY (ID_Publisher)
    REFERENCES publishers(ID_Publisher) ON DELETE NO ACTION;
--
-- Create table `receipts`
--
CREATE TABLE receipts (
  ID_Receipt INT(11) NOT NULL AUTO_INCREMENT,
  Receipt_Amount INT(11) NOT NULL,
  Receipt_Date DATE NOT NULL,
  ID_Branch INT(11) NOT NULL,
  ID_Book INT(11) NOT NULL,
  PRIMARY KEY (ID_Receipt)
)
ENGINE = INNODB,
AUTO_INCREMENT = 11,
AVG_ROW_LENGTH = 2048,
CHARACTER SET utf8,
COLLATE utf8_general_ci;
--
-- Create foreign key
--
ALTER TABLE receipts 
  ADD CONSTRAINT FK_receipt_ID_Book FOREIGN KEY (ID_Book)
    REFERENCES book(ID_Book) ON DELETE NO ACTION;
-
-- Create foreign key
--
ALTER TABLE receipts 
  ADD CONSTRAINT FK_receipt_ID_Branch FOREIGN KEY (ID_Branch)
    REFERENCES branch(ID_Branch) ON DELETE NO ACTION;
--
-- Create table `registry`
--
CREATE TABLE registry (
  ID_User INT(11) NOT NULL AUTO_INCREMENT,
  Login VARCHAR(255) NOT NULL,
  Password VARCHAR(255) NOT NULL,
  User_Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID_User)
)
ENGINE = INNODB,
AUTO_INCREMENT = 6,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8,
COLLATE utf8_general_ci;
--
-- Create index `UK_registry` on table `registry`
--
ALTER TABLE registry 
  ADD UNIQUE INDEX UK_registry(Login, Password);
--
-- Create table `orders`
--
CREATE TABLE orders (
  ID_Order INT(11) NOT NULL AUTO_INCREMENT,
  Order_Date DATE NOT NULL,
  Status VARCHAR(255) NOT NULL,
  ID_User INT(11) NOT NULL,
  PRIMARY KEY (ID_Order)
)
ENGINE = INNODB,
AUTO_INCREMENT = 23,
AVG_ROW_LENGTH = 1365,
CHARACTER SET utf8,
COLLATE utf8_general_ci;
--
-- Create foreign key
--
ALTER TABLE orders 
  ADD CONSTRAINT FK_orders_ID_User FOREIGN KEY (ID_User)
    REFERENCES registry(ID_User) ON DELETE NO ACTION;
--
-- Create table `shopping_cart`
--
CREATE TABLE shopping_cart (
  ID_Cart INT(11) NOT NULL AUTO_INCREMENT,
  ID_Order INT(11) NOT NULL,
  ID_Receipt INT(11) NOT NULL,
  Amount DECIMAL(8, 0) NOT NULL DEFAULT 1,
  PRIMARY KEY (ID_Cart)
)
ENGINE = INNODB,
AUTO_INCREMENT = 15,
AVG_ROW_LENGTH = 2048,
CHARACTER SET utf8,
COLLATE utf8_general_ci;
--
-- Create foreign key
--
ALTER TABLE shopping_cart 
  ADD CONSTRAINT FK_shopping_cart_ID_Book FOREIGN KEY (ID_Receipt)
    REFERENCES receipts(ID_Receipt) ON DELETE NO ACTION;
--
-- Create foreign key
--
ALTER TABLE shopping_cart 
  ADD CONSTRAINT FK_shopping_cart_ID_Order FOREIGN KEY (ID_Order)
    REFERENCES orders(ID_Order) ON DELETE NO ACTION;
-- 
-- Dumping data for table cities
--
INSERT INTO cities VALUES
(1, 'Saint-Petersburg'),
(2, 'Munich'),
(3, 'Paris');
-- 
-- Dumping data for table publishers
--
INSERT INTO publishers VALUES
(1, 'Piter'),
(2, 'Writers'),
(3, 'Reclam');
-- 
-- Dumping data for table genres
--
INSERT INTO genres VALUES
(1, 'Science Fiction'),
(2, 'Dystopia'),
(3, 'Thriller');
-- 
-- Dumping data for table authors
--
INSERT INTO authors VALUES
(1, 'MacNilson'),
(2, 'Chernishow'),
(3, 'Kurtz');
-- 
-- Dumping data for table branch
--
INSERT INTO branch VALUES
(1, 'Nevskij Prospect 11', 1),
(2, 'Big street 2', 3),
(3, 'Forstenrieder Allee 251', 2),
(4, 'Coup de tat alley 4', 1);
-- 
-- Dumping data for table book
--
INSERT INTO book VALUES
(1, '111', 2018, 'Jupiter', 1, 3, 3),
(2, '102', 1998, 'Trash', 3, 2, 1),
(3, '110', 2015, 'Dystopia 101', 2, 1, 3),
(4, '105', 2005, 'Pluto', 1, 3, 1),
(5, '118', 2019, 'Black Hole', 1, 3, 3),
(6, '103', 1999, 'Trash 2: Comeback', 3, 2, 2),
(7, '104', 2000, 'Trash 3: Crawlback', 3, 2, 2),
(8, '107', 2017, 'Love and Dirt', 2, 1, 3);
-- 
-- Dumping data for table registry
--
INSERT INTO registry VALUES
(1, 'ivan', '12345qwerty', 'IvanTerrible'),
(2, 'FreiCorp', 'Frei101Co45', 'Frei Corporation'),
(3, 'B2C', 'Big2Company', 'Big Company'),
(4, 'alexander.is@gmail.com', 'Al45$der03', 'Alexander'),
(5, 'admin', 'admin', 'admin');
-- 
-- Dumping data for table receipts
--
INSERT INTO receipts VALUES
(1, 2000, '2018-04-17', 1, 1),
(2, 5000, '2018-03-10', 3, 1),
(3, 1500, '2018-09-01', 2, 1),
(4, 100, '2000-04-01', 2, 2),
(5, 50, '2001-04-01', 2, 6),
(6, 25, '2022-04-01', 2, 7),
(7, 600, '2006-03-03', 4, 4),
(8, 850, '2017-12-31', 1, 8),
(9, 600, '2019-05-01', 3, 3),
(10, 800, '2019-05-02', 1, 5);

-- 
-- Dumping data for table orders
--
INSERT INTO orders VALUES
(1, '2015-04-01', 'Shipped', 4),
(3, '2019-04-10', 'Paid', 1),
(4, '2019-04-11', 'Picked', 1),
(5, '2019-03-07', 'Shipped', 2),
(6, '2018-09-01', 'Package Missing', 3),
(7, '2018-09-01', 'Shipped', 2),
(8, '2019-04-15', 'Paid', 4),
(13, '2019-05-30', 'Order Formed', 2),
-- 
-- Dumping data for table shopping_cart
--
INSERT INTO shopping_cart VALUES
(1, 3, 4, 1),
(2, 4, 5, 2),
(3, 1, 8, 1),
(4, 5, 2, 100),
(5, 6, 6, 10),
(6, 8, 7, 3),
(7, 7, 1, 5),
(8, 5, 8, 50),
(10, 13, 8, 2),
(11, 14, 1, 100),
(12, 15, 6, 2),
