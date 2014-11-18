--*  BUSIT 103                    Assignment   #6                      DUE DATE :  Consult course calendar
							
/*	You are to develop SQL statements for each task listed. You should type your SQL statements under 
--each task. You are required to use INNER JOINs to solve each problem. Even if you know another method 
--that will produce the result, this module is practice in using the INNER JOIN.  */

/*	Submit your .sql file named with your last name, first name and assignment # (e.g., GriggsDebiAssignment6.sql). 
	Submit your file to the instructor using through the course site.  */

--NOTE: We are now using a different database. 
USE AdventureWorks2012;

/*  Reminder: You are required to use the INNER JOIN syntax to solve each problem. INNER JOIN is ANSI syntax. 
	It is generally considered more readable, especially when joining many tables. Even if you have prior 
	experience with joins, you will still use the INNER JOIN syntax and refrain from using any OUTER or 
	FULL joins in Modules 6 and 7 covering INNER JOINs. */

--1.a.	(4) List any products that have product reviews.  Show product name, product line, product ID, 
--		and comments. Sort alphabetically on the product line. Don’t over complicate this. A correctly  
--		written INNER JOIN will return only those products that have product reviews; i.e., matching values 
--		in the linking field. Hint:  Use the Production.Product and Production.ProductReview tables.

SELECT Name, ProductLine,Product.ProductID, Comments
FROM Production.Product
INNER JOIN Production.ProductReview
ON Product.ProductID = ProductReview.ProductID
ORDER BY ProductLine ASC;



--1.b.	(2) Copy/paste 1.a. to 1.b. then modify 1.b. to show only records in which the word 'easy' is 
--		found in the Comments field. Show product ID, product line, product name, and comments. 
--		Sort on product name. 
SELECT Name, ProductLine,Product.ProductID, Comments
FROM Production.Product
INNER JOIN Production.ProductReview
ON Product.ProductID = ProductReview.ProductID
WHERE Comments LIKE '%easy%' 
ORDER BY Name ASC;




--2.a.	(5) List product models with product info. Show the product model ID, model name, product line,
--		product name, standard cost, and class. Round all money values to exactly two decimal places. 
--		Be sure to give any derived fields an alias. Order by standard cost from highest to lowest.
--		Hint: You know you need to use the Product table. Now look for a related table that contains  
--		the information about the product model and inner join it to Product on the linking field.  

SELECT ProductModel.ProductModelID, ProductModel.Name, ProductLine,
		Product.Name, CAST(StandardCost AS DEC(10,2)) AS StdCost, Class
FROM Production.ProductModel
INNER JOIN Production.Product
ON ProductModel.Name = Product.Name
ORDER BY StandardCost DESC;



--2.b.	(2) Copy/paste 2.a. to 2.b. then modify 2.b. to list only products without a value in the  
--		product line field. Do this using NULL appropriately in the WHERE clause. Hint: Remember
--		that nothing is ever equal (or not equal) to NULL; it either is or it isn't NULL.
	
SELECT ProductModel.ProductModelID, ProductModel.Name, ProductLine,
		Product.Name, CAST(StandardCost AS DEC(10,2)) AS StdCost, Class
FROM Production.ProductModel
INNER JOIN Production.Product
ON ProductModel.Name = Product.Name
Where ProductLine IS NULL
ORDER BY StandardCost DESC;




--2.c.	(2) Copy/paste 2.b. to 2.c. then modify 2.c. to list only products that do not contain 
--		a value in the product line field AND contain 'fork' or 'front' in the product model name. 
--		Be sure to use parentheses appropriately.

SELECT ProductModel.ProductModelID, ProductModel.Name, ProductLine,
		Product.Name, CAST(StandardCost AS DEC(10,2)) AS StdCost, Class
FROM Production.ProductModel
INNER JOIN Production.Product
ON ProductModel.Name = Product.Name
Where ProductLine IS NULL AND Product.Name Like '%fork%' 
ORDER BY StandardCost DESC;




--3. a.	(6) List Product categories, their subcategories and their products.  Show the category name, 
--		subcategory name, product ID, and product name, in this order. Sort in alphabetical order on 
---		category name, subcategory name, and product name, in this order. Give each Name field a 
--		descriptive alias. For example, the Name field in the Product table will have the alias ProductName.
--		Hint:  To understand the relationships, create a database diagram with the following tables:
--		Production.ProductCategory
--		Production.ProductSubCategory
--		Production.Product

SELECT ProductCategory.ProductCategoryID,
ProductCategory.Name AS 'ProductCategoryName',
ProductSubCategory.ProductSubcategoryID,
ProductSubCategory.Name AS 'ProductSubcategoryName', 
Product.ProductID, Product.Name AS 'ProductName'
FROM Production.ProductCategory
INNER JOIN Production.ProductSubcategory
ON ProductCategory.ProductCategoryID = ProductSubCategory.ProductCategoryID
INNER JOIN Production.Product 
ON ProductSubCategory.ProductSubCategoryID = Product.ProductSubCategoryID 
ORDER BY ProductCategory.Name ASC, ProductSubCategory.Name ASC, Product.Name ASC;



--3. b.	(3) Copy/paste 3.a. to 3.b. then modify 3.b. to list only Products in product category 1.  
--		Show the category name, subcategory name, product ID, and product name, in this order. Sort in 
--		alphabetical order on product name, subcategory name, and product name. 
--		Hint: Add product category id field to SELECT clause, make sure your results are correct, then 
--		remove or comment out the field.  Something to consider: Look at the data in the ProductName field. 
--		Could we find bikes by searching for 'bike' in the ProductName field?

SELECT ProductCategory.ProductCategoryID,
ProductCategory.Name AS 'ProductCategoryName',
--ProductSubCategory.ProductSubcategoryID,
ProductSubCategory.Name AS 'ProductSubcategoryName', 
Product.ProductID, Product.Name AS 'ProductName'
FROM Production.ProductCategory
INNER JOIN Production.ProductSubcategory
ON ProductCategory.ProductCategoryID = ProductSubCategory.ProductCategoryID
INNER JOIN Production.Product 
ON ProductSubCategory.ProductSubCategoryID = Product.ProductSubCategoryID 
WHERE ProductCategory.ProductCategoryID = 1
ORDER BY ProductCategory.Name ASC, ProductSubCategory.Name ASC, Product.Name ASC;




--3. c.	(2) Copy/paste 3.b. to 3.c. then modify 3.c. to list Products in product category 2. 
--		Make no other changes to the statement. Consider what kinds of products are in category 2. 

SELECT ProductCategory.ProductCategoryID,
ProductCategory.Name AS 'ProductCategoryName',
--ProductSubCategory.ProductSubcategoryID,
ProductSubCategory.Name AS 'ProductSubcategoryName', 
Product.ProductID, Product.Name AS 'ProductName'
FROM Production.ProductCategory
INNER JOIN Production.ProductSubcategory
ON ProductCategory.ProductCategoryID = ProductSubCategory.ProductCategoryID
INNER JOIN Production.Product 
ON ProductSubCategory.ProductSubCategoryID = Product.ProductSubCategoryID 
WHERE ProductCategory.ProductCategoryID = 2
ORDER BY ProductCategory.Name ASC, ProductSubCategory.Name ASC, Product.Name ASC;



--4.a.	(5) List Product models, the categories, the subcategories, and the products.  Show the model name, 
--		category name, subcategory name, product ID, and product name in this order. Give each Name field a   
--		descriptive alias. For example, the Name field in the ProductModel table will have the alias ModelName.
--		Sort in alphabetical order first by category name and then subcategory name.
--		Hint:  To understand the relationships, create a database diagram with the following tables:
--		Production.ProductCategory
--		Production.ProductSubCategory
--		Production.Product
--		Production.ProductModel
--		Choose a path from one table to the next and follow it in a logical order to create the inner joins

Select ProductModel.Name AS 'ModelName', 
ProductCategory.Name AS 'ProductCategoryName',
ProductSubCategory.Name AS 'ProductSubcategoryName', 
Product.ProductID, Product.Name AS 'ProductName'
FROM Production.ProductCategory
INNER JOIN Production.ProductSubcategory
ON ProductCategory.ProductCategoryID = ProductSubCategory.ProductCategoryID
INNER JOIN Production.Product 
ON ProductSubCategory.ProductSubCategoryID = Product.ProductSubCategoryID 
INNER JOIN Production.ProductModel
ON Product.ProductModelID = ProductModel.ProductModelID  
ORDER BY ProductCategory.Name ASC, ProductSubCategory.Name ASC
;



--4. b.	(3) Copy/paste 4.a. to 4.b. then modify 4.b. to list those products in product model ID 10 that  
--		contain 'yellow' in the product name. Modify the sort to order only on Product ID. Hint: Add the 
--		product model id field to the select clause to check your results and then remove or comment it out.

Select ProductModel.Name AS 'ModelName', 
--ProductCategory.ProductCategoryID,
ProductCategory.Name AS 'ProductCategoryName',
--ProductSubCategory.ProductSubcategoryID,
ProductSubCategory.Name AS 'ProductSubcategoryName', 
Product.ProductID, Product.Name AS 'ProductName'
FROM Production.ProductCategory
INNER JOIN Production.ProductSubcategory
ON ProductCategory.ProductCategoryID = ProductSubCategory.ProductCategoryID
INNER JOIN Production.Product 
ON ProductSubCategory.ProductSubCategoryID = Product.ProductSubCategoryID 
INNER JOIN Production.ProductModel
ON Product.ProductModelID = ProductModel.ProductModelID  
WHERE ProductModel.ProductModelID = 10 AND Product.Name LIKE '%yellow%'
ORDER BY Product.ProductID ASC;



--5.	a. (4) List products that were ordered by customer id 29581.  Show product name, product number, order 
--		quantity, and sales order id.  Sort on product name and sales order id.  If you add customer id to check your 
--		results, be sure to remove or comment it out. Hint:  First create a database diagram with the following tables:
--		Production.Product
--		Sales.SalesOrderHeader
--		Sales.SalesOrderDetail
Select Product.Name AS 'ProductName', Product.ProductNumber, SalesOrderDetail.OrderQty,
SalesOrderDetail.SalesOrderID 	
FROM Production.Product
INNER JOIN Sales.SalesOrderDetail
ON Product.ProductID = SalesOrderDetail.ProductID
INNER JOIN Sales.SalesOrderHeader
ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
WHERE SalesOrderHeader.CustomerID LIKE '29581' 
ORDER BY Product.Name ASC, SalesOrderID ASC
;




--5. b. (4) List the orders and the shipping method for customer id 29581.  We are only concerned with orders
--		that have a shipping method, so don't screen for NULL. Show product name, product number, order quantity,
--		sales order id, and the name of the shipping method. Sort on product name and sales order id.
--		HINT:  You will need to join an additional table. Add it to your database diagram first, then write
--		the statement. 

Select Product.Name AS 'ProductName', Product.ProductNumber, SalesOrderDetail.OrderQty,
SalesOrderDetail.SalesOrderID, ShipMethod.Name 	
FROM Production.Product
INNER JOIN Sales.SalesOrderDetail
ON Product.ProductID = SalesOrderDetail.ProductID
INNER JOIN Sales.SalesOrderHeader
ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
INNER JOIN Purchasing.ShipMethod 
ON SalesOrderHeader.ShipMethodID = ShipMethod.ShipMethodID 
WHERE SalesOrderHeader.CustomerID LIKE '29581' 
ORDER BY Product.Name ASC, SalesOrderID ASC
;



--6.	(6) List all sales for components that were ordered during 2008.  Show sales order id, product ID, 
--		product name, order quantity, and line total for each line item sale. Make certain you are  
--		retrieving only components. There are multiple ways to find components. Show the results  
--		by sales order id and product name. Hint: Refer to the diagram you created in #5. 
Select 
SalesOrderDetail.SalesOrderID,
Product.ProductID,
Product.Name AS 'ProductName', 
Product.ProductNumber,
SalesOrderDetail.OrderQty,
SalesOrderDetail.LineTotal


FROM Production.ProductCategory
INNER JOIN Production.ProductSubcategory
ON ProductCategory.ProductCategoryID = ProductSubCategory.ProductCategoryID
INNER JOIN Production.Product 
ON ProductSubCategory.ProductSubCategoryID = Product.ProductSubCategoryID 
INNER JOIN Sales.SalesOrderDetail
ON Product.ProductID = SalesOrderDetail.ProductID
INNER JOIN Sales.SalesOrderHeader
ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
INNER JOIN Purchasing.ShipMethod 
ON SalesOrderHeader.ShipMethodID = ShipMethod.ShipMethodID 
WHERE ProductCategory.ProductCategoryID = 2 AND SalesOrderHeader.OrderDate BETWEEN '2008-01-01' AND '2008-12-31'
ORDER BY  SalesOrderID ASC, ProductName;



	
--7.  (2) In your own words, write a business question for AdventureWorks that you will try to answer 
--    with a SQL query. Then try to develop the SQL to answer the question using at least one INNER JOIN.
--    You may find that the AdventureWorks database structure is highly normalized and therefore, difficult 
--    to work with.  As a result, you may not run into difficulties when developing your SQL. For this task 
--    that is fine. Just show your question and as much SQL as you were able to figure out. 

--

--	QUESTION: Between the start of 2006, till the end of 2008 which types of bikes sold made us the best profit,
--	and of those bikes are there any particular color which sold worse than the others.
--
SELECT Product.Name, Color, 
--ProductCategory.ProductCategoryID, 
--ProductCategory.Name AS 'CName', 
--ProductSubcategory.ProductSubcategoryID,
ProductSubcategory.Name AS 'PSName',
SalesOrderDetail.OrderQTY,
SalesOrderHeader.SubTotal, CAST(SalesOrderHeader.OrderDate AS DATE) AS 'DateSold'

FROM Production.ProductCategory
INNER JOIN Production.ProductSubcategory
ON ProductCategory.ProductCategoryID = ProductSubCategory.ProductCategoryID
INNER JOIN Production.Product 
ON ProductSubCategory.ProductSubCategoryID = Product.ProductSubCategoryID 
INNER JOIN Sales.SalesOrderDetail
ON Product.ProductID = SalesOrderDetail.ProductID
INNER JOIN Sales.SalesOrderHeader
ON SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
WHERE ProductCategory.ProductCategoryID = 1
AND ProductSubCategory.ProductSubCategoryID < 4
AND SalesOrderHeader.OrderDate BETWEEN '2006-01-01' AND '2008-12-31'
ORDER BY Product.Name ASC, Color DESC, OrderQty ASC, OrderDate ASC 
;

-- The format of the data will assist getting a handle on products sold between the two dates.
-- Even better would be to get the total prices from all the bikes sold, which can be done.
