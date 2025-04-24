
CREATE DATABASE IF NOT EXISTS ecommerce_db;


USE ecommerce_db;


CREATE TABLE transactions (
    Transaction_ID INT PRIMARY KEY,
    User_Name VARCHAR(100),
    Age INT,
    Country VARCHAR(100),
    Product_Category VARCHAR(100),
    Purchase_Amount DECIMAL(10,2),
    Payment_Method VARCHAR(50),
    Transaction_Date DATE
);




LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ecommerce_transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM transactions
LIMIT 10;

SELECT DISTINCT Product_Category FROM transactions;

SELECT SUM(Purchase_Amount) AS Total_Sales FROM transactions;

SELECT Country, AVG(Purchase_Amount) AS Avg_Purchase
FROM transactions
GROUP BY Country;

SELECT * FROM transactions
WHERE Payment_Method = 'PayPal';

SELECT * FROM transactions
WHERE Age > 40;

SELECT * FROM transactions
WHERE Purchase_Amount > (
  SELECT AVG(Purchase_Amount) FROM transactions
);

#top buyers
CREATE VIEW top_buyers AS
SELECT User_Name, SUM(Purchase_Amount) AS Total_Spent
FROM transactions
GROUP BY User_Name
ORDER BY Total_Spent DESC;

SELECT * FROM top_buyers LIMIT 10;


CREATE INDEX idx_country ON transactions(Country);
CREATE INDEX idx_product_category ON transactions(Product_Category);
SHOW INDEXES FROM transactions;



#top product catagory
SELECT Product_Category, SUM(Purchase_Amount) AS Total_Sales
FROM transactions
GROUP BY Product_Category
ORDER BY Total_Sales DESC
LIMIT 5;


#most popular pament method
SELECT Payment_Method, COUNT(*) AS Total_Transactions
FROM transactions
GROUP BY Payment_Method
ORDER BY Total_Transactions DESC;


#monthly sales trends
SELECT 
    DATE_FORMAT(Transaction_Date, '%Y-%m') AS Month,
    SUM(Purchase_Amount) AS Monthly_Sales
FROM transactions
GROUP BY Month
ORDER BY Month;


#age group analysis
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
GROUP BY Age_Group
ORDER BY Total_Spent DESC;


#create a view for country-wise sales
CREATE VIEW country_sales AS
SELECT Country, SUM(Purchase_Amount) AS Total_Sales
FROM transactions
GROUP BY Country;
#Then use it:
SELECT * FROM country_sales ORDER BY Total_Sales DESC;


#find user with more then 5 transactions
SELECT User_Name, COUNT(*) AS Total_Transactions
FROM transactions
GROUP BY User_Name
HAVING COUNT(*) > 5
ORDER BY Total_Transactions DESC;


