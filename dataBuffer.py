import copy
import time
class DataBuffer():

    def __init__(self):
 	self.end = 0 # Index of Oldest Value
	self.seconds = 150
	self.frequency = 125
	self.size = self.frequency*self.seconds
	self.data = ["0"]*self.size
	self.lastLiveSent = time.clock()

    def getLiveData(self):
	##while (time.clock() - 1.0) < self.lastLiveSent:
	#    pass #keep live thread as active thread until it sends the data
	time.sleep(1)
	self.lastLiveSent = time.clock()
	return self.copyRange(1)

    def toWrappedIndex(self, index, seconds):
	return ((index - seconds*self.frequency) + self.size) % self.size

    def copyRange(self, seconds):
	start = self.toWrappedIndex(self.end,seconds)
	self.lastLiveStart = start
	print("start: " + str(start) + "end: " + str(self.end))
	if(start < self.end):
	    return list(self.data[start:self.end-1])
	else:
	    copy = list(self.data[start:self.size-1])
	    copy.extend(list(self.data[0:self.end-1]))
	    return copy	

    def getArchiveData(self):
	print("getting Archived Data")
	print("first half Archive saved: " + str(time.clock))
	archive = self.copyRange(self.seconds)
	time.sleep(150) #sleep 2.5 minutes, can't occupy active thread
	print("second half Archive saved: " + str(time.clock))
	archive.extend(self.copyRange(self.seconds))
	return archive

    def increment(self):
        self.end += 1
        self.end %= self.size
        return

    def addData(self, value):
        self.data[self.end] = value # update oldest value w/ newest value
        self.increment() #start now points to oldest value
        return
