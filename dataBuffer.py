import copy
import time
class DataBuffer():
    start = 1 # Index of Oldest Value
    end = 0 # Index of Most Recent Value
    delay = 8.0 #miliseconds
    samplingRate = 1.0/delay * 1000 #Check if accessing samplingRate    
    bufferSize = 150 * samplingRate
    print("buffer size" + str(bufferSize))   
    data = [0] * int(bufferSize)
    print("size initial: " + str(len(data)))
    @staticmethod
    def getLiveData():
        c = DataBuffer.samplingRate - DataBuffer.end
       	startLiveIndex = (len(DataBuffer.data) - c) % len(DataBuffer.data)
        print("start live index:" + str(startLiveIndex))
	liveBuffer = copy.deepcopy(DataBuffer.data[int(startLiveIndex):DataBuffer.end])
        return liveBuffer

    @staticmethod
    def getArchiveData():
	oldStart = DataBuffer.start
	oldEnd = DataBuffer.end
        #Get Past 2.5 minutes of data
	oldDataCopy = copy.deepcopy(DataBuffer.data)
        archiveBuffer = oldDataCopy[oldStart:len(DataBuffer.data)-1]
        archiveBuffer.append(oldDataCopy[0:oldEnd])
       
        #2.5 minutes later (exactly)
        targetTime = time.clock() + 150000.0
        while time.clock() < targetTime:
            pass
        
	newStart = DataBuffer.start
	newEnd = DataBuffer.end
        #Get Next 2.5 minutes of data
	dataCopy = copy.deepcopy(DataBuffer.data)
        archiveBuffer.append(dataCopy[newStart:len(DataBuffer.data)-1])
        archiveBuffer.append(dataCopy[0:newEnd])
        return archiveBuffer

    @staticmethod
    def increment():
        DataBuffer.start += 1
        DataBuffer.end += 1
        DataBuffer.start %= len(DataBuffer.data)
        DataBuffer.end %= len(DataBuffer.data)
        return
        
    @staticmethod
    def addData(value):
	print("start index: " +str( DataBuffer.start) + " buffer lenth: " +str( len(DataBuffer.data)))
        DataBuffer.data[DataBuffer.start] = value
        DataBuffer.increment()
        print("Added: " + str(value) + "\n")
        return
    
