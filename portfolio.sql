
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

SELECT ROUND(sum(gross_income),2) AS total FROM
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

SELECT count(*) FROM (SELECT Product_line FROM portfolio1.orders
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

select customers.branch, round(sum(gross_income),2) as total_gross_income from portfolio1.revenue
join portfolio1.orders
on orders.order_number=revenue.order_number_
join portfolio1.customers
on customers.invoice_id = orders.invoice_id
where month(revenue.date) = 1
and revenue.rating  <= 5
group by branch;


/*15.What is the average gross income from the store branches*/

select round(avg(sums),2) 'Average' from (select branch, sum(gross_income) as sums 
from portfolio1.revenue
join portfolio1.orders
on orders.order_number=revenue.order_number_
join portfolio1.customers
on customers.invoice_id = orders.invoice_id
group by branch)a;


/*16.What is the total gross income for each branch?*/

select branch, ROUND(sum(gross_income),1) as total_gross_income 
from portfolio1.revenue
join portfolio1.orders
on orders.order_number=revenue.order_number_
join portfolio1.customers
on customers.invoice_id = orders.invoice_id
group by branch;


/*17.which branches got the average gross income?*/

select round(sum(gross_income),2) total_gross_income,
case when round(sum(gross_income),2)>'5117.74' then 'above avg'
when round(sum(gross_income),2)= '5117.74' then ' avg'
else  'below avg'
end as 'Type'
from portfolio1.revenue
join portfolio1.orders
on orders.order_number=revenue.order_number_
join portfolio1.customers
on customers.invoice_id = orders.invoice_id
group by branch
order by 1 DESC;

/*18.How much do women spend on average?*/
select customers.gender,round(avg(orders.total),2) as avg_spent from portfolio1.orders
join portfolio1.customers
on customers.invoice_id = orders.invoice_id
where gender = 'female' ;

/*19.on average how much do women spend on health and beauty products */
select customers.gender,orders.product_line,round(avg(orders.total),2) as avg_spent from portfolio1.orders
join portfolio1.customers
on customers.invoice_id = orders.invoice_id
where gender = 'female' and product_line='Health and beauty' ;
 
 /*20.where is the branch that gets the most orders*/
select city, branch, count(*) total_orders 
from portfolio1.customers
group by 1
order by 2 desc
limit 1;

/*21.what is the type odf each order*/
select customers.invoice_id,orders.total,
 case when total >322.74 then'above avg'
when total<322.74 then 'below avg'
else 'avg'
end as order_type
from portfolio1.orders
join portfolio1.customers
on customers.invoice_id = orders.invoice_id ;

/*22. how many Home and lifestyle product sold in february?*/
select sum(orders.quantity) as quantity from portfolio1.orders
join portfolio1.revenue
on orders.order_number = revenue.order_number_
where month(revenue.date) = 2
and orders.product_line  = 'Home and lifestyle';

