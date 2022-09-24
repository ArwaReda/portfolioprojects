
/* # 1.how much do pay customers using credit card */
SELECT customers.gender ,
customers.Customer_type,
orders.Payment,
orders.Total
FROM portfolio1.customers
JOIN portfolio1.orders
ON customers.Invoice_ID = orders.Invoice_ID
WHERE payment = 'credit card' ;


/*2. What is the normal customers' total gross imcome ?*/
SELECT ROUND(SUM(gross_income),2) AS total FROM
(SELECT
customers.Customer_type,
orders.Total,
revenue.gross_income
FROM portfolio1.orders
JOIN portfolio1.revenue
ON revenue.Order_number_ = orders.order_number
JOIN portfolio1.customers
ON customers.Invoice_ID = orders.Invoice_ID
WHERE Customer_type = 'normal' ) GI ;


/*3. what is the MEDIAN total spent on all orders?*/
SELECT * FROM (SELECT orders.Total
FROM portfolio1.orders
ORDER BY orders.Total
LIMIT 6) as A
order by Total DESC
LIMIT 2;


/*4.What is the product line with the highest gross income*/
SELECT orders.product_line,
revenue.gross_income FROM portfolio1.orders
JOIN portfolio1.revenue
ON revenue.order_number_ = orders.order_number
ORDER BY gross_income DESC
LIMIT 1;


/*5.The gender who spends the most */
SELECT customers.gender,
orders.total
FROM portfolio1.customers
JOIN portfolio1.orders
ON customers.Invoice_ID = orders.Invoice_ID
GROUP BY gender
ORDER BY total DESC
LIMIT 1;
 

/*6.how many product line the store sells?*/
SELECT COUNT(*) FROM (SELECT Product_line FROM portfolio1.orders
GROUP BY product_line) A;


/*7.how many male is a member/normal cutomer?*/
SELECT gender, customer_type, COUNT(*) AS total FROM portfolio1.customers
WHERE gender = 'Male' 
GROUP BY Customer_type;

/*8..how many female is a member/normal cutomer?*/
SELECT gender, customer_type, COUNT(*) AS total FROM portfolio1.customers
WHERE gender = 'Female' 
GROUP BY Customer_type;


/*9. What is the gender with most mebmership?*/
SELECT gender, customer_type,
COUNT(*) AS total FROM portfolio1.customers
WHERE customer_type = 'Member'
GROUP BY gender
ORDER BY total DESC
LIMIT 1;


/*10. Which gender spent in total more than 16k?*/
SELECT customers.Gender, 
ROUND(SUM(total),2) AS total
FROM portfolio1.orders
JOIN portfolio1.customers
ON customers.Invoice_ID = orders.Invoice_ID
GROUP BY Gender
HAVING SUM(total) >160000;


/*11. How many member with a rate more than 8 ?*/
select COUNT(*) Total_members FROM
(SELECT  customer_type, revenue.Rating 
FROM portfolio1.revenue
JOIN portfolio1.orders
ON revenue.Order_number_ = orders.order_number
JOIN portfolio1.customers
ON customers.Invoice_ID = orders.Invoice_ID
WHERE Customer_type = 'Member' AND Rating >8) C;


/*12. How many member with a rate less than 5 ? */
select COUNT(*) Total_members FROM
(SELECT  customer_type, revenue.Rating 
FROM portfolio1.revenue
JOIN portfolio1.orders
ON revenue.Order_number_ = orders.order_number
JOIN portfolio1.customers
ON customers.Invoice_ID = orders.Invoice_ID
WHERE Customer_type = 'Member' AND Rating <5) C;


/*13. How many member with a rate between 5 and 8 ? */
select COUNT(*) Total_members FROM
(SELECT  customer_type, revenue.Rating 
FROM portfolio1.revenue
JOIN portfolio1.orders
ON revenue.Order_number_ = orders.order_number
JOIN portfolio1.customers
ON customers.Invoice_ID = orders.Invoice_ID
WHERE Customer_type = 'Member' AND Rating BETWEEN 5 AND 8) C;


/*14. What is gross income of the first month of 2019 with a customer rating less than 5 in each branch?*/
SELECT customers.branch, ROUND(SUM(gross_income),2) AS total_gross_income FROM portfolio1.revenue
JOIN portfolio1.orders
ON orders.order_number=revenue.order_number_
JOIN portfolio1.customers
ON customers.invoice_id = orders.invoice_id
WHERE MONTH(revenue.date) = 1 AND revenue.rating  <= 5
GROUP BY branch;


/*15.What is the average gross income from the store branches*/
SELECT ROUND(avg(sums),2) 'Average' FROM (SELECT branch, sum(gross_income) AS sums 
FROM portfolio1.revenue
JOIN portfolio1.orders
ON orders.order_number=revenue.order_number_
JOIN portfolio1.customers
ON customers.invoice_id = orders.invoice_id
GROUP BY branch)a;


/*16.What is the total gross income for each branch?*/
SELECT branch, ROUND(SUM(gross_income),1) AS total_gross_income 
FROM portfolio1.revenue
JOIN portfolio1.orders
ON orders.order_number=revenue.order_number_
JOIN portfolio1.customers
ON customers.invoice_id = orders.invoice_id
GROUP BY branch;


/*17.which branches exceed the average gross income?*/
SELECT ROUND(sum(gross_income),2) total_gross_income,
CASE WHEN round(sum(gross_income),2)>'5117.74' THEN 'above avg'
WHEN round(sum(gross_income),2)= '5117.74' THEN ' avg'
ELSE  'below avg'
END AS  'Type'
FROM portfolio1.revenue
JOIN portfolio1.orders
ON orders.order_number=revenue.order_number_
JOIN portfolio1.customers
ON customers.invoice_id = orders.invoice_id
GROUP BY branch
ORDER BY 1 DESC;

/*18.How much do women spend on average?*/
SELECT customers.gender,ROUND(AVG(orders.total),2) AS avg_spent FROM portfolio1.orders
JOIN portfolio1.customers
ON customers.invoice_id = orders.invoice_id
WHERE gender = 'female' ;

/*19.on average how much do women spend on health and beauty products */
SELECT customers.gender,orders.product_line,ROUND(AVG(orders.total),2) AS avg_spent FROM portfolio1.orders
JOIN portfolio1.customers
ON customers.invoice_id = orders.invoice_id
WHERE gender = 'female' AND product_line='Health and beauty' ;
 
 /*20.the branch that gets the most orders*/
SELECT city, branch, COUNT(*) total_orders 
FROM portfolio1.customers
GROUP BY  1
ORDER BY 2 DESC
LIMIT 1;

/*21.type of each order*/
select customers.invoice_id,orders.total,
CASE WHEN total > 322.74 THEN 'above avg'
WHEN total < 322.74 THEN 'below avg'
ELSE 'avg'
END AS order_type
FROM portfolio1.orders
JOIN portfolio1.customers
ON customers.invoice_id = orders.invoice_id ;

/*22. total Home and lifestyle products sold in february?*/
SELECT SUM(orders.quantity) AS quantity FROM portfolio1.orders
JOIN portfolio1.revenue
ON orders.order_number = revenue.order_number_
WHERE MONTH(revenue.date) = 2
AND orders.product_line  = 'Home and lifestyle';

/*23. average customer rating with each payment method*/
SELECT orders.payment ,ROUND(SUM(orders.total)) AS total, ROUND(AVG(revenue.rating),2) AS avg_rating FROM portfolio1.orders
JOIN portfolio1.revenue
ON orders.order_number = revenue.order_number_
GROUP BY 1
ORDER BY 3 DESC;
