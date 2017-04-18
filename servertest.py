'''
    Simple socket server using threads
'''
 
import socket
import sys
import csv
import wiringpi2 as wpi
from threading import Thread
#import pandas
class Server(Thread):
	def __nit__(self):
		Thread.__init__(self)
		self.daemon = True
		self.start()
	def run(self):

			HOST = "10.146.6.161"   # iPhone app IP address
			PORT = 8080 # Arbitrary non-privileged port
			 
			s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
			print 'Socket created'
			 
			#Bind socket to local host and port
			data = []

			with open('samples.csv','rU') as file:
				reader = csv.reader(file,delimiter=",")
				for row in reader:
					data.append(row)
			print data[0]
			try:
				s.bind((socket.gethostname(), PORT))
			except socket.error as msg:
			    print 'Bind failed. Error Code : ' + str(msg[0]) + ' Message ' + msg[1]
			    sys.exit()
			     
			print 'Socket bind complete'
			 
			#Start listening on socket
			s.listen(10000)
			print 'Socket now listening'

			with open('samples.csv','rU') as f:
				data = f.read()
			#now keep talking with the client
			conn, addr = s.accept()
			print 'Connected with ' + addr[0] + ':' + str(addr[1])
			index = len(data)
			i = 0
			# for i in range(0,index):
			#     #wait to accept a connection - blocking call
			#     for j in range(0,len(data[0])):

			# 	    sent = conn.send(data[i][j])
			# 	    print("sent : " +str(sent))
			# 	    print(conn.recv(1024))
			conn.send(data)
			conn.recv(1024)
			#conn.send("end")
			print('end data')
			conn.close()
			s.close()