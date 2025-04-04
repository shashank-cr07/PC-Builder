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
CREATE TABLE IF NOT EXISTS power_supply (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    type VARCHAR(50),
    efficiency VARCHAR(20),
    wattage INT,
    modular VARCHAR(20),
    color VARCHAR(50)
);
"""

# Insert query
INSERT_QUERY = """
INSERT INTO power_supply (name, price, type, efficiency, wattage, modular, color)
VALUES (%s, %s, %s, %s, %s, %s, %s);
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
                wattage = int(row["wattage"]) if row["wattage"].strip() else None

                cursor.execute(INSERT_QUERY, (
                    row["name"],
                    price,
                    row["type"] if row["type"].strip() else None,
                    row["efficiency"] if row["efficiency"].strip() else None,
                    wattage,
                    row["modular"] if row["modular"].strip() else None,
                    row["color"] if row["color"].strip() else None
                ))

        # Commit and close
        conn.commit()
        print("power_supply data inserted successfully!")

    except pymysql.MySQLError as e:
        print("MySQL Error:", e)
    except Exception as e:
        print("General Error:", e)
    finally:
        if conn:
            conn.close()

