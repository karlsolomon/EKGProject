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
				s.bind((HOST, PORT))
			except socket.error as msg:
			    print 'Bind failed. Error Code : ' + str(msg[0]) + ' Message ' + msg[1]
			    flag = False
			print 'Socket bind complete'

		#Start listening on socket
			while True:
   				s.listen(1)
	 			print 'Socket now listening'
				print("time waiting for client: "+ str(time.time))
				conn, addr = s.accept()
				print 'Connected with ' + addr[0] + ':' + str(addr[1])
				print("time after connection: " + str(time.time()))
                print(conn.recv(1024))
				print("time after receiving:" + str(time.time()))
			
				buffer1 = ECGRead.DataBuffer1.getArchiveData()
				buffer2 = ECGRead.DataBuffer2.getArchiveData()
				buffer3 = ECGRead.DataBuffer3.getArchiveData()
				bufferStr1 = ",".join(buffer1)
				bufferStr2 = ",".join(buffer2)
				bufferStr3 = ",".join(buffer3)
	
				with open('ecg.txt','w+') as file:
					file.write("Lead 1," + bufferStr1 + "\r\n")
					file.write("Lead 2," + bufferStr2 + "\r\n")
					file.write("Lead 3," + bufferStr3)
				with open("ecg.txt", "r") as readFile:
					data = readFile.read()
				conn.send(data)
				conn.recv(1024)
				conn.close()
		s.close()
