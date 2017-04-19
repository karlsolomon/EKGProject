 
import socket
import sys
import csv
import wiringpi as wpi
import thread

#from servertest import Server
#from livefeed import livefeed
from ecgreader import ECGRead
#from livefeed import LiveFeed
#from dataBuffer import DataBuffer
# Create threads, initialize globals
global samplingRate
global delay 
delay = 8 #miliseconds
samplingRate = 1/delay * 1000


try:

  ECGRead()
  #LiveFeed()
  #Server()


except:
   print "Error: unable to start thread"

while 1:
   pass
