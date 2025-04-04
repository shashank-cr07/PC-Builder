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
CREATE TABLE IF NOT EXISTS internal_hard_drive (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    capacity DECIMAL(10,2),
    price_per_gb DECIMAL(10,4),
    type VARCHAR(20),
    cache INT,
    form_factor VARCHAR(50),
    interface VARCHAR(100)
);
"""

# Insert query
INSERT_QUERY = """
INSERT INTO internal_hard_drive (name, price, capacity, price_per_gb, type, cache, form_factor, interface)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s);
"""

# Read CSV and insert into MySQL
def insert_csv_to_mysql(csv_filename):
    try:
        # Connect to MySQL
        conn = pymysql.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # Create table if not exists
        cursor.execute(CREATE_TABLE_QUERY)

        # Read CSV and insert data
        with open(csv_filename, newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                price = float(row["price"]) if row["price"].strip() else None
                capacity = float(row["capacity"]) if row["capacity"].strip() else None
                price_per_gb = float(row["price_per_gb"]) if row["price_per_gb"].strip() else None
                cache = int(row["cache"]) if row["cache"].strip() else None

                cursor.execute(INSERT_QUERY, (
                    row["name"],
                    price,
                    capacity,
                    price_per_gb,
                    row["type"] if row["type"].strip() else None,
                    cache,
                    row["form_factor"] if row["form_factor"].strip() else None,
                    row["interface"] if row["interface"].strip() else None
                ))

        # Commit and close
        conn.commit()
        print("internal_hard_drive data inserted successfully!")

    except pymysql.MySQLError as e:
        print("MySQL Error:", e)
    except Exception as e:
        print("General Error:", e)
    finally:
        if conn:
            conn.close()


