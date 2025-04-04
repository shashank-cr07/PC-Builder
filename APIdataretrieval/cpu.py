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
CREATE TABLE IF NOT EXISTS cpu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    core_count INT,
    core_clock DECIMAL(10,2),
    boost_clock DECIMAL(10,2),
    tdp INT,
    graphics VARCHAR(100),
    smt TINYINT(1) -- Boolean (0 or 1)
);
"""

# Insert query
INSERT_QUERY = """
INSERT INTO cpu (name, price, core_count, core_clock, boost_clock, tdp, graphics, smt)
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
                # Handle empty values
                price = float(row["price"]) if row["price"].strip() else None
                core_count = int(row["core_count"]) if row["core_count"].strip() else None
                core_clock = float(row["core_clock"]) if row["core_clock"].strip() else None
                boost_clock = float(row["boost_clock"]) if row["boost_clock"].strip() else None
                tdp = int(row["tdp"]) if row["tdp"].strip() else None
                smt = 1 if row["smt"].strip().lower() == "true" else 0
                
                cursor.execute(INSERT_QUERY, (
                    row["name"],
                    price,
                    core_count,
                    core_clock,
                    boost_clock,
                    tdp,
                    row["graphics"] if row["graphics"].strip() else None,
                    smt
                ))

        # Commit and close
        conn.commit()
        print("cpu data inserted successfully!")

    except pymysql.MySQLError as e:
        print("Error:", e)
    
    finally:
        if conn:
            conn.close()


