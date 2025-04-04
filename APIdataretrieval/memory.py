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
CREATE TABLE IF NOT EXISTS memory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    speed VARCHAR(30),
    modules VARCHAR(20),
    price_per_gb DECIMAL(10,3),
    color VARCHAR(100),
    first_word_latency DECIMAL(10,2),
    cas_latency DECIMAL(10,2)
);
"""

# Insert query
INSERT_QUERY = """
INSERT INTO memory (name, price, speed, modules, price_per_gb, color, first_word_latency, cas_latency)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s);
"""



# Read CSV and insert into MySQL
def insert_csv_to_mysql(csv_filename):
    try:
        # Connect to MySQL
        conn = pymysql.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # Create table
        cursor.execute(CREATE_TABLE_QUERY)

        # Read and insert CSV data
        with open(csv_filename, newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                price = float(row["price"]) if row["price"].strip() else None
                speed = row["speed"]
                modules = row["modules"].replace(",", "x") if row["modules"].strip() else None
                price_per_gb = float(row["price_per_gb"]) if row["price_per_gb"].strip() else None
                first_word_latency = float(row["first_word_latency"]) if row["first_word_latency"].strip() else None
                cas_latency = float(row["cas_latency"]) if row["cas_latency"].strip() else None

                cursor.execute(INSERT_QUERY, (
                    row["name"],
                    price,
                    speed,
                    modules,
                    price_per_gb,
                    row["color"] if row["color"].strip() else None,
                    first_word_latency,
                    cas_latency
                ))

        # Commit and close
        conn.commit()
        print("memory data inserted successfully!")

    except pymysql.MySQLError as e:
        print("MySQL Error:", e)
    except Exception as e:
        print("General Error:", e)
    finally:
        if conn:
            conn.close()


