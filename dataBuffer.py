import time

class DataBuffer():
    start = 1 # Index of Oldest Value
    end = 0 # Index of Most Recent Value
    global samplingRate #Check if accessing samplingRate    
    bufferSize = 150 * samplingRate
    data = [0] * bufferSize

    @staticmethod
    def getLiveData():
        c = samplingRate - DataBuffer.end
        startLiveIndex = (length(DataBuffer.data) - c) % length(DataBuffer.data)
        liveBuffer = DataBuffer.data[startLiveIndex:DataBuffer.end].copy()
        return liveBuffer

    @staticmethod
    def getArchiveData():
        #Get Past 2.5 minutes of data
        archiveBuffer = DataBuffer.data[start:length(DataBuffer.data)-1].copy()
        archiveBuffer.append(DataBuffer.data[0:DataBuffer.end].copy())
        archiveBuffer = archiveBuffer[0:length(archiveBuffer)]

        #2.5 minutes later (exactly)
        targetTime = time.clock() + 150000.0
        while time.clock() < targetTime:
            pass
        
        #Get Next 2.5 minutes of data
        archiveBuffer.append(DataBuffer.data[DataBuffer.start:length(DataBuffer.data)-1].copy())
        archiveBuffer.append(DataBuffer.data[0:DataBuffer.end].copy())
        return archiveBuffer

    @staticmethod
    def increment():
        DataBuffer.start += 1
        DataBuffer.end += 1
        DataBuffer.start %= length(DataBuffer.data)
        DataBuffer.end %= length(DataBuffer.data)
        return
        
    @staticmethod
    def addData(value):
        DataBuffer.data[DataBuffer.start] = value
        DataBuffer.increment()
        print("Added: " + value + "\n")
        return
    
