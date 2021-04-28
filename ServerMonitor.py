import socket
import ssl
from datetime import datetime

import subprocess
import platform

import mysql.connector
from pushbullet.pushbullet import PushBullet

import schedule
import time


# Opening log text files
def write_run_log(log):
    temp_logs_file = open(
        "run_logs/" + get_date_time(2) + "_run_log.txt", "a")
    temp_logs_file.write(get_date_time() + " - " + log + "\n")
    print(log)
    temp_logs_file.close()


# Get current date and time
def get_date_time(mode=1):
    now = datetime.now()
    if mode == 1:
        return now.strftime("%Y-%m-%d %H:%M:%S")
    elif mode == 2:
        return now.strftime("%Y-%m-%d")
    elif mode == 3:
        return now.strftime("%H:%M:%S")


# Connecting to network
try:
    output = subprocess.check_output("ping -{} 4 {}".format('n' if platform.system().lower(
    ) == "windows" else 'c', "8.8.8.8"), shell=True, universal_newlines=True)
    if 'General failure' in output:
        write_run_log("Error : Cannot connect to network")
        exit()
    elif 'unreachable' in output:
        write_run_log("Error : Cannot connect to network")
        exit()
except Exception:
    write_run_log("Error : Cannot connect to network")
    exit()

# Connect to db
try:
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="",
        database="servermonitor",
    )
    mycursor = db.cursor()
except:
    write_run_log("Error : Cannot connect to db")
    exit()


# Adding/Updating/Deleting data to table in db
def main_query(sql, val):
    mycursor.execute(sql, val)
    db.commit()


# Selecting data from table in db and returning list
def main_select(sql):
    mycursor.execute(sql)
    list = []
    for x in mycursor:
        list.append(x)
    return list


# Send Pushbullet Message
def send_pushbullet(title, body):
    apiKey = "o.rZN2LOcbis0n0cJCP18pCLHsyHiapLRs"
    p = PushBullet(apiKey)
    devices = p.getDevices()
    try:
        p.pushNote(devices[0]["iden"], title, body)
    except:
        write_run_log("Error : Cannot send pushbullet")


class Server():
    def __init__(self, id, name, alias, port, connection, priority, alert):
        self.id = id
        self.name = name
        self.alias = alias
        self.port = port
        self.connection = connection.lower()
        self.priority = priority.lower()

        self.history = []
        self.alert = True if alert == 1 else False

    # Check server status
    def check_connection(self):
        msg = ""
        success = False
        now = datetime.now()

        try:
            if self.connection == "plain":
                socket.create_connection((self.name, self.port), timeout=10)
                msg = f"{self.name} is up. On port {self.port} with {self.connection}."
                success = True
            elif self.connection == "ssl":
                ssl.wrap_socket(socket.create_connection(
                    (self.name, self.port), timeout=10))
                msg = f"{self.name} is up. On port {self.port} with {self.connection}."
                success = True
            else:
                if self.ping():
                    msg = f"{self.alias}: {self.name} is up. Ping Successful."
                    success = True
                else:
                    msg = f"{self.alias}: {self.name} is down. Ping Unsuccessful."
        except socket.timeout:
            msg = f"{self.alias}: {self.name} timeout. On port {self.port}"
        except (ConnectionRefusedError, ConnectionResetError) as e:
            msg = f"{self.alias}: {self.name} {e}"
        except Exception as e:
            msg = f"No Clue??: {e}"

        write_run_log(msg)
        self.create_history(msg, success, now)

        # Send alert if high priority server
        if success == False and self.alert == False and self.priority == "high":
            # Send "server down" alert to system admins
            self.alert = True
            send_pushbullet("Server Down", msg)
            # Add a fail log for server
            sql = "INSERT INTO fail_logs (ip_address, alias, description, log_time) VALUES (%s, %s, %s, %s)"
            val = (f'{self.name}', f"{self.alias}", f"{msg}", get_date_time())
            main_query(sql, val)
            # Update server alert status to True
            sql = "UPDATE servers SET alert = %s WHERE id = %s"
            val = ("1", f"{self.id}")
            main_query(sql, val)

            return False
        # No alert is sent if low priority server
        elif success == False:
            # Add a fail log for server
            sql = "INSERT INTO fail_logs (ip_address, alias, description, log_time) VALUES (%s, %s, %s, %s)"
            val = (f'{self.name}', f"{self.alias}", f"{msg}", get_date_time())
            main_query(sql, val)

            return False
        # Server is up and running
        else:
            if self.alert == True:
                # Send "server up" alert to system admins
                self.alert = False
                send_pushbullet("Server Up", msg)
                # Update server alert status to False
                sql = "UPDATE servers SET alert = %s WHERE id = %s"
                val = ("0", f"{self.id}")
                main_query(sql, val)

            return True

    def create_history(self, msg, success, now):
        history_max = 100
        self.history.append((msg, success, now))

        while len(self.history) > history_max:
            self.history.pop(0)

    def ping(self):
        try:
            output = subprocess.check_output("ping -{} 4 {}".format('n' if platform.system().lower(
            ) == "windows" else 'c', self.name), shell=True, universal_newlines=True)
            if 'unreachable' in output:
                return False
            else:
                return True
        except Exception:
            return False


if __name__ == "__main__":
    def default_run():
        # Getting server data from db
        sql = "SELECT id,ip_address,alias,port,connection,priority,alert FROM servers WHERE is_active='1'"
        servers = main_select(sql)

        # Getting phone numbers data from db
        # sql = "SELECT phone_number,alias FROM phone_numbers WHERE is_active='1'"
        # phone_numbers = main_select(sql)

        # Checking if server list is empty
        if not servers:
            sql = "INSERT INTO run_logs (description, log_time) VALUES (%s, %s)"
            val = ('Error : No IP addresses retreived from db', get_date_time())
            main_query(sql, val)
            exit()
        else:
            total_servers = len(servers)

        # Setting counter variables
        successful_pings = 0
        failed_pings = 0

        write_run_log("==== Script execution started ====")

        for server in servers:
            server = Server(server[0], server[1], server[2],
                            server[3], server[4], server[5], server[6])
            print(f"Pinging {server.name} : {server.alias}...")
            if server.check_connection():
                successful_pings += 1
            else:
                failed_pings += 1

        # sql = "INSERT INTO run_logs (description, successful_pings, failed_pings, log_time) VALUES (%s, %s, %s, %s)"
        # val = ('Script Execution Successful',
        #        f"{successful_pings}/{total_servers}", f"{failed_pings}/{total_servers}", get_date_time())
        # main_query(sql, val)

        write_run_log(
            f"==== Script execution ended / Total = {total_servers}, Successful = {successful_pings}, Failed = {failed_pings} ====")

    schedule.every(0.5).minutes.do(default_run)
    while True:
        schedule.run_pending()
        time.sleep(1)
