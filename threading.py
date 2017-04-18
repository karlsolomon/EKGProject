 
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
dataBuffer = [0]*1000
print("length is " + len(dataBuffer))
try:

  ECGRead()
  LiveFeed()
  Server()


except:
   print "Error: unable to start thread"

while 1:
   pass
