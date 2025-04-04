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
CREATE TABLE IF NOT EXISTS case_fan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    size INT,
    color VARCHAR(50),
    rpm VARCHAR(50),
    airflow VARCHAR(50),
    noise_level VARCHAR(50),
    pwm BOOLEAN
);
"""

# Insert query
INSERT_QUERY = """
INSERT INTO case_fan (name, price, size, color, rpm, airflow, noise_level, pwm)
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
                cursor.execute(INSERT_QUERY, (
                    row["name"],
                    float(row["price"]) if row["price"].strip() else None,
                    int(row["size"]),
                    row["color"],
                    row["rpm"] if row["rpm"] else None,
                    row["airflow"],
                    row["noise_level"],
                    1 if row["pwm"].strip().lower() == "true" else 0
                ))

        # Commit and close
        conn.commit()
        print("case_fan data inserted successfully!")

    except pymysql.MySQLError as e:
        print("Error:", e)
    
    finally:
        if conn:
            conn.close()


