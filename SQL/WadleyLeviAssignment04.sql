--*  BUSIT 103           Assignment   #4              DUE DATE:  Consult course calendar
							
/*	You are to develop SQL statements for each task listed. You should type your SQL statements under each task. 
	You should test each SQL statement using the database shown in the USE statement. The SQL statement should 
	execute against that database without errors. */

/*	Submit your .sql file named with your last name, first name and assignment # (e.g., GriggsDebiAssignment4.sql). 
	Submit your file to the instructor using through the course site.  Do not zip the file. */

--Do not remove the USE statement
USE AdventureWorksLT2012;

--1.  (4) Use the SalesLT.Address table to list addresses in the United Kingdom. Select the address1, 
--    city, state/province, country/region and postal code. Sort by state/province and city.

SELECT AddressLine1, City, StateProvince, CountryRegion, PostalCode

FROM SalesLT.Address

WHERE CountryRegion = 'United Kingdom'

ORDER BY StateProvince ASC, City ASC
;



--2.  (5) Use the SalesLT.Address table to list addresses in the UK cities of Lancaster and York. 
--    Select the address1, city, state/province, country/region and postal code. Sort by state/province and city.
SELECT AddressLine1, City, StateProvince, CountryRegion, PostalCode

FROM SalesLT.Address

WHERE CountryRegion = 'United Kingdom' AND (City = 'Lancaster' OR city = 'York') 

ORDER BY StateProvince ASC, City ASC
;





--3.	(4) Use the SalesLT.Address table to list addresses in the cities of Victoria or Vancouver. 
--		Select the address1, city, state/province, country/region and postal code.
--		Order the list by city.

SELECT AddressLine1, City, StateProvince, CountryRegion, PostalCode

FROM SalesLT.Address

WHERE City = 'Victoria' OR city = 'Vancouver' 

ORDER BY StateProvince ASC, City ASC
;




--4.	(5) Use the SalesLT.Address table to list addresses in the cities of Victoria or Vancouver in the 
--		Canadian province of British Columbia. Select the address1, city, state/province, country/region 
--		and postal code. Order the list by city.

FROM SalesLT.Address

WHERE StateProvince = 'British Columbia'AND (City = 'Victoria' OR city = 'Vancouver') 

ORDER BY  City ASC
;



--5.	(4) List the company name and phone for those customers whose phone number begins with 99.
--		Order the list by phone number in ascending order. 

SELECT CompanyName, Phone 

FROM SalesLT.Customer

WHERE Phone LIKE '99%' 

ORDER BY  CompanyName ASC
;



--6.	(4) List the name, product number, size, standard cost, and list price in alphabetical order by name 
--		for Products whose standard cost is $100 or less. Show all money values at exactly two decimal places. 
--		Be sure to give each derived column an alias.

SELECT  Name, ProductNumber, Size, CONVERT(DECIMAL(10,2),StandardCost), CONVERT(DECIMAL(10,2), ListPrice) 
FROM SalesLT.Product
WHERE StandardCost <= 100
ORDER BY Name ASC;



--7.	(4) List the name, product number, size, standard cost, and list price in alphabetical order by Name 
--		for Products whose list price is $1000 or more and standard cost is $700 or less.

SELECT  Name, ProductNumber, Size, CONVERT(DECIMAL(10,2),StandardCost), CONVERT(DECIMAL(10,2), ListPrice) 
FROM SalesLT.Product
WHERE ListPrice >= 1000 AND StandardCost <= 700
ORDER BY Name ASC;




--8.	(4) List the name, standard cost, list price, and size for products whose size is one of the 
--		following:  S, M, L. Show all money values at exactly two decimal places. Be sure to 
--		give each derived column an alias. Order the list by name in alphabetical order.

SELECT  Name, CONVERT(DECIMAL(10,2),StandardCost),  CONVERT(DECIMAL(10,2), ListPrice),  Size
FROM SalesLT.Product
WHERE Size = 'S' OR Size = 'M' OR Size = 'L'
ORDER BY Name ASC;





--9.	(4) List the name, product number, and sell end date for all products in the Product table
--		that are not currently sold. Sort by the sell end date from most recent to oldest date. Show   
--		only the date (no time) in the sell end date field. Be sure to give each derived column an alias.

SELECT  Name, ProductNumber, CONVERT(DATE , SellEndDate) AS TerminationOfSale 
FROM SalesLT.Product
WHERE SellEndDate IS NOT NULL
ORDER BY SellEndDate ASC ;




--10.  (6) List the name, product number, standard cost, list price, and weight for products whose standard cost  
--    is greater than $400, list price is less than $800, and weight is greater than 10,000. Round money values 
--    to exactly 2 decimal places and give each derived column a meaningful alias. Sort by weight.


SELECT  Name, ProductNumber, CONVERT(DECIMAL(10,2), StandardCost) AS WholeCost ,CONVERT(DECIMAL(10,2) ,  ListPrice) AS WholeSale, Weight 
FROM SalesLT.Product
WHERE StandardCost > 400 AND ListPrice < 800 AND Weight > 10000 
ORDER BY SellEndDate ASC ;




--11. In a and b below, explore the data to better understand how to locate products. 

--a.  (3) List the name, product number, and product category ID for all products in the Product 
--    table that include 'bike' in the name. Sort by the name. 
--    Something to consider: How many of these products are actually bikes?

SELECT  Name, ProductNumber, ProductCategoryID 
FROM SalesLT.Product
WHERE Name CONTAINS '%bike%' 
ORDER BY Name ASC ;

-- None were Bikes


--b.  (3) List the name and product category id, and parent id for all categories in the product category   
--    table that include 'bike' in the name. Sort by the parent product category id. 
--    Something to consider: How many of these product categories are actually bikes? What is the  
--	  ProductCategoryID for Bikes? 
	
SELECT  Name, ProductCategoryID, ParentProductCategoryID
FROM SalesLT.ProductCategory
WHERE Name LIKE '%bike%' 
ORDER BY ParentProductCategoryID ASC ;

-- 4/6 are Bikes.
-- Bikes ParentProductCategoryID is NULL



