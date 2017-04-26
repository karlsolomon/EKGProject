'''
    Simple socket server using threads
'''
import time 
import socket
import sys
import csv
import wiringpi as wpi
from threading import Thread
from dataBuffer import DataBuffer
#import pandas
class Server(Thread):
	def __init__(self):
		Thread.__init__(self)
		self.daemon = True
		self.start()
		print("Running Server")
	def run(self):
		flag = True
		while True:
			HOST = "172.20.10.2"   # iPhone app IP address
			PORT = 8080 # Arbitrary non-privileged port
			try:
				s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
				print 'Socket created'
			 
		#Bind socket to local host and port
			
				s.bind((HOST, PORT))
			except socket.error as msg:
			    print 'Bind failed. Error Code : ' + str(msg[0]) + ' Message ' + msg[1]
			    flag = False
		     
			print 'Socket bind complete'
		 
		#Start listening on socket
			while True:
   				s.listen(1)
	 			print 'Socket now listening'
	#	while True:
				print("time waiting for client: "+ str(time.time))
		#now keep talking with the client
				conn, addr = s.accept()
				print 'Connected with ' + addr[0] + ':' + str(addr[1])
				print("time after connection: " + str(time.time()))
				print(conn.recv(1024))		
				print("time after receiving 1:" + str(time.time()))
				message = DataBuffer.getArchiveData()
				print("time to get databuffer:" + str(time.time()))
				messageStr = ",".join(message)
			#timeSet = time.time() + 10.0
		#	while time.time()<timeSet:
		#		pass
				print("converted message: "+ str(time.time()))
		#	print("sent message " + messageStr)
				conn.send(messageStr) #send the archived data from .csv 
			#list1 = list(xrange(1000))
			#list1.append(list(xrange(100)))
			#list1.append(list(xrange(50)))
			#print(",".join(str(elem) for elem in list1))
			#conn.send("end")
				print("time after sending data:" + str(time.time()))
				print(conn.recv(1024))
#			conn.flush()
				conn.close()
#		    	s.shutdown(2)
		s.close()
