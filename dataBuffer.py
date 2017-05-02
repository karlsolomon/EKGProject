import copy
import time
class DataBuffer():

    #Static Variables, shared b/t lead buffers
    lastLiveEnd = 0
    end = 0 #index of oldest value
    lastLiveSent = time.clock()
    start = 0
    seconds = 300
    frequency = 125
    size = frequency*seconds

    def __init__(self):
	self.data = ["0"]*DataBuffer.size

    def getLiveData(self):
	print("getLiveData: " + str(time.gmtime()))
	time.sleep(0.25)
	DataBuffer.lastLiveSent = time.clock()
	liveData = self.copyFrom(DataBuffer.lastLiveEnd)
	DataBuffer.lastLiveEnd = DataBuffer.end
	return liveData

    def toWrappedIndex(self, index, seconds):
	return ((index - seconds*DataBuffer.frequency) + DataBuffer.size) % DataBuffer.size

    def copyFrom(self, start):
	#DataBuffer.start = self.toWrappedIndex(DataBuffer.end,seconds)
	print("start: " + str(start) + "end: " + str(DataBuffer.end))
	if(start < DataBuffer.end):
	    return list(self.data[start:DataBuffer.end-1])
	else:
	    copy = list(self.data[start:self.size-1])
	    copy.extend(list(self.data[0:DataBuffer.end-1]))
	    return copy

    def getArchiveData(self):
	print("getting Archived Data")
	archive = self.copyFrom(DataBuffer.end +1)
	return archive

    def increment(self):
        DataBuffer.end += 1
        DataBuffer.end %= DataBuffer.size
        return

    def addData(self, value):
        self.data[DataBuffer.end] = value # update oldest value w/ newest value
        self.increment() #start now points to oldest value
        return
