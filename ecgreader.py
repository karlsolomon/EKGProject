 
import socket

import csv
import servertest
import wiringpi2 as wpi
from threading import Thread

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
		while True:
			e1=analogRead (BASE);
			e2=analogRead (BASE+1);
		#	e3=analogRead (BASE+2);
		#	e4=analogRead(BASE+3);

			lead1=e1-e2;
		#	lead2=e1-e4;
		#	lead3=e2-e4;
		#	avr=e3-e1;
		#	avl=e3-e2;
		#	avf=e3-e4;

			dataBuffer[startIndex] = lead1
			startIndex +=1 
			startIndex  = startIndex % len(dataBuffer)
			endIndex += 1
			endIndex = endIndex % len(dataBuffer)

			dataBuffer[]
			delay(8);
