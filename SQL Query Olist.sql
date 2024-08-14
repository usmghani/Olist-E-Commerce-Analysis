--Number of customers from the city of sao paulo
select customer_city, count (*) as number_of_customer
from projectportfolio..olist_customers_dataset
where customer_city like '%sao_paulo%'
group by customer_city;

--Which top 3 cities has the highest number of customers?
select top (3) customer_city, count (*) as number_of_customer
from projectportfolio..olist_customers_dataset
group by customer_city
order by number_of_customer desc

--Identify the most common customer zip code
select top (1) customer_zip_code_prefix, count (*) as number_of_order_per_zip
from projectportfolio..olist_customers_dataset
group by customer_zip_code_prefix
order by number_of_order_per_zip desc

--How many customer id are there
select COUNT (*) as total_number_of_customer_id
from projectportfolio..olist_customers_dataset


--Number of customer grouped by state and city

select customer_city, customer_state, count (*) as number_of_customer
from projectportfolio..olist_customers_dataset
group by customer_city, customer_state
order by number_of_customer desc

--cities in the state "SP" and count the number of customers in each

select customer_city, count (*) as number_of_customer
from projectportfolio..olist_customers_dataset
where customer_state = 'SP'
group by customer_city
order by number_of_customer desc

--list customer_id, unique customer id, their city and their order id

select c.customer_id, c.customer_unique_id, o.order_id, c.customer_city
from projectportfolio..olist_customers_dataset as c
join projectportfolio..olist_orders_dataset as o
on c.customer_id = o.customer_id


--list the number of customers who purchased "cool_stuff" product.

with number_of_cool_stuff_purchased as (
	select c.customer_unique_id, o.customer_id, pd.product_category_name
	from projectportfolio..olist_customers_dataset as c
	join projectportfolio..olist_orders_dataset as o on c.customer_id = o.customer_id
	join projectportfolio..olist_order_items_dataset as oi on o.order_id = oi.order_id
	join projectportfolio..olist_products_dataset as pd on oi.product_id = pd.product_id
	where pd.product_category_name like '%cool_stuff%'
)
select
	c.customer_id, c.customer_unique_id, c.product_category_name,
	count(*) over () as number_of_cool_stuff_purchases
from number_of_cool_stuff_purchased c;

--List all orders along with the customer details who made the order.

select c.customer_unique_id, o.order_id, o.order_purchase_timestamp, c.customer_city
from projectportfolio..olist_customers_dataset as c
join projectportfolio..olist_orders_dataset as o on o.customer_id = c.customer_id

--Find all products purchased by each customer along with the order date.

select c.customer_id, o.order_id, o.order_purchase_timestamp, oi.product_id
from projectportfolio..olist_customers_dataset as c
join olist_orders_dataset as o on o.customer_id = c.customer_id
join olist_order_items_dataset as oi on oi.order_id = o.order_id

--Find customers who placed more than 5 orders.

SELECT 
    c.customer_unique_id, 
    COUNT(o.order_id) AS total_orders
	from projectportfolio..olist_customers_dataset as c
	join projectportfolio..olist_orders_dataset as o on c.customer_id = o.customer_id
	group by c.customer_unique_id
	having COUNT(o.order_id) >5
	order by total_orders desc
	
	
--List All Customers Who Have Never Purchased 'cool_stuff' and Include Other Products They Have Purchased

with cool_stuff_customers as (
	select distinct
	c.customer_id
	from projectportfolio..olist_customers_dataset as c
	join olist_orders_dataset as o on c.customer_id = o.customer_id
	join olist_order_items_dataset as oi on o.order_id = oi.order_id
	join olist_products_dataset as pd on oi.product_id = pd.product_id
	where pd.product_category_name != 'cool_stuff'
)
select c.customer_id, c.customer_unique_id, o.order_id, pd.product_category_name
from projectportfolio..olist_customers_dataset as c
join olist_orders_dataset as o on c.customer_id = o.customer_id
join olist_order_items_dataset as oi on o.order_id = oi.order_id
join olist_products_dataset as pd on oi.product_id = pd.product_id
where c.customer_id in (select customer_id from cool_stuff_customers)

--Identify top 10 Customers with the Most Number of Orders

select top 10 c.customer_unique_id,
count(o.order_id) as total_orders
from projectportfolio..olist_customers_dataset as c
join projectportfolio..olist_orders_dataset as o on c.customer_id = o.customer_id
group by c.customer_unique_id
order by total_orders desc

--List Orders with Multiple Payment Installments with their Payment Value

select p.order_id, p.payment_type, p.payment_installments, p.payment_value
from projectportfolio..olist_order_payments_dataset as p
where payment_installments > 1
order by payment_installments desc

--List all the payments with boleto payment mode

select p.order_id, p.payment_type, p.payment_value
from projectportfolio..olist_order_payments_dataset as p
where payment_type like '%boleto%'
order by payment_value desc


















	






















