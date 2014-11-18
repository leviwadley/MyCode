--*  BUSIT 103           Assignment   #8              DUE DATE:  Consult course calendar
							
--You are to develop SQL statements for each task listed.  
--You should type your SQL statements under each task.  

/*	Submit your .sql file named with your last name, first name and assignment # (e.g., GriggsDebiAssignment8.sql). 
	Submit your file to the instructor using through the course site.  */

/*	Ideas for consideration: Run the statement in stages: Write the SELECT and FROM clauses first 
	and run the statement. Add the ORDER BY clause. Then add the WHERE clause; if it is a compound
	WHERE clause, add piece at a time. Remember that the order in which the joins are processed does make 
	a difference with OUTER JOINs. 
	You will not use Cross-Joins, Full Outer Joins, or Unions in the required exercises. All are to be 
	accomplished with outer joins or a combination of outer and inner joins using ANSI standard Join syntax. */

--	Do not remove the USE statement
USE AdventureWorksDW2012; 

--NOTE:	When the task does not specify sort order, it is your responsibility to order the information
--		so that is easy to interpret. 

--1.a.	(3) List the customer key, first and last name of ALL customers and the date, subcategory name 
--		and category name for surveys to which they have responded. (DimCustomer and FactSurveyResponse).
--		Add a meaningful sort.
SELECT dimCustomer.CustomerKey, FirstName, LastName, 
CONVERT(DATE,FactSurveyResponse.Date) AS 'YYYY/MM/DD', EnglishProductSubcategoryName, EnglishProductCategoryName
FROM dbo.DimCustomer
RIGHT OUTER JOIN dbo.FactSurveyResponse
ON dimCustomer.CustomerKey = FactSurveyResponse.CustomerKey
ORDER BY EnglishProductSubcategoryName ASC, EnglishProductCategoryName ASC
;




--1.b.	(1) List the customer key, first and last name of ALL customers who have not responded to
--		a survey. (DimCustomer and FactSurveyResponse). This is 1a with a few fields removed and 
--		a WHERE clause added.

SELECT dimCustomer.CustomerKey, FirstName, LastName--
--CONVERT(DATE,FactSurveyResponse.Date) AS 'YYYY/MM/DD', EnglishProductSubcategoryName, EnglishProductCategoryName
FROM dbo.DimCustomer
LEFT OUTER JOIN dbo.FactSurveyResponse
ON dimCustomer.CustomerKey = FactSurveyResponse.CustomerKey
WHERE SurveyResponseKey IS NULL
ORDER BY LastName ASC, FirstName ASC
;




--2.	(4) List the name of all Sales Reasons that have not been associated with a sale. Add a meaningful 
--		sort. Explanation: AdventureWorks has a prepopulated list of reasons why customers purchase their 
--		products. You are finding the reasons on the list that have not been selected by a customer buying 
--		over the Internet. Hint:  Use DimSalesReason and FactInternetSalesReason FactInternetSalesReason 
--		and test for null in the matching field in the fact table.  

SELECT SalesReasonName
FROM FactInternetSalesReason
RIGHT OUTER JOIN  DimSalesReason
ON DimSalesReason.SalesReasonKey = FactInternetSalesReason.SalesReasonKey 
WHERE FactInternetSalesReason.SalesReasonKey IS NULL
ORDER BY SalesReasonName ASC
;




--3.	(4) List all internet sales that do not have a sales reason associated. List SalesOrderNumber, 
--		SalesOrderLineNumber and the order date. Show the date as MM/DD/YYYY. Add a meaningful sort. 
--		Explanation: Now we are looking at sales reasons from another angle. Above we wanted to know which 
--		sales reasons had not been used, so we wanted the reason name. Now we are looking at which sales do not 
--		have a reason associated with the sale. Since we are looking at the sales, we don't need the reason name 
--		and the corresponding link to that table. Hint:  Use FactInternetSales and FactInternetSalesReason. 
SELECT FactInternetSales.SalesOrderNumber, FactInternetSales.SalesOrderLineNumber, 
CONVERT(DATE, OrderDate) AS 'YYYY/MM/DD' 

FROM FactInternetSalesReason
RIGHT OUTER JOIN  FactInternetSales
ON FactInternetSales.SalesOrderNumber = FactInternetSalesReason.SalesOrderNumber 
WHERE SalesReasonKey IS NULL
ORDER BY FactInternetSales.SalesOrderLineNumber ASC
;




--4.a.	(3) List all promotions that have not been associated with an internet sale. Show only
--		the English promotion name in alphabetical order.
--		Hint: Recall that details about sales to customers are recorded in the FactInternetSales table.
SELECT EnglishPromotionName
FROM DimPromotion
LEFT OUTER JOIN FactInternetSales
ON DimPromotion.PromotionKey = FactInternetSales.PromotionKey
WHERE FactInternetSales.PromotionKey IS NULL
ORDER BY EnglishPromotionName ASC
;




--4.b.	(4) List all promotions that have not been associated with a reseller sale. Show only
--		the English promotion name in alphabetical order.
--		Hint: Recall that details about sales to resellers are recorded in the FactResellerSales table.

SELECT EnglishPromotionName
FROM DimPromotion
LEFT OUTER JOIN FactResellerSales
ON DimPromotion.PromotionKey = FactResellerSales.PromotionKey
WHERE FactResellerSales.PromotionKey IS NULL
ORDER BY EnglishPromotionName ASC
;



--4.c.	+3 Bonus. Write an INTERSECT to show the name of promotions that have not been associated 
--		with either a reseller sale or an internet sale. HINT: This can be done with 
--		copy/paste from 4a and b, dropping one order by clause, and the addition of one keyword.


 


--5.a	(3) Find any PostalCodes in which AdventureWorks has no resellers.
--		List Postal Code and the English country/region name.
--		List each Postal Code only one time. Sort by country and postal code.

SELECT DISTINCT PostalCode, EnglishCountryRegionName
FROM DimGeography
LEFT OUTER JOIN DimReseller
ON DimReseller.GeographyKey = DimGeography.GeographyKey
WHERE DimReseller.GeographyKey IS NULL
ORDER BY EnglishCountryRegionName ASC,PostalCode ASC
;



--5.b.	(4) Find any PostalCodes in which AdventureWorks has no internet customers.
--		List Postal Code and the English country/region name.
--		List each Postal Code only one time. Sort by country and postal code.
SELECT PostalCode, EnglishCountryRegionName
FROM DimGeography
LEFT OUTER JOIN FactInternetSales
ON FactInternetSales.SalesTerritoryKey = DimGeography.SalesTerritoryKey
WHERE FactInternetSales.SalesTerritoryKey IS NULL
ORDER BY EnglishCountryRegionName ASC,PostalCode ASC
;




--5.c.	+2 Bonus. Write an INTERSECT to show Postal Codes in which AdventureWorks has neither  
--		Internet customers nor resellers. 





--6.a.	(4) List the name of all currencies and the name of each organization that uses that currency.
--		You will use an Outer Join to list the name of each currency in the Currency table regardless if
--		it has a matching value in the Organization table. You will see NULL in many rows. Add a 
--		meaningful sort. Hint: Use DimCurrency and DimOrganization. 
SELECT CurrencyName, OrganizationName 
FROM DimCurrency
LEFT OUTER JOIN DimOrganization
ON DimOrganization.CurrencyKey = DimCurrency.CurrencyKey
--WHERE OrganizationName IS NOT NULL
ORDER BY OrganizationName ASC
;



--6.b. (2) List the name of all currencies that are NOT used by any organization. In this situation 
--		we are using the statement from 6.a. and making a few modifications. We want to find the
--		currencies that do not have a match in the common field in the Organization table. 
--		Sort ascending on currency name. 


SELECT CurrencyName, OrganizationName 
FROM DimCurrency
LEFT OUTER JOIN DimOrganization
ON DimOrganization.CurrencyKey = DimCurrency.CurrencyKey
WHERE OrganizationName IS NULL
ORDER BY OrganizationName ASC
;


--7.a.	(3) List the unique name of all currencies and the CustomerKey of customers that use that 
--		currency. You will list the name of each currency in the Currency table regardless if
--		it has a matching value in the Internet Sales table. You will see some currencies are repeated
--		because more than one customer uses the currency. You may see the CustomerKey repeated because
--		a customer may buy in more than one currency. You will see NULL in a few rows. Add a 
--		meaningful sort. Hint: This will be all customers, with some duplicated, and the unused
--		currencies; 18,983 rows. 
SELECT DISTINCT CurrencyName, FactInternetSales.CustomerKey
FROM DimCurrency
LEFT OUTER JOIN FactInternetSales
ON FactInternetSales.CurrencyKey = DimCurrency.CurrencyKey
ORDER BY CustomerKey ASC, CurrencyName ASC
;




--7.b.	(2) Copy/paste 7.a. to 7.b. Modify 7.b. to list only the unique name of currencies that are not used 
--		by any internet customer. Add a meaningful sort. This will be a small number--just unused currencies.
		
SELECT DISTINCT CurrencyName, FactInternetSales.CustomerKey
FROM DimCurrency
LEFT OUTER JOIN FactInternetSales
ON FactInternetSales.CurrencyKey = DimCurrency.CurrencyKey
WHERE FactInternetSales.CurrencyKey IS NULL
ORDER BY CustomerKey ASC, CurrencyName ASC
;



--7.c.	(4) This question is a variation on 7.a. You will need to join to an additional table.
--		List the unique name of all currencies, the last name, first name, and the CustomerKey 
--		of customers that use that currency. You will list the name of each currency in the Currency table 
--		regardless if it has a matching value in the Internet Sales table. Same number of rows as 7.a.
SELECT DISTINCT CurrencyName, LastName, FirstName, FactInternetSales.CustomerKey

FROM DimCurrency
LEFT OUTER JOIN FactInternetSales
ON FactInternetSales.CurrencyKey = DimCurrency.CurrencyKey
LEFT OUTER JOIN DimCustomer
ON FactInternetSales.CustomerKey = DimCustomer.CustomerKey
ORDER BY CurrencyName ASC, LastName ASC, FirstName ASC
;



--		READ 8.a. and 8.b. BEFORE beginning the syntax.  Hint: Refer to the Outer Joins Demo 
--		and look at the example where a query is used in place of table for one possible method 
--		of answering these two questions. They can also be done with multiple joins.  NULL will 
--		show in the ResellerName and OrderDate for a few records. We are showing ALL promotions.

--8.a.	(4) Find all promotions and any related reseller sales. List unique instances of the 
--		English promotion name, reseller name, and the order date. Show the OrderDate as mm/dd/yyyy. 
--		Sort by the promotion name. Be sure to list all promotion names even if there is no related sale.
SELECT DISTINCT EnglishPromotionName, Name AS 'RSName', d AS 'YYY/MM/DD' 

FROM DimPromotion AS a
LEFT OUTER JOIN 

(SELECT c.ResellerName AS 'Name'
,CONVERT(DATE, b.OrderDate) AS 'd', b.PromotionKey AS pKey
FROM FactResellerSales AS b
RIGHT OUTER JOIN DimReseller AS c
ON b.ResellerKey = c.ResellerKey ) AS SellerDetails

ON a.PromotionKey = SellerDetails.pKey

ORDER BY Name ASC, EnglishPromotionName ASC
;





--8.b.	(3) Copy, paste, and modify 8.a. "No Discount" is not a promotion; eliminate those sales 
--		without a promotion from your results set. Show the OrderDate as mm/dd/yyyy.
--		Look for ways to double-check your results.


SELECT DISTINCT EnglishPromotionName, Name AS 'RSName', d AS 'YYY/MM/DD' 

FROM DimPromotion AS a
LEFT OUTER JOIN 

(SELECT c.ResellerName AS 'Name'
,CONVERT(DATE, b.OrderDate) AS 'd', b.PromotionKey AS pKey
FROM FactResellerSales AS b
RIGHT OUTER JOIN DimReseller AS c
ON b.ResellerKey = c.ResellerKey ) AS SellerDetails

ON a.PromotionKey = SellerDetails.pKey
WHERE a.EnglishPromotionName <> 'No Discount'
ORDER BY Name ASC, EnglishPromotionName ASC
;



