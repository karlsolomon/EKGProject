import copy
import time
class DataBuffer():

    def __init__(self):
 	self.start = 1 # Index of Oldest Value
    	self.delay = 8.0 #miliseconds
    	self.samplingRate = 1.0/self.delay * 1000 #Check if accessing samplingRate    
    	self.bufferSize = 150 * self.samplingRate
#   	print("buffer size" + str(bufferSize))   
    	self.data = ["0"] * int(self.bufferSize)
 #  	print("size initial: " + str(len(data)))
		

    def getLiveData(self):
	#FIXME: Doesn't handle wrapping (start is at the very beggining of the buffer), should probably make a class or method for copying from this that handles wrapping
	liveEnd = int(self.start - 1)
	liveStart = int(liveEnd - self.samplingRate)
	print("start: " + str(liveStart) + " end: " + str(liveEnd))
	liveFeedBuffer = self.data[liveStart: liveEnd]
	return liveFeedBuffer

    def getArchiveData(self):
	print("old data storing")
	oldStart = self.start
        #Get Past 2.5 minutes of data
	#oldDataCopy = copy.deepcopy(DataBuffer.data)
        oldDataCopy = self.copyArray(self.data)
	archiveBuffer = oldDataCopy[oldStart:len(self.data)-1]
        archiveBuffer.extend(oldDataCopy[0:oldStart-1])
       
        #2.5 minutes later (exactly)
#        targetTime = time.clock() + 1.0
 #       while time.clock() < targetTime:
 #           pass
        print("next data")
	newStart = self.start
        #Get Next 2.5 minutes of data
	#dataCopy = copy.deepcopy(DataBuffer.data)
        dataCopy = self.copyArray(self.data)
	archiveBuffer.extend(dataCopy[newStart:len(self.data)-1])
        archiveBuffer.extend(dataCopy[0:newStart-1])
        return archiveBuffer

    def increment(self):
        self.start += 1
        self.start %= len(self.data)
        return
        

    def addData(self, value):
#	print("start index: " +str(self.start) + " buffer lenth: " +str( len(self.data)))
        self.data[self.start] = value # update oldest value w/ newest value
        self.increment() #start now points to oldest value
#        print("Added: " + str(value) + "\n")
        return
    

    def copyArray(self,oldArray):
	newArray = list(oldArray)
	return newArray
