--*  BUSIT 103           Assignment   #2              DUE DATE :  Consult course calendar

/*	You are to develop SQL statements for each task listed. You should type your SQL statements under each task.
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example. 	Add comments to describe your 
	reasoning when you are in doubt about something. To find the tables that contain the fields that are requested, 
	consider creating a Database Diagram that includes only the tables from the SalesLT schema and referring to it. */

/*	Submit your .sql file named with your last name and first name and assignment # (e.g., GriggsDebiAssignment2.sql). 
	Submit your file to the instructor using through the course site.  */

/*	Each of these SELECT statements draws its data from a single table. The will be no joins used in this assignment. 
	Additionally no filters should be used. */

Use AdventureWorksLT2012;

--1.	(2) List all fields in the product model table. 






--2.	(3) List the name and catalog description of the product models.  





--3.	(2) List all fields in the customer table. 





--4.	(3) List the first name, last name and company name of each customer in alphabetical order by company. 





--5.	(5) List the first name, last name and company name of each customer in a single results set in alphabetical order 
--		by last name,  then by first name, and then by company. 
--		Note: This is one SELECT statement that uses all three fields in the ORDER BY clause.





--6.	(5) List products by product number.  Include all data about each product. "All data" means to include all 
--		the fields. Add a meaningful sort.





--7.	(5) List products showing product ID, product name, standard cost, list price and product number. 
--		Add a meaningful sort.




--8.	(5) List products showing product ID, product name, standard cost, and list price ordered by 
--		highest to lowest list price. 





--9.  	(5) List the colors of products AdventureWorks sells.  List each color only once and in alphabetical order. 
--		NULL will appear in the Color column; don't eliminate it. We will learn to deal with NULL in the next module.





--10.	(2) List addresses by country. Include all data about each address. "All data" means to include 
--		all the fields.





--11.	(3) List the unique postal code, city, state/province and country/region and order alphabetically by 
--		country/region, state/province and city. 
--		Note: This is one SELECT statement that uses all three fields in the ORDER BY clause.


 


--12.	(5) List orders from the SalesLT.SalesOrderDetails table from lowest to highest on order quantity and 
--		by highest to oldest lowest on LineTotal.  Include all data related to each order. 





--13.	(5) List customer IDs for customers that have placed orders with AdventureWorks.
--		Use the SalesLT.SalesOrderHeader table and show each customer ID only once even if the customer
--		has placed multiple orders. 




