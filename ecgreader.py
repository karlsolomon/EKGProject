 
import socket
import time
import csv
#import servertest
import wiringpi as wpi
from threading import Thread
from dataBuffer import DataBuffer
class ECGRead(Thread):
	DataBuffer1 = DataBuffer()
	DataBuffer2 = DataBuffer()
	DataBuffer3 = DataBuffer()

	@staticmethod
	def getDataBuffers():
		return DataBuffer1, DataBuffer2, DataBuffer3

	def __init__(self):
		Thread.__init__(self)
		self.daemon = True
		self.start()
	def run(self):
		global DataBuffer1
		global DataBuffer2
		global DataBuffer3
		wpi.wiringPiSetup() # import wiringpi setup method
		wpi.mcp3004Setup(100,0) # setup for mcp3004, use 100 for base reference

		#declare globals to allow for modification
		global dataBuffer #store data here
		global startIndex #pointer 1
		global endIndex #pointer 2
		BASE = 100
		while True:
			lead1 = wpi.analogRead(BASE);
		 	lead2 = wpi.analogRead(BASE+1);
			lead3 = wpi.analogRead(BASE+2) * (-1) + 1023 ;
		#	e4=analogRead(BASE+3);

#			lead1=e1
		#	lead2 = e2
		#	lead3 = e3;
		#	avr=e3-e1;
		#	avl=e3-e2;
		#	avf=e3-e4;
                        ECGRead.DataBuffer1.addData(str(lead1))
			ECGRead.DataBuffer2.addData(str(lead2))
			ECGRead.DataBuffer3.addData(str(lead3))
			DataBuffer.increment()
		#	DataBuffer.getLiveData()
			wpi.delay(4)
			time.sleep(.0001)
