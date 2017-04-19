 
import socket
import sys
import csv
import servertest
import wiringpi2 as wpi
import thread

from servertest import Server
from livefeed import livefeed
from ecgreader import ECGRead
from livefeed import LiveFeed
# Create threads, initialize globals
global dataBuffer
global startIndex
global endIndex
global ip

delay = 8 #miliseconds
samplingRate = 1/delay * 1000
dataBuffer = [0]*samplingRate * 5 #5 minutes of data sampled at samplingRate
endIndex = 0
startIndex = 0
ip = "10.146.6.161"
print("length is " + len(dataBuffer))
try:

  ECGRead()
  LiveFeed()
  Server()


except:
   print "Error: unable to start thread"

while 1:
   pass
