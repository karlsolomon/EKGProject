import socket

HOST = '129.116.145.200'
PORT = 8080
ADDR = (HOST,PORT)
BUFSIZE = 4096


client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(ADDR)
while True:
	print(client.read())