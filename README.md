# 🛒 Walmart Sales Data Project: Data Cleaning & Business Insights

This project demonstrates the complete **data cleaning** and **business intelligence (BI)** workflow for Walmart sales data using **Python (Pandas)** and **PostgreSQL**. It includes:

## 📌 Project Overview

The goal of this project is to:
- Load raw Walmart sales data from a CSV file
- Clean and prepare the data for analysis using Python
- Calculate a new column for total sales amount
- Upload the cleaned dataset to a local PostgreSQL database
- Running **analytical SQL queries** to uncover business insights

- ## 📁 Dataset
The dataset used in this project is walmart.csv, which contains:
- Branch, city, and customer details
- Unit prices with currency symbols
- Sales quantities
- Other transaction metadata

- ## ⚙️ Features & Tasks Performed

✅ 1. Load & Preview Data
python
walmart_df = pd.read_csv('walmart.csv', encoding_errors='ignore')
walmart_df.head()

✅ 2. Clean Data
Remove duplicate records
Drop rows with missing values
Strip dollar signs ($) from unit_price column and convert to float
Calculate total_amount = unit_price * quantity
Rename column names for consistency (Branch → branch, City → city)

✅ 3. Save Cleaned Data to CSV
walmart_df.to_csv('walmart_cleaned_data.csv', index=False)

✅ 4. Load Data into PostgreSQL
Using SQLAlchemy and psycopg2, the cleaned data is saved to a PostgreSQL database named walmart_db in a table called walmart.

🧪 Requirements
Install the following Python packages:
pip install pandas sqlalchemy psycopg2
You also need a running PostgreSQL instance with:
Username: postgres
Password: ****
Database: walmart_db

🧠 Business Questions Solved (SQL)
The cleaned data is queried in PostgreSQL to answer the following business questions:
1. What are the different payment methods and their usage ?
2. Which category is the highest rated in each branch ?
3. What is the busiest day (most transactions) for each branch ?
4. Total quantity of items sold per payment method
5. Ratings by city and category
6. Most preferred payment method per branch (with CTE)
7. Total revenue and profit per category
8. Categorize sales by time of day
9. Identify 5 branches with highest revenue decrease YoY (2022 vs 2023)

📦 Tools & Technologies Used
Python (Pandas, SQLAlchemy)
PostgreSQL (SQL queries)
Jupyter Notebook / VS Code
Excel / CSV for data handling

📈 Outcomes
Clean, query-ready dataset of Walmart sales
Business KPIs: top categories, preferred payment methods, busiest times
SQL querying skills applied to real-world scenarios
Data pipeline from CSV to PostgreSQL using Python

Connect with Me
Olusegun
📫 Email: [olukayodeoluseguno@gmail.com]

🔗 LinkedIn: [www.linkedin.com/in/olukayodeolusegun]


