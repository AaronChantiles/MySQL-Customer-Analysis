/*
A query that retrieves the distinct first purchase dates (only dates) of all customers
that found reviews to be heavily or moderately reliable, and who first purchased
from this company during year 2023, sorted in descending order by date. You are
required to use ranges when writing some of the conditions. 
*/
SELECT DISTINCT Date_First_Purchase
FROM customer_survey
WHERE Date_First_Purchase BETWEEN '2023-01-01' AND '2023-12-31'
  AND Review_Reliability IN ('Heavily', 'Moderately')
ORDER BY Date_First_Purchase DESC;

/*
A query that retrieves the oldest first purchase date (among present records) for
customers that browse weekly, but have a low or low-medium purchase frequency
and who often or always save items for later. You are required to use set inclusion
when writing some of the conditions.
*/
SELECT MIN(Date_First_Purchase)
FROM customer_survey
WHERE Browsing_Frequency_Monthly IN ('Weekly')
  AND Purchase_Frequency_Monthly IN ('L', 'LM')
  AND Saveforlater_Frequency IN ('Often', 'Always');

/*
A query that retrieves the total number and average age (return just two aggregate
values) of all customers who value having a wide selection of products or competitive
prices but never explore them beyond the first page of the website. Include only
customers that made their first purchase before 2023 and gave the highest possible
importance to reviews.
*/
SELECT AVG(Age), COUNT(Customer_id)
FROM customer_survey
WHERE Date_First_Purchase < '2023-01-01'
  AND Service_Appreciation IN ('6', '1')
  AND Search_Result_Exploration = 'First_page'
  AND Customer_Reviews_Importance = 5;

/*
A query that returns the distinct number of types of areas that GTBM can improve
on, reported by female customers who browse weekly (the result should be a single
number). You are required to use an aggregate function.
*/
SELECT COUNT(DISTINCT Improvement_Areas)
FROM customer_survey
WHERE Gender = 'Female'
  AND Browsing_Frequency_Monthly = 'Weekly';

/*
A query that retrieves the types of search result exploration method (column
Search_Result_Exploration) and the number of customers grouped by search result
exploration method, for customers that search for product by keyword or filter
(column Product_Search_Method). You are required to use set inclusion when
writing some of the conditions.
*/
SELECT Search_Result_Exploration, COUNT(*) Customer_id
FROM customer_survey
WHERE Product_Search_Method IN ('Keyword', 'Filter')
GROUP BY Search_Result_Exploration;

/*
A query that retrieves the number of customers, by age groups, who individually
consider customer reviews (measured as an integer under
Customer_Reviews_Importance) to be more important (i.e., a greater number) than
the average reviews importance (same field Customer_Reviews_Importance) placed
by high-frequency purchasers overall (i.e., with the latter average considering the
entire dataset). Include only age groups in cases in which there are more than five
customers who meet this criterion. You are required to use a nested query.
*/
SELECT COUNT(*) Customer_id, Age
FROM customer_survey
WHERE Customer_Reviews_Importance >
  (SELECT AVG(Customer_Reviews_Importance)
  FROM customer_survey
  WHERE Purchase_Frequency_Monthly = 'H')
GROUP BY Age HAVING COUNT(Customer_id) > 5;

/*
A query that will retrieve brand name and the quantity of products sold at stores in CA,
grouped by brand, and sorted in descending order by the quantity of products. You are
required to use one of the JOIN commands.
*/
SELECT brand_name, SUM(quantity)
FROM brands JOIN products
  ON brands.brand_id = products.brand_id
    JOIN order_items
  ON products.product_id = order_items.product_id
    JOIN orders
  ON order_items.order_id = orders.order_id
    JOIN stores
  ON orders.store_id = stores.store_id
WHERE stores.state = 'CA'
GROUP BY brands.brand_name
ORDER BY SUM(order_items.quantity) DESC;

/*
A query that will retrieve the distinct order IDs, customer IDs, customer first names,
customer last names for those instances when the order was placed by a customer that is
either in San Diego or Bronx and processed by a store in either CA or NY. In addition,
the order was placed before 2017 (2016 or earlier). Return the results sorted in
ascending order by order IDs. You are required to use the set inclusion to condition on
the customer city and store state.
*/
SELECT DISTINCT orders.order_id, customers.customer_id, customers.first_name, customers.last_name
FROM orders JOIN customers
  ON orders.customer_id = customers.customer_id
    JOIN stores
  ON orders.store_id = stores.store_id
WHERE customers.city IN ('San Diego', 'Bronx')
  AND stores.state IN ('CA', 'NY')
  AND orders.order_date < '2017-01-01'
ORDER BY order_id ASC;

/*
A query that will retrieve the distinct product IDs, product names, list prices, and
product brand names for products that were ordered by customers between 2017-01-23
and 2017-11-20. Return the results sorted in ascending order by product IDs. You are
required to use ranges when writing some of the conditions.
*/
SELECT DISTINCT products.product_id, products.product_name, products.list_price, brands.brand_name
FROM brands JOIN products
  ON products.brand_id = brands.brand_id
  JOIN order_items ON products.product_id = order_items.product_id
  JOIN orders ON order_items.order_id = orders.order_id
WHERE orders.order_date BETWEEN '2017-01-2023' AND '2017-11-20'
ORDER BY products.product_id ASC;

/*
A query that will retrieve order id, customer first name, customer last name, store name,
and store city for those instances when an order consists of more than 4 items and the
item with the highest list price is above 1000. Return the results sorted in ascending
order by order id and limit the number of results to 10.
*/
SELECT orders.order_id, customers.first_name, customers.last_name, stores.store_name, stores.city
FROM customers JOIN orders
  ON customers.customer_id = orders.customer_id
  JOIN stores ON orders.store_id = stores.store_id
  WHERE orders.order_id IN (
        SELECT order_id
        FROM order_items
          JOIN products ON order_items.product_id = products.product_id
      GROUP BY order_items.order_id
      HAVING COUNT(*) > 4 AND MAX(products.list_price) > 1000)
ORDER BY orders.order_id ASC
LIMIT 10;

/*
A query that will retrieve, for each store, the product(s) that has(have) the highest
quantity in stock. The fields to be returned are store_id, store_name, quantity,
product_id, and product_name. Return the results sorted in ascending order by store
IDs. For each store, there might be multiple products that have that highest quantity in
stock, and you are required to return all the products that satisfy this requirement. You
are required to use one of the JOIN commands, a NESTED query within the FROM
clause, and aliases for some variable and table names.
*/
SELECT stores.store_id, stores.store_name, stocks.quantity, products.product_id, products.product_name
FROM stores JOIN stocks
  ON stores.store_id = stocks.store_id
  JOIN products ON products.product_id = stocks.product_id
  JOIN (SELECT store_id, MAX(quantity) AS max_stock
        FROM stocks
        GROUP BY store_id) AS max_stock_table
  ON stocks.store_id = max_stock_table.store_id
  WHERE stocks.quantity = max_stock_table.max_stock
ORDER BY stores.store_id ASC;

/*
A query that will retrieve, for each store, the staff member(s) that assisted with the 
highest number of orders. The fields to be returned are store_id, store state, staff 
member info (ID, last name, first name) and total number of sales by that staff member.
Use a double-nested query. (Most complex query of the project)
*/
SELECT
  stores.store_id,
  stores.state,
  staffs.staff_id,
  staffs.last_name,
  staffs.first_name,
  ss.total_sales
FROM
  stores
JOIN (
  SELECT
      orders.store_id,
      orders.staff_id,
      COUNT(orders.order_id) AS total_sales
  FROM
      orders
  GROUP BY
      orders.store_id, orders.staff_id
) AS ss ON stores.store_id = ss.store_id
JOIN staffs ON ss.staff_id = staffs.staff_id
WHERE
  (ss.store_id, ss.total_sales) IN (
      SELECT
          store_id,
          MAX(total_sales)
      FROM (
          SELECT
              orders.store_id,
              orders.staff_id,
              COUNT(orders.order_id) AS total_sales
          FROM
              orders
          GROUP BY
              orders.store_id, orders.staff_id
      ) AS total_sales_per_staff
      GROUP BY
          store_id
  )
ORDER BY
  stores.store_id;






