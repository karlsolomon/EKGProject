from threading import Thread
import time
from dataBuffer import DataBuffer

class LiveTest(Thread):
	def __init__(self):
		Thread.__init__(self)
		self.daemon = True
		self.start()
		print("Running LiveTest")
	def run(self):
		while True:
			result = DataBuffer.getLiveData()
			print("after getLiveData ")
			print(result)
			time.sleep(3)
		
