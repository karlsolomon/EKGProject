'''
    Simple socket server using threads
'''
 
import socket
import sys
import csv
import wiringpi as wpi
from threading import Thread

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
            HOST = "172.16.25.116"   # iPhone app IP address
            PORT = 8000 # Arbitrary non-privileged port
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
            while flag:
                s.listen(1)
                print 'Socket now listening'
    #   while True:
                print("time waiting for client: "+ str(time.time))
        #now keep talking with the client
                conn, addr = s.accept()
                print 'Connected with ' + addr[0] + ':' + str(addr[1])
                #Send 1s data until connection closed
                while isConnected
                    try:
                        
                        key = conn.recv(1024)
                        print("key is " + str(key))
                        if key == "1"
                            buff = ECGRead.DataBuffer1.getLiveData()
                            bufferStr = ",".join(buff)
                        else if key == "2"
                            buff = ECGRead.DataBuffer2.getLiveData()
                            bufferStr = ",".join(buff)
                        else if key == "3"
                            buff = ECGRead.DataBuffer3.getLiveData()
                            bufferStr = ",".join(buff)
                        conn.send(bufferStr)
                    except socket.error as msg:
                        print "connection closed"
                        isConnected = False
                
                print("time to get databuffer:" + str(time.time()))
                     
		        conn.close()
		s.close()
