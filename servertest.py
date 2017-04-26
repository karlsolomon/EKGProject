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
		
		while True:
			HOST = "172.20.10.2"   # iPhone app IP address
			PORT = 5555 # Arbitrary non-privileged port
			s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
			print 'Socket created'
			 
		#Bind socket to local host and port
			try:
				s.bind((HOST, PORT))
			except socket.error as msg:
			    print 'Bind failed. Error Code : ' + str(msg[0]) + ' Message ' + msg[1]
			    sys.exit()
		     
			print 'Socket bind complete'
		 
		#Start listening on socket
#		while True:
       			s.listen(1)
	 		print 'Socket now listening'
	#	while True:
			#now keep talking with the client
			conn, addr = s.accept()
			print 'Connected with ' + addr[0] + ':' + str(addr[1])
			print(conn.recv(1024))		
			message = DataBuffer.getArchiveData()
			messageStr = ",".join(str(elem) for elem in message)
			timeSet = time.clock() + 10.0
#			while time.clock()<timeSet:
#				pass
			print("sent message " + messageStr)
			conn.send(messageStr) #send the archived data from .csv 
			#list1 = list(xrange(1000))
			#list1.append(list(xrange(100)))
			#list1.append(list(xrange(50)))
			#print(",".join(str(elem) for elem in list1))
			#conn.send("end")
			conn.recv(1024)
			print('end data')
			conn.close()
		  #  	s.shutdown(1)
			s.close()
