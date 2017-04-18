'''
    Simple socket server using threads
'''
 
import socket
import sys
import csv
import wiringpi2 as wpi
from threading import Thread

#import pandas
class LiveFeed(Thread):
	def __init__(self):
		Thread.__init__(self)
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
		
		with open('samples.csv','rU') as f:
			data = f.read()
		#now keep talking with the client
		conn, addr = s.accept()
		print 'Connected with ' + addr[0] + ':' + str(addr[1])
		index = len(data)
		i = 0	
		self.daemon = True
		self.start()

	def run(self):
 		global dataBuffer #access blobal variables to be modified
 		global startIndex
 		global endIndex
 		i = startIndex
 		j = endIndex
 		temp = dataBuffer[:]
 		result = []
 		while i != j:
			result.append(temp[i]) #move data to be sent into temp array
			i = i % len(dataBuffer)
		
		conn.send(result) #send data
		delay(6000) # 1 minute delay

	def getDataBuffer():
		return dataBuffer
	def setDataBuffer(value):
		global dataBuffer
		dataBuffer.append(value)