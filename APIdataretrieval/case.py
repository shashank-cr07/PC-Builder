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
CREATE TABLE IF NOT EXISTS case_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    type VARCHAR(50),
    color VARCHAR(50),
    psu VARCHAR(100),
    side_panel VARCHAR(100),
    external_volume DECIMAL(10,2),
    internal_35_bays INT
);
"""

# Insert query
INSERT_QUERY = """
INSERT INTO case_table (name, price, type, color, psu, side_panel, external_volume, internal_35_bays)
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
                external_volume = float(row["external_volume"]) if row["external_volume"].strip() else None
                internal_35_bays = int(row["internal_35_bays"]) if row["internal_35_bays"].strip() else None
                
                cursor.execute(INSERT_QUERY, (
                    row["name"],
                    price,
                    row["type"],
                    row["color"],
                    row["psu"] if row["psu"].strip() else None,
                    row["side_panel"],
                    external_volume,
                    internal_35_bays
                ))

        # Commit and close
        conn.commit()
        print("case data inserted successfully!")

    except pymysql.MySQLError as e:
        print("Error:", e)
    
    finally:
        if conn:
            conn.close()


