-- This SQL script contains two variants of queries to list customers with high credit limits.

--Task 1: Show customers with high credit limit

--Variant 1: List all customers with a credit limit above $80,000 (basic filter)

SELECT customerName, creditLimit
FROM customers
WHERE creditLimit > 80000
ORDER BY creditLimit DESC;
--Explanation:
--This will list all customers who have a credit limit above 80,000, sorted from highest to lowest.

--Variant 2: Show only the TOP 5 customers by credit limit

SELECT customerName, creditLimit
FROM customers
ORDER BY creditLimit DESC
LIMIT 5;
--Explanation:
--This variant doesn’t filter by a threshold, but simply shows the top 5 customers with the highest credit limits.

Task 2: Show customers with high credit limit including contact info
Variant 1: List all customers with credit limit above $90,000 and include contact information

SELECT customerName, contactFirstName, contactLastName, country, creditLimit
FROM customers
WHERE creditLimit > 90000
ORDER BY creditLimit DESC;

--Explanation:
--This query returns all customers whose credit limit is above 90,000. It also includes their contact first and last name, and the country. The results are sorted with the highest credit limit first.


--Variant 2: Show the top 3 US customers by credit limit (with contact names)

SELECT customerName, contactFirstName, contactLastName, creditLimit
FROM customers
WHERE country = 'USA'
ORDER BY creditLimit DESC
LIMIT 3;

--Explanation:
--This version finds the three customers in the USA with the highest credit limits. It includes both their company name and contact names.

Task 3: Show products in stock (product name and quantity available)

Variant 1: List all in-stock products with quantities (Simple WHERE filter)
SELECT productName, quantityInStock
FROM products
WHERE quantityInStock > 0
ORDER BY quantityInStock DESC;

--Explanation:
--This query lists all products where the stock quantity is greater than zero, sorted by the highest stock first. You can easily see which items are most plentiful.

--Variant 2: Show in-stock products grouped by product line (Grouping and SUM)

SELECT productLine, SUM(quantityInStock) AS totalInStock
FROM products
GROUP BY productLine
HAVING totalInStock > 0
ORDER BY totalInStock DESC;

--Explanation:
--This version groups products by their product line and sums up the quantities in stock for each group. Only product lines with some stock appear, showing overall inventory by product line.

--Task 4: List all orders placed in 2003, showing the order number and order date

--Variant 1: Using the YEAR() function to filter by year

SELECT orderNumber, orderDate
FROM orders
WHERE YEAR(orderDate) = 2003
ORDER BY orderDate ASC;

--Explanation:
--This query extracts the year from each order’s date and only includes orders from 2003. The results are sorted by date.

--Variant 2: Using a date range (BETWEEN operator)

SELECT orderNumber, orderDate
FROM orders
WHERE orderDate BETWEEN '2003-01-01' AND '2003-12-31'
ORDER BY orderDate ASC;

--Explanation:
--Here, we specify the date range for all of 2003 using BETWEEN. This method also shows all orders from that year, in order.

--Task 5: Show the names and phone numbers of customers who have a credit limit higher than $100,000

--Variant 1: Simple WHERE clause

SELECT customerName, phone
FROM customers
WHERE creditLimit > 100000
ORDER BY creditLimit DESC;

--Explanation:
--This query selects customer names and phone numbers from the customers table where their credit limit is above 100,000. The results are sorted from highest to lowest credit limit.

--Variant 2: Add creditLimit to output for clarity

SELECT customerName, phone, creditLimit
FROM customers
WHERE creditLimit > 100000
ORDER BY creditLimit DESC;

--Explanation:
--This version also shows the actual credit limit in the output, making it easy to see exactly how much each qualifying customer has.

--Task 6: Show the order numbers and order dates for all orders placed in 2004

--Variant 1: Using the YEAR() function

SELECT orderNumber, orderDate
FROM orders
WHERE YEAR(orderDate) = 2004
ORDER BY orderDate;

--Explanation:
--This query extracts all orders where the orderDate falls in the year 2004, using the YEAR() function for clear intent and easy filtering.

--Variant 2: Using a date range with BETWEEN

SELECT orderNumber, orderDate
FROM orders
WHERE orderDate BETWEEN '2004-01-01' AND '2004-12-31'
ORDER BY orderDate;

--Explanation:
--This version selects orders whose orderDate is within the full year of 2004, using the BETWEEN operator for date ranges.

--Task 7: List all customers who do not have a sales representative assigned
--(That is, customers where salesRepEmployeeNumber is NULL)

--Variant 1: Using IS NULL

SELECT customerNumber, customerName
FROM customers
WHERE salesRepEmployeeNumber IS NULL;

--Explanation:
--This query selects customers whose salesRepEmployeeNumber field is NULL, meaning no sales rep is assigned.

--Variant 2: Using LEFT JOIN to Employees

SELECT c.customerNumber, c.customerName
FROM customers c
LEFT JOIN employees e
  ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE c.salesRepEmployeeNumber IS NULL OR e.employeeNumber IS NULL;

--Explanation:
--This query left-joins the employees table to customers on the sales rep field, and selects customers with no matching employee (either the field is NULL or doesn’t match any employee).
--In practice, most cases are just IS NULL, but the join technique is a robust alternative for learning.

--Task 8: List all products that have never been ordered
--(Products not present in any order details)

--Variant 1: Using NOT IN

SELECT productCode, productName
FROM products
WHERE productCode NOT IN (
    SELECT productCode FROM orderdetails
);

--Explanation:
--This query finds products whose productCode does not appear in the orderdetails table—meaning they've never been ordered.

--Variant 2: Using LEFT JOIN and IS NULL

SELECT p.productCode, p.productName
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL;

--Explanation:
--This version does a LEFT JOIN between products and orderdetails. If there's no matching order, od.productCode will be NULL. So, products shown here have never been ordered.

--Task 9: Show the names of customers who have placed orders

--Variant 1: Using INNER JOIN

SELECT DISTINCT c.customerName
FROM customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber;

--Explanation:
--The INNER JOIN combines customers and orders where customerNumber matches.
--DISTINCT ensures each customer appears only once, even if they placed multiple orders.

--Variant 2: Using EXISTS

SELECT customerName
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customerNumber = c.customerNumber
);

--Explanation:
--This uses a correlated subquery.
--EXISTS checks if at least one order exists for the customer.
--Returns only customers who have placed at least one order.

--Task 10: Show all products that have never been ordered

--Variant 1: Using LEFT JOIN with IS NULL

SELECT p.productCode, p.productName
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL;

--Explanation:
--LEFT JOIN returns all products and matches them with order details.
--Products without matching order details (i.e., never ordered) will have od.productCode as NULL.
--The WHERE clause filters out only those products.

--Variant 2: Using NOT IN

SELECT productCode, productName
FROM products
WHERE productCode NOT IN (
    SELECT productCode FROM orderdetails
);

--Explanation:
--Subquery returns all product codes that have been ordered.
--The outer query selects products whose productCode does not appear in this list.