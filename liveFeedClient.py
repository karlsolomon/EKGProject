'''
    Simple socket server using threads
'''
 
import socket
import sys
import time

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_address = ("172.16.24.183", 8083)
sock.connect(server_address)

try:
    while True:
        message = '1'
        send_time = time.time
        sock.sendall(message)
        data = sock.recv(4000)
        received_time = time.time
        print(len(data))
finally:
    sock.close()
    print("closed Connection")
