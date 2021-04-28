import os
import subprocess
import platform

import mysql.connector
from twilio.rest import Client

from datetime import datetime


# Twilio config
account_sid = 'AC221b3b1e88f0525b3157fb16ce06cf57'
auth_token = 'b17f699d9c9bb57c378fb9a249f3ac32'
client = Client(account_sid, auth_token)

# Connect to db
db = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="",
    database="servermonitor",
)
mycursor = db.cursor()


# Send Whatsapp Msg
def send_whatsapp_msg(client, body, phone_numbers):
    for phone_number in phone_numbers:
        client.messages.create(
            from_='whatsapp:+14155238886',
            body=f'{body}',
            to=f'whatsapp:{phone_number}'
        )  # +94776365737


# Get current date and time
def get_date_time():
    now = datetime.now()
    date_time = now.strftime("%Y-%m-%d %H:%M:%S")
    return date_time


# Adding data to table in db
def main_add(db, mycursor, sql, val):
    mycursor.execute(sql, val)
    db.commit()


# Selecting data from table in db and returning list
def main_select(db, mycursor, sql):
    mycursor.execute(sql)
    list = []
    for x in mycursor:
        list.append(x)
    return list


# ping function
def ping_ip(ip, n):
    response = os.popen(f"ping {ip} -n {n}").read()
    if f"Received = {n}" and "Approximate" in response:
        return True
    elif "Received = 0" in response:
        return False
    else:
        return False


# Checking for internet connection
if not ping_ip("8.8.8.8", 4):
    sql = "INSERT INTO run_logs (description, log_time) VALUES (%s, %s)"
    val = ('Error : No Internet Connection', get_date_time())
    main_add(db, mycursor, sql, val)
    exit()


# Getting ip data from db
sql = "SELECT ip_address, alias FROM ip_addresses WHERE is_active='1'"
ip_list = main_select(db, mycursor, sql)

# Checking if ip_lst is empty
if not ip_list:
    sql = "INSERT INTO run_logs (description, log_time) VALUES (%s, %s)"
    val = ('Error : No IP addresses retreived from db', get_date_time())
    main_add(db, mycursor, sql, val)
    exit()
else:
    total_ip = len(ip_list)

# Setting counter variables
successful_pings = 0
failed_pings = 0

# Opening log text files
temp_logs_file = open("temp_logs.txt", "a")

# Iterating through each ip in ip_list
for ip in ip_list:
    if ping_ip(ip[0], 4):
        temp_logs_file.write(
            get_date_time() + f" - UP {ip[0]} Ping Successful" + "\n")
        successful_pings += 1
    else:
        temp_logs_file.write(
            get_date_time() + f" - DOWN {ip[0]} Ping Unsuccessful" + "\n")
        failed_pings += 1

temp_logs_file.close()

# Adding success log to db
sql = "INSERT INTO run_logs (description, successful_pings, failed_pings, log_time) VALUES (%s, %s, %s, %s)"
val = ('Script Execution Successful',
       f"{successful_pings}/{total_ip}", f"{failed_pings}/{total_ip}", get_date_time())
main_add(db, mycursor, sql, val)

print("Complete")

exit()
