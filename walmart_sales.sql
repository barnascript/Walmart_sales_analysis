-- Create database
CREATE DATABASE IF NOT EXISTS WalmartSales;

-- Create table`WalmartSales`
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- Data cleaning
SELECT
	*
FROM sales;

-- Add the time_of_day column
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;

-- Add day_name column
SELECT
	date,
	DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- Add month_name column
SELECT
	date,
	MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);


-- EXPLORATORY DATA ANALYSIS --

-- -------------- GENERIC ----------------
-- How many unique cities does the data have --
select COUNT(distinct city) from sales; -- 3 --

-- How many unique branches does the data have --
select count(distinct branch) from sales; -- 3 --



-- -------------- PRODUCT ----------------
-- How many unique product line does the data have --
select count(distinct product_line) from sales; -- 6 --

-- What is the most common payment method --
select payment_method, count(payment_method) as most
from sales 
group by payment_method; -- Cash --

-- What is the most selling product_line --
select product_line, count(product_line) as most_selling_product_line_number
from sales
group by product_line 
order by most_selling_product_line_number desc; -- Fashion Accessories --

-- What is the total revenue by month --
select sum(total) from sales; -- 320,887.07 --

-- Which month has the largest cogs --
select month_name, sum(cogs) as month_with_largest_cogs
from sales
group by month_name
order by month_with_largest_cogs desc; -- January, cog was 110, 754.16

-- What product line has the largest revenue --
select product_line, sum(total) as highest_product_line_revenue
from sales
group by product_line
order by highest_product_line_revenue desc; -- Food and Beverages by 56,144.96 --

-- Which city has the largest revenue --
select city , sum(total) as city_with_largest_revenue_num
from sales
group by city
order by city_with_largest_revenue_num desc; -- Naypyitaw, 110, 490.93 --


-- which product line has the largest vat --
select product_line, avg(vat) as largest_vat
from sales
group by product_line
order by largest_vat desc; -- Home and Life  with 16.030333124 --

-- Which product are good or bad based on average sale --
select avg(quantity) as average_quantity from sales;

select product_line,
	case
		when avg(quantity) > 6 then "Good Product"
        else "Bad Product"
	end as remarks
from sales
group by product_line;

-- which branch sold more products than average products sold --

select branch, sum(quantity) as total_quantity, 
avg(quantity) as average_quantity
from sales
group by branch
having sum(quantity) > avg(quantity)
order by sum(quantity) desc; -- Branch A with total_quantity as 1849 and  average_quantity as 5.4543--


-- What is the common product_line by gender --

SELECT product_line, gender, COUNT(gender) AS gender_count
FROM sales
GROUP BY product_line, gender
order by count(gender) desc; -- Fashion Accessories with a gender count of 96 --

-- What is the Average rating of each product line --

select product_line,  round(avg(rating), 2) from sales
group by product_line;
-- 
-- 'Food and beverages','7.11322'
-- 'Health and beauty','6.98344'
-- 'Sports and travel','6.85951'
-- 'Fashion accessories','7.02921'
-- 'Home and lifestyle','6.83750'
-- 'Electronic accessories','6.90651'


-- -------------- SALES ----------------

-- Number of sales made in each time of the day per weekday--

select  time_of_day, sum(quantity) from sales
group by time_of_day;
--
-- 'Evening','2342'
-- 'Afternoon','2102'
-- 'Morning','1028'

-- Which of the customer types brings the most revenue? --
 select customer_type, sum(total) from sales
 group by customer_type
 order by sum(total) desc;  -- 'Member','163,625.47' --
 
-- Which city has the largest tax percent/ VAT (Value Added Tax)? --

select city, sum(vat) from sales
group by city
order by sum(vat) desc; -- 'Naypyitaw', '5261.4655'

-- Which customer type pays the most in VAT?

select customer_type, sum(vat) from sales
group by customer_type
order by sum(vat) desc; -- 'Member', '7791.6715'


-- -------------- CUSTOMER ----------------

-- How many unique customer types does the data have?

select count(distinct customer_type) from sales; -- 2


-- How many unique payment methods does the data have?

select count(distinct payment_method) from sales; -- 3


-- What is the most common customer type?

select customer_type, count(customer_type) as most_customer_type from sales
group by customer_type
order by most_customer_type  desc; -- Member, 499

-- Which customer type buys the most?

select customer_type , sum(quantity) from sales
group by customer_type
order by sum(quantity) desc; -- Member

-- What is the gender of most of the customers?
select gender, count(customer_type) from sales
group by gender
order by count(customer_type) desc ; -- Male

-- What is the gender distribution per branch?
select branch, gender, count(gender),
round(count(gender) / sum(count(gender)) over (partition by branch) * 100 , 2)as gender_percentage
from sales
group by branch, gender
order by branch asc;

-- 'A','Male','179','52.80%'
-- 'A','Female','160','47.20%'
-- 'B','Female','160','48.63%'
-- 'B','Male','169','51.37%'
-- 'C','Female','177','54.13%'
-- 'C','Male','150','45.87%'



-- Which time of the day do customers give most ratings? 

select time_of_day, count(rating) from sales
group by time_of_day
order by count(rating) desc
limit 1; -- Evening 429

-- Which time of the day do customers give most ratings per branch?

select branch, time_of_day, count(rating) as count_rating
from sales
group by time_of_day, branch
order by count_rating;
--
-- 'B','Morning','58'
-- 'C','Morning','59'
-- 'A','Morning','73'
-- 'B','Afternoon','124'
-- 'C','Afternoon','126'
-- 'A','Afternoon','126'
-- 'A','Evening','140'
-- 'C','Evening','142'
-- 'B','Evening','147'

-- Which day fo the week has the best avg ratings?
select day_name, avg(rating) as average_rating
from sales
group by day_name
order by average_rating desc
limit 1; -- 'Monday', '7.13065'


-- Which day of the week has the best average ratings per branch?

select day_name, branch, avg(rating)
from sales
group by day_name, branch
order by avg(rating) desc
limit 1; -- 'Friday', 'Branch A', '7.31'

