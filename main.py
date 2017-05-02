import socket
import sys
import csv
import wiringpi as wpi
import thread
import time

from servertest import Server
from ecgreader import ECGRead
from livefeed import LiveFeed
from dataBuffer import DataBuffer
# Create threads, initialize globals
global samplingRate
global delay 
delay = 8 #miliseconds
samplingRate = 1/delay * 1000


try:
	print("trheads starting")
	Server()
	ECGRead()
	LiveFeed()


except:
    print "Error: unable to start thread"

while True:
    time.sleep(5)  
    pass
