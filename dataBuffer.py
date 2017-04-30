import copy
import time
class DataBuffer():

    def __init__(self):
 	self.end = 0 # Index of Oldest Value
	self.seconds = 150
	self.frequency = 125
	self.size = self.frequency*self.seconds
	self.data = ["0"]*self.size
	self.lastLiveEnd =1

    def getLiveData(self):
	while self.end != self.toWrappedIndex(self.lastLiveEnd,1):
	    pass # Wait until at least 1 second has passed before getting the next Live Data Set to avoid overlapping live data
	return copyRange(1)

    def toWrappedIndex(self, index, seconds):
	return ((index + seconds*self.frequency) + self.size) % self.size

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
	endOfFirstBufferRange = self.end
	archive = copyRange(self.seconds)
	time.sleep(1.0/float(frequency)*2.0) # wait until end has at least incremented once
	while self.end != endOfFirstBufferRange:
	    pass #wait for full buffer (1/2 of an archive) to be overwritten w/ new data
	archive.extend(copyRange(self.seconds))
	return archive

    def increment(self):
        self.end += 1
        self.end %= self.size
        return

    def addData(self, value):
        self.data[self.end] = value # update oldest value w/ newest value
        self.increment() #start now points to oldest value
        return
