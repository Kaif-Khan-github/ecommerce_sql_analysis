# 🛒 E-Commerce Transactions SQL Project

This project is a SQL-based analysis of e-commerce transaction data. It includes database creation, table design, data import, performance optimization with indexes, and meaningful business insights using SQL queries.

---

## 📂 Project Structure

- `ecommerce_project.sql` — Main SQL file with all queries.
- `README.md` — This file explaining the project.
- (Optional) `ecommerce_transactions.csv` — Sample data file if uploading.

---

## 🗃️ Database Setup

### 1. Create the Database & Table
Creates a new database `ecommerce_db` and a `transactions` table with columns like user name, age, country, product category, purchase amount, payment method, and transaction date.


CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;
2. Load Data
Loads CSV data into the table:


LOAD DATA INFILE '.../ecommerce_transactions.csv' ...

SQL Queries and Their Purpose
🌐 Basic Queries

SELECT * FROM transactions LIMIT 10;
Shows the first 10 rows in the transactions table.


SELECT DISTINCT Product_Category FROM transactions;
Lists all unique product categories.

SELECT SUM(Purchase_Amount) AS Total_Sales FROM transactions;
Calculates the total sales value.

📊 Grouping & Aggregation

SELECT Country, AVG(Purchase_Amount) FROM transactions GROUP BY Country;
Shows average purchase per country.


SELECT Product_Category, SUM(Purchase_Amount) FROM transactions GROUP BY Product_Category;
Total sales per product category.

🔎 Filter Queries

SELECT * FROM transactions WHERE Payment_Method = 'PayPal';
Finds all PayPal transactions.


SELECT * FROM transactions WHERE Age > 40;
Lists customers over 40 years old.

SELECT * FROM transactions WHERE Purchase_Amount > (SELECT AVG(Purchase_Amount) FROM transactions);
Filters transactions above average value.

🧠 Views

CREATE VIEW top_buyers AS
SELECT User_Name, SUM(Purchase_Amount) AS Total_Spent
FROM transactions
GROUP BY User_Name
ORDER BY Total_Spent DESC;
View showing top buyers by total spending.


CREATE VIEW country_sales AS
SELECT Country, SUM(Purchase_Amount) AS Total_Sales
FROM transactions
GROUP BY Country;
View for sales grouped by country.

⚙️ Indexes

CREATE INDEX idx_country ON transactions(Country);
CREATE INDEX idx_product_category ON transactions(Product_Category);
Speeds up queries that filter or group by country or product category.

Check indexes with:


SHOW INDEXES FROM transactions;
📈 Advanced Analysis
Monthly Sales Trend

SELECT DATE_FORMAT(Transaction_Date, '%Y-%m') AS Month, SUM(Purchase_Amount) AS Monthly_Sales
FROM transactions
GROUP BY Month;
Age Group Behavior

SELECT 
  CASE 
    WHEN Age < 20 THEN 'Under 20'
    WHEN Age BETWEEN 20 AND 29 THEN '20s'
    WHEN Age BETWEEN 30 AND 39 THEN '30s'
    WHEN Age BETWEEN 40 AND 49 THEN '40s'
    ELSE '50+'
  END AS Age_Group,
  COUNT(*) AS Total_Transactions,
  SUM(Purchase_Amount) AS Total_Spent
FROM transactions
GROUP BY Age_Group;
High-Volume Buyers

SELECT User_Name, COUNT(*) AS Total_Transactions
FROM transactions
GROUP BY User_Name
HAVING COUNT(*) > 5;
🚀 How to Use
Clone or download this repo.

Open ecommerce_project.sql in MySQL Workbench.

Run the SQL step-by-step or all at once.

Explore the views and advanced queries for insights.

🧠 Insights Gained
Which products are best-sellers?

What countries generate the most revenue?

Which age group spends the most?

Which payment methods are most used?

Who are the top customers?

