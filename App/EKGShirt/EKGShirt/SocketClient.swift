//
//  SocketClient.swift
//  SocketClient
//
//  Created by Yu, Peter M on 4/6/17.
//  Copyright © 2017 Yu, Peter M. All rights reserved.
//
import Foundation

class SocketClient{
    let addr = "172.16.25.116"
    let port = 8080
    var inp : NSInputStream?
    var out :NSOutputStream?
    var fileName = String()
    init(fileName :String) {
        self.fileName = fileName
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        
        let inputStream = inp!
        let outputStream = out!
        //        inputStream.delegate = self
        //        outputStream.delegate = self
        //        inputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        //        outputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        inputStream.open()
        outputStream.open()
        var buffer : [UInt8] = [97]
        var readBytes = [UInt8](count: 600000, repeatedValue: 0)
        var dataList = String()
        var flag = true
        outputStream.write(buffer, maxLength: buffer.count)
        while flag{
            while inputStream.hasBytesAvailable{
                inputStream.read(&readBytes, maxLength: 600000)
                outputStream.write(buffer, maxLength: buffer.count)
                let ascii = convertFromAscii(readBytes)
                print(ascii)
                dataList = ascii
                flag = false
                break
            }
        }
        print(dataList)
        print(writeCSV(dataList))
        //    let adjustedList = adjustList(dataList)
        //    print(adjustedList)
    }

private func convertFromAscii(buffer: [UInt8]) -> String{
    var list = [String]()
    var s = String()
    for value in buffer{
        if value != 0{
            s += String(UnicodeScalar(value))
        }
    }
    return s
}

private func writeCSV(data: String) -> Bool{
    let fileName = self.fileName
//    if let filePath = Archive.ArchiveURL.absoluteString +  //  ){
//        fileName = filePath
//    }
//    else {
//        fileName = NSBundle.mainBundle().bundlePath + "/" + fileName + ".csv"
//    }
    let path = Archive.ArchiveURL.absoluteString + "/" + fileName + ".txt"
    print(path)
    var csvText = "Lead1,Task,Time Started,Time Ended\n"
    
    //write the file, return true if it works, false otherwise.
    do{
        try data.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding )
        return true
    } catch{
        return false
    }
}
}

