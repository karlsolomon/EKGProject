'''
    Simple socket server using threads
'''
 
import socket
import sys
import csv
import wiringpi2 as wpi
from threading import Thread
from dataBuffer import DataBuffer
#import pandas
class LiveFeed(Thread):
	def __init__(self):
		
		self.daemon = True
		self.start()

	def run(self):
		#initiate server socket
		HOST = "10.146.6.161"   # iPhone app IP address
		PORT = 9090 # Arbitrary non-privileged port
		 
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
		s.listen(1)
		print 'Socket now listening'
		conn, addr = s.accept()
		flag = True
		while flag:
	 		try:
				result = DataBuffer.getLiveData()
				conn.send(result) #send data
				delay(1000) # 1 second delay
			except:
				print("connection closed")
				flag = False
		conn.close()
		s.close()