-- 1. Display each employee's first name, last name & office phone
-- 1. List employees' first and last names with their office phone number
SELECT e.firstName, e.lastName, o.phone AS officePhone
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode;
-- Shows which office and phone each employee belongs to 


-- 2. For each customer, show name, postal code & order date
-- 2. List customer name, postal code, and their order dates
SELECT c.customerName, c.postalCode, o.orderDate
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
ORDER BY c.customerName, o.orderDate;
-- Matches customers with their orders and postal codes

-- 3. Customer names and shipping dates (LEFT JOIN: include customers with NO orders)
-- 3. Show customer names and shipping dates of their orders (including those with no orders)
SELECT c.customerName, o.shippedDate
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
ORDER BY c.customerName;
-- Customers without orders will show NULL in shippedDate


-- 4. Employee names/emails + their office addressLine2 (RIGHT JOIN: include all offices)
-- 4. Employees' first names, emails, and their office's addressLine2, ordered by office country
SELECT e.firstName, e.email, o.addressLine2
FROM employees e
RIGHT JOIN offices o ON e.officeCode = o.officeCode
ORDER BY o.country ASC;
-- Includes all office addresses, even if no employee is assigned there

-- 5. Customer names with their sales rep's (employee) first and last names
-- 5. Customers and their assigned sales reps' names
SELECT c.customerName, e.firstName AS salesRepFirst, e.lastName AS salesRepLast
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
ORDER BY c.customerName;
-- Each customer with the employee responsible for them

-- 6. Customer names, sales employee names, and office cities for all employees
-- 6. Customer names, their sales employee names, and the sales employee's office city
SELECT c.customerName, e.firstName AS salesEmpFirst, e.lastName AS salesEmpLast, o.city AS officeCity
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode
ORDER BY c.customerName;

-- 7. List customers with their names, phone numbers, and the status of their orders
-- 7. Customers' names, phone numbers, and the status of their orders
SELECT c.customerName, c.phone, o.status
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
ORDER BY c.customerName;

-- 8. For each customer, show name, country, and quantity of their orders
-- 8. Customer name, country, and quantity for each of their orders
SELECT c.customerName, c.country, od.quantityOrdered
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
ORDER BY c.customerName;
-- 9. (Seems to repeat 8, likely a typo) For each customer, name, country, quantity of orders
-- 9. Same as previous: customer name, country, quantity for each order
SELECT c.customerName, c.country, od.quantityOrdered
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
ORDER BY c.customerName;

-- 10. Customer's name, phone, order date & status for first quarter of 2004, newest first
-- 10. Customers' name, phone, order date, and status for Q1 2004 orders (Jan-Mar), newest first
SELECT c.customerName, c.phone, o.orderDate, o.status
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
WHERE YEAR(o.orderDate) = 2004 AND MONTH(o.orderDate) BETWEEN 1 AND 3
ORDER BY o.orderDate DESC;


-- 11. List all customers, their country, the product name, and price for every product they ordered
-- 11. Customers, their country, product name, and buy price for every product they ordered
SELECT c.customerName, c.country, p.productName, p.buyPrice
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
ORDER BY c.customerName, p.productName;

-- 12. Show customer names, the names of their sales reps (employees), and their order status
-- 12. Customer name, their sales rep's full name, and status of each order
SELECT c.customerName, CONCAT(e.firstName, ' ', e.lastName) AS salesRepName, o.status
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
ORDER BY c.customerName, o.orderDate;

-- 13. Display all customer names, their order numbers, product names, and quantity ordered
-- 13. Customer name, order number, product name, and quantity ordered for each order
SELECT c.customerName, o.orderNumber, p.productName, od.quantityOrdered
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
ORDER BY c.customerName, o.orderNumber;

-- 14. Show product names, order dates, and the names of customers who ordered them
-- 14. Product name, order date, and the name of the customer who ordered
SELECT p.productName, o.orderDate, c.customerName
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
JOIN customers c ON o.customerNumber = c.customerNumber
ORDER BY o.orderDate, c.customerName;

-- 15. List all product names, vendor names, and the countries of customers who bought them
-- 15. Product name, vendor name, and country of each customer who bought the product
SELECT p.productName, p.productVendor, c.country
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
JOIN customers c ON o.customerNumber = c.customerNumber
ORDER BY p.productName, c.country;

-- 16. Show each customer's name, their sales rep's name, and the city of the sales rep's office
-- 16. Customer name, their sales rep's full name, and the city of the rep's office
SELECT c.customerName, CONCAT(e.firstName, ' ', e.lastName) AS salesRepName, o.city AS salesRepOfficeCity
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode
ORDER BY c.customerName;

-- 17. Show every order number, order date, product name, and the quantity ordered
-- 17. Order number, date, product name, and quantity for each order detail
SELECT o.orderNumber, o.orderDate, p.productName, od.quantityOrdered
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
ORDER BY o.orderDate, o.orderNumber;

-- 18. List all product names, their vendor names, and the price for every order that included the product
-- 18. Product name, vendor, and price for each product ordered (with order linkage)
SELECT p.productName, p.productVendor, p.buyPrice, o.orderNumber
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
ORDER BY p.productName, o.orderNumber;

-- 19. List customers, their country, and the order status for orders placed after January 1, 2005
-- 19. Customer name, country, and status of orders after Jan 1, 2005
SELECT c.customerName, c.country, o.status, o.orderDate
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
WHERE o.orderDate > '2005-01-01'
ORDER BY o.orderDate, c.customerName;

-- 20. Show customers' names, their country, and the order numbers for orders that are 'Shipped'
-- 20. Customer name, country, and order number for all 'Shipped' orders
SELECT c.customerName, c.country, o.orderNumber
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
WHERE o.status = 'Shipped'
ORDER BY c.customerName, o.orderNumber;

-- 41. Show the product name and the total quantity sold for each product
-- 41. Product name and total quantity sold (across all orders)
SELECT p.productName, SUM(od.quantityOrdered) AS totalSold
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode
ORDER BY totalSold DESC, p.productName;

-- 42. List customers and the number of orders each has placed
-- 42. Customer name and how many orders they've made
SELECT c.customerName, COUNT(o.orderNumber) AS orderCount
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber
ORDER BY orderCount DESC, c.customerName;

-- 43. Show employees who have not made any sales (i.e., no customers assigned)
-- 43. Employees with no assigned customers (not sales reps)
SELECT CONCAT(e.firstName, ' ', e.lastName) AS employeeName
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.customerNumber IS NULL
ORDER BY employeeName;

-- 44. List products that have never been ordered
-- 44. Products with no order records
SELECT p.productName
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.orderNumber IS NULL
ORDER BY p.productName;

-- 45. Show all customers who have made payments above $100,000 (single payment)
-- 45. Customers with at least one payment > $100,000
SELECT DISTINCT c.customerName
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
WHERE p.amount > 100000
ORDER BY c.customerName;

-- 46. Show the customer name and the number of different products they have ordered
-- 46. Customer and count of different products ordered
SELECT c.customerName, COUNT(DISTINCT od.productCode) AS productVariety
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber
ORDER BY productVariety DESC, c.customerName;

-- 47. List all orders with their customer name and total value of the order
-- 47. Order number, customer, and order total value
SELECT o.orderNumber, c.customerName, SUM(od.priceEach * od.quantityOrdered) AS orderTotal
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber
ORDER BY orderTotal DESC, o.orderNumber;

-- 48. Show the names of employees who work in offices in the USA
-- 48. Employees working in USA offices
SELECT CONCAT(e.firstName, ' ', e.lastName) AS employeeName, o.city, o.country
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode
WHERE o.country = 'USA'
ORDER BY employeeName;

-- 49. List all product lines and the number of products in each
-- 49. Product line and number of products it contains
SELECT pl.productLine, COUNT(p.productCode) AS productCount
FROM productlines pl
LEFT JOIN products p ON pl.productLine = p.productLine
GROUP BY pl.productLine
ORDER BY productCount DESC, pl.productLine;

-- 50. Show each customer’s name and their average order value
-- 50. Customer and their average order total
SELECT c.customerName, AVG(orderTotals.orderTotal) AS avgOrderValue
FROM customers c
JOIN (
  SELECT o.customerNumber, o.orderNumber, SUM(od.priceEach * od.quantityOrdered) AS orderTotal
  FROM orders o
  JOIN orderdetails od ON o.orderNumber = od.orderNumber
  GROUP BY o.orderNumber
) AS orderTotals ON c.customerNumber = orderTotals.customerNumber
GROUP BY c.customerNumber
ORDER BY avgOrderValue DESC, c.customerName;

-- 51. List customers who have not placed any orders
-- 51. Customers with no orders
SELECT c.customerName
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL
ORDER BY c.customerName;

-- 52. Show orders where the order total exceeds $50,000
-- 52. Orders with total value over $50,000
SELECT o.orderNumber, c.customerName, SUM(od.priceEach * od.quantityOrdered) AS orderTotal
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber
HAVING orderTotal > 50000
ORDER BY orderTotal DESC;
-- 53. Show employees who manage other employees (i.e., who have direct reports)
-- 53. Managers (employees who have subordinates)
SELECT DISTINCT CONCAT(m.firstName, ' ', m.lastName) AS managerName
FROM employees m
JOIN employees e ON m.employeeNumber = e.reportsTo
ORDER BY managerName;

-- 54. List all customers with their most recent order date
-- 54. Customer and their last order date
SELECT c.customerName, MAX(o.orderDate) AS lastOrderDate
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber
ORDER BY lastOrderDate DESC;

-- 55. Show all products along with the names of customers who ordered them
-- 55. Product name and customer name (all pairs where ordered)
SELECT DISTINCT p.productName, c.customerName
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
JOIN customers c ON o.customerNumber = c.customerNumber
ORDER BY p.productName, c.customerName;

-- 56. List all customers and their total payments, even if no payment exists
-- 56. Customers and total payments (if any; zero if none)
SELECT c.customerName, COALESCE(SUM(p.amount), 0) AS totalPayments
FROM customers c
LEFT JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
ORDER BY totalPayments DESC, c.customerName;

-- 57. Show the employee names who report to ‘Diane Murphy’
-- 57. Employees who report to Diane Murphy
SELECT CONCAT(e.firstName, ' ', e.lastName) AS employeeName
FROM employees e
JOIN employees m ON e.reportsTo = m.employeeNumber
WHERE m.firstName = 'Diane' AND m.lastName = 'Murphy'
ORDER BY employeeName;

-- 58. List all products and their buy price, and the average buy price for their product line
-- 58. Product, buy price, and avg buy price for its product line
SELECT p.productName, p.buyPrice, pl.productLine, 
       (SELECT AVG(buyPrice) FROM products WHERE productLine = pl.productLine) AS avgLinePrice
FROM products p
JOIN productlines pl ON p.productLine = pl.productLine
ORDER BY pl.productLine, p.productName;

-- 59. Show customers and the earliest order date for each
-- 59. Customer and their first order date
SELECT c.customerName, MIN(o.orderDate) AS firstOrderDate
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber
ORDER BY firstOrderDate;

-- 60. Show the name and city of customers who have ordered products from ‘Classic Cars’ product line
-- 60. Customer name and city, if they've ordered from 'Classic Cars'
SELECT DISTINCT c.customerName, c.city
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE p.productLine = 'Classic Cars'
ORDER BY c.customerName;
