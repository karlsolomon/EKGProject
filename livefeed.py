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
from ecgreader import ECGRead

#import pandas
class LiveFeed(Thread):
	def __init__(self):
		Thread.__init__(self)
		self.daemon = True
		self.start()

	def run(self):
		isConnected = True
		flag = True
		while True:
			HOST = "172.16.25.116"   # raspberryPi IP address
			PORT = 8081 # Arbitrary non-privileged port
            		try:
				s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                		print 'LiveFeed Socket created'
				s.bind((HOST, PORT))
			except socket.error as msg:
                		print 'Bind failed. Error Code : ' + str(msg[0]) + ' Message ' + msg[1]
                		flag = False
            		print 'LiveFeed Socket bind complete'
         
			#Start listening on socket
            		while flag:
                		s.listen(1)
                		print 'LiveFeed Socket now listening'
                		print("LiveFeed time waiting for client: "+ str(time.time))
        			
				#now keep talking with the client
                		conn, addr = s.accept()
                		print 'LiveFeed Connected with ' + addr[0] + ':' + str(addr[1])
                
				#Send 1s data until connection closed
                		while isConnected:
                    			bufferStr = ""
					try:
                        			key = conn.recv(4)
                        			print("key size is: " + str(len(key)))
						print("key is " + str(key))
                        	 		if "1" in key:
                            				buff = ECGRead.DataBuffer1.getLiveData()
                            				bufferStr = ",".join(buff)
                        			elif "2" in key:
                            				buff = ECGRead.DataBuffer2.getLiveData()
                            				bufferStr = ",".join(buff)
                        			elif "3" in key:
                            				buff = ECGRead.DataBuffer3.getLiveData()
                            				bufferStr = ",".join(buff)
                        			print("sending: " + bufferStr)
						conn.send(bufferStr)
                    			except socket.error as msg:
                        			print "connection closed " + str(msg[0]) + " " + str(msg[1])
                        			isConnected = False 
                		print("time to get databuffer:" + str(time.time()))
				conn.close()
	    	s.close()
