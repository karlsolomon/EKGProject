import socket

HOST = '172.20.10.2'
PORT = 5555
ADDR = (HOST,PORT)
BUFSIZE = 4096


client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(ADDR)
while True:
	client.send("1")
	print(client.recv(65536))
	client.send("done")
