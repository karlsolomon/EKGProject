'''
    Simple socket server using threads
'''
 
import socket
import sys
import csv
import wiringpi as wpi
from threading import Thread
#import pandas
class Server(Thread):
	def __nit__(self):
		Thread.__init__(self)
		self.daemon = True
		self.start()
	def run(self):
		while True:
			HOST = "10.146.6.161"   # iPhone app IP address
			PORT = 8080 # Arbitrary non-privileged port
			 
			s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
			print 'Socket created'
			 
			#Bind socket to local host and port
			try:
				s.bind((socket.gethostname(), PORT))
			except socket.error as msg:
			    print 'Bind failed. Error Code : ' + str(msg[0]) + ' Message ' + msg[1]
			    sys.exit()
			     
			print 'Socket bind complete'
			 
			#Start listening on socket
			s.listen(10000)
			print 'Socket now listening'

			#now keep talking with the client
			conn, addr = s.accept()
			print 'Connected with ' + addr[0] + ':' + str(addr[1])
						
			conn.send(DataBuffer.getArchiveData()) #send the archived data from .csv 
			conn.recv(1024)
			#conn.send("end")
			print('end data')
			conn.close()
			s.close()
