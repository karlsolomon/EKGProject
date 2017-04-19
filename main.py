 
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
from dataBuffer import DataBuffer
# Create threads, initialize globals


try:

  ECGRead()
  #LiveFeed()
  #Server()


except:
   print "Error: unable to start thread"

while 1:
   pass
