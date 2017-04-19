 
import socket

import csv
#import servertest
import wiringpi as wpi
from threading import Thread
from dataBuffer import DataBuffer
class ECGRead(Thread):
	def __init__(self):
		Thread.__init__(self)
		self.daemon = True
		self.start()
	def run(self):
		wpi.wiringPiSetup() # import wiringpi setup method
		wpi.mcp3004Setup(100,0) # setup for mcp3004, use 100 for base reference

		#declare globals to allow for modification
		global dataBuffer #store data here
		global startIndex #pointer 1
		global endIndex #pointer 2
		BASE = 100
		while True:
			e1=wpi.analogRead(BASE);
			e2=wpi.analogRead(BASE+1);
		#	e3=analogRead (BASE+2);
		#	e4=analogRead(BASE+3);

			lead1=e1-e2;
		#	lead2=e1-e4;
		#	lead3=e2-e4;
		#	avr=e3-e1;
		#	avl=e3-e2;
		#	avf=e3-e4;
                        DataBuffer.addData(lead1)
                
