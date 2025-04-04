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
CREATE TABLE IF NOT EXISTS motherboard (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    socket VARCHAR(50),
    form_factor VARCHAR(50),
    max_memory INT,
    memory_slots INT,
    color VARCHAR(50)
);
"""

# Insert query
INSERT_QUERY = """
INSERT INTO motherboard (name, price, socket, form_factor, max_memory, memory_slots, color)
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
                max_memory = int(row["max_memory"]) if row["max_memory"].strip() else None
                memory_slots = int(row["memory_slots"]) if row["memory_slots"].strip() else None

                cursor.execute(INSERT_QUERY, (
                    row["name"],
                    price,
                    row["socket"] if row["socket"].strip() else None,
                    row["form_factor"] if row["form_factor"].strip() else None,
                    max_memory,
                    memory_slots,
                    row["color"] if row["color"].strip() else None
                ))

        # Commit and close
        conn.commit()
        print("motherboard data inserted successfully!")

    except pymysql.MySQLError as e:
        print("MySQL Error:", e)
    except Exception as e:
        print("General Error:", e)
    finally:
        if conn:
            conn.close()


