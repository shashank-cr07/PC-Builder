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
CREATE TABLE IF NOT EXISTS video_card (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    chipset VARCHAR(100),
    memory DECIMAL(10,2),
    core_clock INT,
    boost_clock INT,
    color VARCHAR(50),
    length INT
);
"""

# Insert query
INSERT_QUERY = """
INSERT INTO video_card (name, price, chipset, memory, core_clock, boost_clock, color, length)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s);
"""

# Read CSV and insert into MySQL
def insert_csv_to_mysql(csv_filename):
    try:
        conn = pymysql.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # Create table
        cursor.execute(CREATE_TABLE_QUERY)

        with open(csv_filename, newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                cursor.execute(INSERT_QUERY, (
                    row["name"],
                    float(row["price"]) if row["price"].strip() else None,
                    row["chipset"] if row["chipset"].strip() else None,
                    float(row["memory"]) if row["memory"].strip() else None,
                    int(row["core_clock"]) if row["core_clock"].strip() else None,
                    int(row["boost_clock"]) if row["boost_clock"].strip() else None,
                    row["color"] if row["color"].strip() else None,
                    int(row["length"]) if row["length"].strip() else None
                ))

        conn.commit()
        print("video_card data inserted successfully!")

    except pymysql.MySQLError as e:
        print("MySQL Error:", e)
    except Exception as e:
        print("General Error:", e)
    finally:
        if conn:
            conn.close()


