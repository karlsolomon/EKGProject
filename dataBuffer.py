import copy
import time
class DataBuffer():
    start = 1 # Index of Oldest Value
    delay = 8.0 #miliseconds
    samplingRate = 1.0/delay * 1000 #Check if accessing samplingRate    
    bufferSize = 150 * samplingRate
#    print("buffer size" + str(bufferSize))   
    data = ["0"] * int(bufferSize)
 #   print("size initial: " + str(len(data)))
    @staticmethod
    def getLiveData():
        c = DataBuffer.samplingRate - DataBuffer.end
       	startLiveIndex = (len(DataBuffer.data) - c) % len(DataBuffer.data)
#        print("start live index:" + str(startLiveIndex))
	liveBuffer = copy.deepcopy(DataBuffer.data[int(startLiveIndex):DataBuffer.start-1])
        return liveBuffer

    @staticmethod
    def getArchiveData():
	print("old data storing")
	oldStart = DataBuffer.start
        #Get Past 2.5 minutes of data
	#oldDataCopy = copy.deepcopy(DataBuffer.data)
        oldDataCopy = DataBuffer.copyArray(DataBuffer.data)
	archiveBuffer = oldDataCopy[oldStart:len(DataBuffer.data)-1]
        archiveBuffer.extend(oldDataCopy[0:oldStart-1])
       
        #2.5 minutes later (exactly)
        targetTime = time.clock() + 1.0
        while time.clock() < targetTime:
            pass
        print("next data")
	newStart = DataBuffer.start
        #Get Next 2.5 minutes of data
	#dataCopy = copy.deepcopy(DataBuffer.data)
        dataCopy = DataBuffer.copyArray(DataBuffer.data)
	archiveBuffer.extend(dataCopy[newStart:len(DataBuffer.data)-1])
        archiveBuffer.extend(dataCopy[0:newStart-1])
        return archiveBuffer

    @staticmethod
    def increment():
        DataBuffer.start += 1
        DataBuffer.start %= len(DataBuffer.data)
        return
        
    @staticmethod
    def addData(value):
#	print("start index: " +str( DataBuffer.start) + " buffer lenth: " +str( len(DataBuffer.data)))
        DataBuffer.data[DataBuffer.start] = value # update oldest value w/ newest value
        DataBuffer.increment() #start now points to oldest value
#        print("Added: " + str(value) + "\n")
        return
    
    @staticmethod
    def copyArray(oldArray):
	newArray = list(oldArray)
	return newArray
