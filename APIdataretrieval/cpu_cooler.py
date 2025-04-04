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
CREATE TABLE IF NOT EXISTS cpu_cooler (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    rpm VARCHAR(50),
    noise_level VARCHAR(50),
    color VARCHAR(50),
    size VARCHAR(50)
);
"""

# Insert query
INSERT_QUERY = """
INSERT INTO cpu_cooler (name, price, rpm, noise_level, color, size)
VALUES (%s, %s, %s, %s, %s, %s);
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

                noise_level = row["noise_level"] if row["noise_level"].strip() else None
                
                cursor.execute(INSERT_QUERY, (
                    row["name"],
                    price,
                    row["rpm"] if row["rpm"].strip() else None,
                    noise_level,
                    row["color"] if row["color"].strip() else None,
                    row["size"] if row["size"].strip() else None
                ))

        # Commit and close
        conn.commit()
        print("cpu_cooler data inserted successfully!")

    except pymysql.MySQLError as e:
        print("Error:", e)
    
    finally:
        if conn:
            conn.close()


