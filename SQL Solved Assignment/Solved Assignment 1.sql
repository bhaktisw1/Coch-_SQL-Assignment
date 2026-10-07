---Assignment 1--

---basic question----

---1)Create two Databases Name :- Brands , and Products--
CREATE DATABASE Brands;
create database product;

---2.) Create two tables in SQL Server name as ITEMS_TABLE
---in Brands database and PRODUCT_TABLE in Products----
---database.----

USE Brands;
CREATE TABLE ITEMS_TABLE(
    Item_id INT,
    Item_description VARCHAR(255),
    Bottle_size INT,
    Bottle_price DECIMAL(10,2),
    Vendor_name VARCHAR(255),
    Vendor_nos INT
);

USE Product;
CREATE TABLE PRODUCTS_SALES_TABLE(
    Product_Id INT,
    Country VARCHAR(100),
    Year INT,
    Month_Name VARCHAR(50),
    Units_Sold DECIMAL(10,2),
    Manufacturing_Price DECIMAL(10,2),
    Sale_Price DECIMAL(10,2),
    Gross_Sales DECIMAL(10,2),
    Profit DECIMAL(10,2),
    COGS DECIMAL(10,2),
    Total_Sales DECIMAL(10,2)
);

----3)After Creating both the tables Add records in that tables---



---4) Delete those product having the Units Sold 1618.5 , 888
---and 2470.----

USE Product;
DELETE FROM PRODUCTS_SALES_TABLE
WHERE Units_Sold IN (1618.5, 888, 2470);

---5) Select all records from the ITEMS_TABLE table.---

USE Brands;
SELECT * FROM ITEMS_TABLE;

---6). Select the item_description and bottle_price for all items
--in the ITEMS_TABLE table.---


SELECT Item_description, Bottle_price FROM ITEMS_TABLE;


--7.) Find the item_description and bottle_price of items
--where bottle_price is greater than 20.--


SELECT Item_description, Bottle_price FROM ITEMS_TABLE
WHERE Bottle_price > 20;


--8.) Select Unique Country from the product_sales table--

USE Product;
SELECT DISTINCT Country FROM PRODUCTS_SALES_TABLE;


---9.) Count the number of Countries in the product_sales table--

SELECT COUNT(DISTINCT Country) AS Country_Count FROM PRODUCTS_SALES_TABLE;

--10. How Many Countries are there which contain the
--sales price between 10 to 20--


SELECT DISTINCT Country FROM PRODUCTS_SALES_TABLE
WHERE Sale_Price BETWEEN 10 AND 20;



--intermediate Question---

--1) Find the Total Sale Price and Gross Sales--

SELECT SUM(Sale_Price) AS Total_Sale_Price, SUM(Gross_Sales) AS Total_Gross_Sales
FROM PRODUCTS_SALES_TABLE;

--2) In which year we have got the highest sales


SELECT TOP 1 Year, SUM(Total_Sales) AS Total_Sales
FROM PRODUCTS_SALES_TABLE
GROUP BY Year
ORDER BY Total_Sales DESC;

--3.) Which Product having the sales of $ 37,050.00

SELECT Product_Id, Country FROM PRODUCTS_SALES_TABLE
WHERE Total_Sales = 37050.00;


--4) Which Countries lies between profit of $ 4,605 to $ 22 , 662.00--

SELECT DISTINCT Country FROM PRODUCTS_SALES_TABLE
WHERE Profit BETWEEN 4605 AND 22662;


---5.) Which Product Id having the sales of $ 24 , 700.00

SELECT Product_Id FROM PRODUCTS_SALES_TABLE
WHERE Total_Sales = 24700.00;

--6)Total Units Sold for each Country--

SELECT Country, SUM(Units_Sold) AS Total_Units_Sold
FROM PRODUCTS_SALES_TABLE
GROUP BY Country;


--7) Find the average sales for each country

SELECT Country, AVG(Total_Sales) AS Avg_Sales
FROM PRODUCTS_SALES_TABLE
GROUP BY Country;

--8) Retrieve all products sold in 2014

SELECT * FROM PRODUCTS_SALES_TABLE WHERE Year = 2014;


--9)Find the maximum Profit in the product_sales table.

SELECT MAX(Profit) AS Max_Profit FROM PRODUCTS_SALES_TABLE;


--10) Retrieve the records from product_sales where Profit is
--greater than the average Profit of all records.--

SELECT * FROM PRODUCTS_SALES_TABLE
WHERE Profit > (SELECT AVG(Profit) FROM PRODUCTS_SALES_TABLE);


--11) Find the item_description having the bottle size of 750---

USE Brands;
SELECT Item_description FROM ITEMS_TABLE WHERE Bottle_size = 750;

--12) Find the vendor Name having the vendor_nos 305 , 380 ,--
--391--

SELECT Vendor_name FROM ITEMS_TABLE
WHERE Vendor_nos IN (305,380,391);


---13) What is total Bottle_price

SELECT SUM(Bottle_price) AS Total_Bottle_Price FROM ITEMS_TABLE;


---14)Make Primary Key to Item_id

ALTER TABLE ITEMS_TABLE ADD PRIMARY KEY (Item_id);


---15)Item id having bottle_price of $5.06

SELECT Item_id FROM ITEMS_TABLE WHERE Bottle_price = 5.06;


----Advance Question ----

--1) Joins on both tables (assuming common field = Vendor_nos)--

SELECT * FROM Brands.dbo.ITEMS_TABLE i
INNER JOIN Product.dbo.PRODUCTS_SALES_TABLE p
ON i.Vendor_nos = p.Product_Id;

SELECT * FROM Brands.dbo.ITEMS_TABLE i
LEFT JOIN Product.dbo.PRODUCTS_SALES_TABLE p
ON i.Vendor_nos = p.Product_Id;

SELECT * FROM Brands.dbo.ITEMS_TABLE i
FULL OUTER JOIN Product.dbo.PRODUCTS_SALES_TABLE p
ON i.Vendor_nos = p.Product_Id;


--2)Description and Product having gross sales 13,320.00--

SELECT i.Item_description, p.Product_Id FROM Brands.dbo.ITEMS_TABLE i
INNER JOIN Product.dbo.PRODUCTS_SALES_TABLE p
ON i.Vendor_nos = p.Product_Id
WHERE p.Gross_Sales = 13320.00;


--3)Split Item_description into 2 columns---

ALTER TABLE ITEMS_TABLE ADD Item_desc1 VARCHAR(150), Item_desc2 VARCHAR(150);

UPDATE ITEMS_TABLE
SET Item_desc1 = PARSENAME(REPLACE(Item_description,' ',' .'),2),
    Item_desc2 = PARSENAME(REPLACE(Item_description,' ',' .'),1);


--4)Top 3 expensive items--

SELECT TOP 3 * FROM ITEMS_TABLE ORDER BY Bottle_price DESC;




---5) Vendor and description for 750ml and price < 10

SELECT Vendor_name, Item_description FROM ITEMS_TABLE
WHERE Bottle_size = 750 AND Bottle_price < 10;





---Duplicate vendor_nos appearing more than once

SELECT Item_description, Vendor_name FROM ITEMS_TABLE
WHERE Vendor_nos IN (
    SELECT Vendor_nos FROM ITEMS_TABLE GROUP BY Vendor_nos HAVING COUNT(*) > 1
);


---super advance question---

--1) Find the item_description and bottle_price of items that have
--the same vendor_name as items with Item_Id 1.--


SELECT Item_description, Bottle_price FROM ITEMS_TABLE
WHERE Vendor_name = (SELECT Vendor_name FROM ITEMS_TABLE WHERE Item_id = 1);

--2) Create a stored procedure to retrieve all records from the
--ITEMS_TABLE table where bottle_price is greater than a given
--value--

CREATE PROCEDURE sp_GetItemsByPrice @price DECIMAL(10,2)
AS
BEGIN
    SELECT * FROM ITEMS_TABLE WHERE Bottle_price > @price;
END;
