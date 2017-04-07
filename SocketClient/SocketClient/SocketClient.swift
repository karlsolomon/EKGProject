//
//  SocketClient.swift
//  SocketClient
//
//  Created by Yu, Peter M on 4/6/17.
//  Copyright © 2017 Yu, Peter M. All rights reserved.
//

import Foundation

class SocketClient{
    let addr = "10.146.6.161"
    let port = 8080
    var inp : NSInputStream?
    var out :NSOutputStream?
    
    init() {
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
        var readBytes = [UInt8](count: 60000, repeatedValue: 0)
        var dataList = String()
        var flag = true
        while flag{
            while inputStream.hasBytesAvailable{
                inputStream.read(&readBytes, maxLength: 60000)
                outputStream.write(buffer, maxLength: buffer.count)
                let ascii = convertFromAscii(readBytes)
                print(ascii)
                dataList = ascii
                flag = false
                break
            }
        }
        print(dataList)
        writeCSV(dataList)
        //    let adjustedList = adjustList(dataList)
        //    print(adjustedList)
    }
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
    var fileName = "sample.csv"
    if let filePath = NSBundle.mainBundle().pathForResource("sample", ofType: "csv"){
        fileName = filePath
    }
    else {
        fileName = NSBundle.mainBundle().bundlePath + fileName
    }
    print(fileName)
    //write the file, return true if it works, false otherwise.
    do{
        try data.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding )
        return true
    } catch{
        return false
    }
}


