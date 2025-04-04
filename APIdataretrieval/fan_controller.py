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
CREATE TABLE IF NOT EXISTS fan_controller (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    channels INT,
    channel_wattage DECIMAL(10,2),
    pwm TINYINT(1),
    form_factor VARCHAR(50),
    color VARCHAR(50)
);
"""

# Insert query
INSERT_QUERY = """
INSERT INTO fan_controller (name, price, channels, channel_wattage, pwm, form_factor, color)
VALUES (%s, %s, %s, %s, %s, %s, %s);
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
                channels = int(row["channels"]) if row["channels"].strip() else None
                channel_wattage = float(row["channel_wattage"]) if row["channel_wattage"].strip() else None
                pwm = 1 if row["pwm"].strip().lower() == "true" else 0

                cursor.execute(INSERT_QUERY, (
                    row["name"],
                    price,
                    channels,
                    channel_wattage,
                    pwm,
                    row["form_factor"] if row["form_factor"].strip() else None,
                    row["color"] if row["color"].strip() else None
                ))

        # Commit and close
        conn.commit()
        print("fan_controller data inserted successfully!")

    except pymysql.MySQLError as e:
        print("MySQL Error:", e)
    except Exception as e:
        print("General Error:", e)
    finally:
        if conn:
            conn.close()


