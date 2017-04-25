 
import socket
import sys
import csv
import wiringpi as wpi
import thread

#from servertest import Server
from ecgreader import ECGRead
#from livefeed import LiveFeed
from dataBuffer import DataBuffer
#from testlive import LiveTest
# Create threads, initialize globals
global samplingRate
global delay 
delay = 8 #miliseconds
samplingRate = 1/delay * 1000


try:
	#ECGRead()
	#LiveFeed()
	#Server()
#	LiveTest()
	ECGRead()
except:
	print "Error: unable to start thread"

while 1:
	pass
