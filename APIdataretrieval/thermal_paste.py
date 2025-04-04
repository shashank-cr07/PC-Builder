import pymysql
import csv
import os
from dotenv import load_dotenv

load_dotenv()

# MySQL Database Configuration
DB_CONFIG = {
    "host": os.getenv("DB_HOST"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "database": os.getenv("DB_NAME"),
}

# Table creation query
CREATE_TABLE_QUERY = """
CREATE TABLE IF NOT EXISTS thermal_paste (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    amount DECIMAL(5,2)
);
"""

# Insert query
INSERT_QUERY = """
INSERT INTO thermal_paste (name, price, amount)
VALUES (%s, %s, %s);
"""

# Read CSV and insert into MySQL
def insert_csv_to_mysql(csv_filename):
    try:
        conn = pymysql.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # Create table if it doesn't exist
        cursor.execute(CREATE_TABLE_QUERY)

        with open(csv_filename, newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                price = float(row["price"]) if row["price"].strip() else None
                amount = float(row["amount"]) if row["amount"].strip() else None

                cursor.execute(INSERT_QUERY, (
                    row["name"],
                    price,
                    amount
                ))

        conn.commit()
        print("thermal_paste data inserted successfully!")

    except pymysql.MySQLError as e:
        print("MySQL Error:", e)
    except Exception as e:
        print("General Error:", e)
    finally:
        if conn:
            conn.close()


