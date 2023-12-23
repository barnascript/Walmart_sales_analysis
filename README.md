# Walmart_sales_analysis

## About

This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized. The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition.

"In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact." source



## Purposes Of The Project

The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

## About Data

The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition. This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:


<table>
    <tr>
        <th>Column</th>
        <th>Description</th>
        <th>Data Type</th>
    </tr>
    <tr>
        <td>invoice_id</td>
        <td>Invoice of the sales made</td>
        <td>VARCHAR(30)</td>
    </tr>
    <tr>
        <td>branch</td>
        <td>Branch at which sales were made</td>
        <td>VARCHAR(5)</td>
    </tr>
    <tr>
        <td>city</td>
        <td>The location of the branch</td>
        <td>VARCHAR(30)</td>
    </tr>
    <tr>
        <td>customer_type</td>
        <td>The type of the customer</td>
        <td>VARCHAR(30)</td>
    </tr>
    <tr>
        <td>gender</td>
        <td>Gender of the customer making purchase</td>
        <td>VARCHAR(10)</td>
    </tr>
    <tr>
        <td>product_line</td>
        <td>Product line of the product sold</td>
        <td>VARCHAR(100)</td>
    </tr>
    <tr>
        <td>unit_price</td>
        <td>The price of each product</td>
        <td>DECIMAL(10, 2)</td>
    </tr>
    <tr>
        <td>quantity</td>
        <td>The amount of the product sold</td>
        <td>INT</td>
    </tr>
    <tr>
        <td>VAT</td>
        <td>The amount of tax on the purchase</td>
        <td>FLOAT(6, 4)</td>
    </tr>
    <tr>
        <td>total</td>
        <td>The total cost of the purchase</td>
        <td>DECIMAL(10, 2)</td>
    </tr>
    <tr>
        <td>date</td>
        <td>The date on which the purchase was made</td>
        <td>DATE</td>
    </tr>
    <tr>
        <td>time</td>
        <td>The time at which the purchase was made</td>
        <td>TIMESTAMP</td>
    </tr>
    <tr>
        <td>payment_method</td>
        <td>The total amount paid</td>
        <td>DECIMAL(10, 2)</td>
    </tr>
    <tr>
        <td>cogs</td>
        <td>Cost Of Goods Sold</td>
        <td>DECIMAL(10, 2)</td>
    </tr>
    <tr>
        <td>gross_margin_percentage</td>
        <td>Gross margin percentage</td>
        <td>FLOAT(11, 9)</td>
    </tr>
    <tr>
        <td>gross_income</td>
        <td>Gross Income</td>
        <td>DECIMAL(10, 2)</td>
    </tr>
    <tr>
        <td>rating</td>
        <td>Rating</td>
        <td>FLOAT(2, 1)</td>
    </tr>
</table>



## Analysis List

#### Product Analysis
Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

#### Sales Analysis
This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

#### Customer Analysis
This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.


## Approach Used

#### Data Wrangling: This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.

1. Build a database
2. Create table and insert the data.
3. Select columns with null values in them. There are no null values in our database as in creating the tables, we set NOT NULL for each field, hence null values are filtered out.

#### Feature Engineering: This will help use generate some new columns from existing ones.



4. Add a new column named  <span style="color:grey">
time_of_day
</span>to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
5. Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.
6. Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.
   
#### Exploratory Data Analysis (EDA): Exploratory data analysis is done to answer the listed questions and aims of this project.

#### Conclusion:


## Business Questions To Answer

### Generic Question

1. How many unique cities does the data have?
2. In which city is each branch?


### Product

3. How many unique product lines does the data have?
4. What is the most common payment method?
5. What is the most selling product line?
6. What is the total revenue by month?
7. What month had the largest COGS?
8. What product line had the largest revenue?
9. What is the city with the largest revenue?
10. What product line had the largest VAT?
11. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
12. Which branch sold more products than average product sold?
13. What is the most common product line by gender?
14. What is the average rating of each product line?


### Sales

15. Number of sales made in each time of the day per weekday
16. Which of the customer types brings the most revenue?
17. Which city has the largest tax percent/ VAT (Value Added Tax)?
18. Which customer type pays the most in VAT?

    
### Customer

19. How many unique customer types does the data have?
20. How many unique payment methods does the data have?
21. What is the most common customer type?
22. Which customer type buys the most?
23. What is the gender of most of the customers?
24. What is the gender distribution per branch?
25. Which time of the day do customers give most ratings?
26. Which time of the day do customers give most ratings per branch?
27. Which day fo the week has the best avg ratings?
28. Which day of the week has the best average ratings per branch?


## Code

For the rest of the code, check the SQL_queries.sql file

``` -- Create database
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



