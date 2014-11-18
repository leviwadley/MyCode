--*  BUSIT 103				Assignment   #7					 DUE DATE :  Consult course calendar

/*	You are to develop SQL statements for each task listed. You should type your SQL statements under  
	each task. You are required to use the INNER JOIN syntax to solve each problem, unless otherwise
	stated. INNER JOIN is ANSI syntax. Even if you have prior experience with joins, you will still use the 
	INNER JOIN syntax and refrain from using any OUTER or FULL joins in modules introducing INNER JOINs. */ 

/*	Submit your .sql file named with your last name, first name and assignment # (e.g., GriggsDebiAssignment6.sql). 
	Submit your file to the instructor using through the course site.  */

/*	Ideas for consideration: Run the statement in stages: Write the SELECT and FROM clauses first 
	and run the statement. Then add the WHERE clause; if it is a compound WHERE clause, add piece 
	at a time. Add the ORDER BY clause. Lastly perform the CAST or CONVERT. When the statement is 
	created in steps, it is easier to isolate the error. Check the number of records returned 
	to see if it makes sense.*/

/*  When there are multiple versions of a field, such as EnglishCountryRegionName, 
	SpanishCountryRegionName, FrenchCountryRegionName, use the English version of the field.*/

--	Do not remove the USE statement
USE AdventureWorksDW2012; 

--1.a.	(4) List the names and locations of AdventureWorks customers who are married.   
--		Show customer key, first name, last name, state name, and country name. Order the list  
--		by country name, state name, last name, and first name in alphabetical order.
--		Check your results. Did you get 10,011 records? 


SELECT CustomerKey, FirstName, LastName, StateProvinceName, CountryRegionCode  
FROM DimCustomer
INNER JOIN DimGeography
ON DimCustomer.GeographyKey = DimGeography.GeographyKey
WHERE MaritalStatus = 'M'
ORDER BY CountryRegionCode ASC, StateProvinceName ASC, LastName ASC, FirstName
;





--1.b.	(2) Copy/paste the statement from 1.a to 1.b. Modify the statement in 1.b to show only  
--		those AdventureWorks customers who are single and from the UK City of Birmingham. 
--		Show customer key, first name, last name, and city name.
--		Change the sort order to list by last name, then first name in alphabetical order.

SELECT CustomerKey, FirstName, LastName, City
FROM DimCustomer
INNER JOIN DimGeography
ON DimCustomer.GeographyKey = DimGeography.GeographyKey
WHERE MaritalStatus = 'S' 
AND CountryRegionCode = 'GB' 
AND City = 'Birmingham'
ORDER BY City ASC,LastName ASC, FirstName ASC
;



--1.c.	(2) Copy/paste statement from 1.b to 1.c. Modify the statement in 1.c to list only   
--		AdventureWorks customers from the UK city of York who are female and own a home. 
--		Show customer key, first name, last name, and home ownership. 
--		Order the list by last name and first name in alphabetical order.
SELECT CustomerKey, FirstName, LastName, HouseOwnerFlag
FROM DimCustomer
INNER JOIN DimGeography
ON DimCustomer.GeographyKey = DimGeography.GeographyKey
WHERE MaritalStatus = 'S' 
AND CountryRegionCode = 'GB' 
AND City = 'York'
AND Gender = 'F'
AND HouseOwnerFlag = 1
ORDER BY LastName ASC, FirstName ASC




--2.a.	(2) Explore the data warehouse using ONLY the DimProduct table. No joins required. Show the 
--		product alternate key, English product name, product key,  standard cost, list price, status, 
--		FinishedGoodFlag, and product subcategory id. Sort on ProductAlternateKey. Notice that some of 
--		the products appear to be duplicates. The name and the alternate key remain the same but the 
--		product is added again with a new product key to track the history of changes to the product 
--		attributes.  For example, look at AWC Logo Cap (CA-1098). Scroll through the list and notice
--		the history of changes to StandardCost and ListPrice and to the value in the Status field.
SELECT 
ProductAlternateKey
,EnglishProductName
,ProductKey
,StandardCost
,ListPrice
,Status
,FinishedGoodsFlag
,ProductSubcategoryKey
FROM
DimProduct
ORDER BY
 ProductAlternateKey ASC
;




--2.b.	You will Write two SELECT statements (no joins required) using the DimProduct table and key in   
--		the row count returned when you run the statement in the place below where you see "List row count..." 
--		1. Show the product key, English product name, and product alternate key for each product only once.
--		Sort on English product name.
--		(1) List row count for the results set for 1. 
SELECT *
FROM DimProduct
DimProduct
--606 rows
SELECT DISTINCT ProductKey, EnglishProductName,  productAlternateKey
FROM
DimProduct
ORDER BY
 EnglishProductName ASC
;




--		2. Show the English product name and product alternate key for each product only once. Sort on English product
--		name. Recall terms like “only once”, “one time”, and "unique" all indicate the need for the DISTINCT keyword.
--		(2) List row count for the results set for 2. 





--2.c.	(4) Join tables to the product table to also show the category and subcategory name for each product.
--		Show the English category name, English subcategory name, English product name, and product alternate key
--		only once--no duplicate rows. Sort the results by the English category name, English subcategory name,  
--		and English product name. The record count will decrease to 295. Some products in the product  
--		table are inventory and are not sold. They don't have a value in the ProductSubcategoryID field and 
--		are removed from the results set by the INNER JOIN. We will explore this more in OUTER JOINs.





--3.a.	(5) List the English name for products purchased over the Internet by customers who indicate education  
--		as Bachelors or Graduate Degree. Show Product key and English Product Name and English Education.   
--		Order the list by English Product name. Show the combination values in a row only once--each row is unique.
--		We are not interested in the customer names because we are looking only at the broad demographics of buyers.
--		Internet sales to customers are recorded in the FactInternetSales table. Did you get 313 rows?





--3.b.	(3) List the English name for products purchased over the Internet by customers who indicate 
--		partial college, bachelors, or graduate degree and own 4 cars. Show Product key and English   
--		Product Name, and English Education. Order the list by English Product name and then by English 
--		Education. Show the combination of values in a row only once--each row is unique.





--4.	(5) List the English name for products purchased over the Internet by customers who work in professional  
--		or management occupations. Show Product key and English Product Name and English Occupation. 
--		Add a meaningful sort. Show the combination of values in a row only once--each row is unique.





--	Question 5 contains exploratory questions. You may wish to read all three questions before beginning. 
--	Seeing the purpose of the questions may help understand the requests. 

--5.a.	(6) List customers who have purchased accessories over the Internet.  Show customer first name, 
--		last name, and English product category. If a customer has purchased accessory items more than once,
--		show only one row for that customer. This means that the customer should not appear twice.
--		Order the list by last name, then first name. Did you return 15,062 records in your results set?





--5.b.	(2) Copy/paste 5.a to 5.b and modify 5.b.  Show customer alternate key, first name, last name, and English 
--		product category. If a customer has purchased accessories more than once, show only one row for that customer.
--		This means that the customer should not appear twice. Order the list by last name, then first name. 





--5.c.	BONUS +2 Why is there a difference between the number of records received in 5a and 5b? 
--		To be eligible for the bonus your answer MUST show as a COMMENT and it must be detailed
--		enough to show that you understand why there fewer customers in 5a than in 5b. Be brief. 
--		This is actually a simple answer. 
 




--6.	(6) List all Internet sales for bikes that occurred during 2006 (Order Date in 2006).  
--		Show Order date, product key, product name, and sales amount for each line item sale.
--		Show the date as mm/dd/yyyy as DateOfOrder. Use CONVERT and look up the style code.
--		Show the list in most recent to oldest order by date and alphabetically by product name.
--		2,677 Rows	





--7.	(5) List all Internet sales of bikes to customers in Lancaster, England during 2007.  
--		Show product key, product name, order date as mm/dd/yyyy, SalesAmount, and City for each line item sale. 
--		Show the list in order alphabetically by product name. If you add fields to verify the results
--		be sure to remove or comment out the fields before submitting the homework. 





--8.	(2) In your own words, write a business question that you can answer by querying the data warehouse.
--		Then write the SQL query using an INNER JOIN that will provide the information that you are seeking.
--		Try it. You get credit for writing a question and trying to answer it. 