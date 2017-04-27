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
    var filePath = NSURL()
    init(fileName :String) {
        self.fileName = fileName
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        
        let inputStream = inp!
        let outputStream = out!
        
        inputStream.open()
        outputStream.open()
        var buffer : [UInt8] = [97]
        var readBytes = [UInt8](count: 150000, repeatedValue: 0)
        var flag = true
        var dataString = String()
        var ascii = String()
        outputStream.write(buffer, maxLength: buffer.count)
        while flag{
            while inputStream.hasBytesAvailable{
                print(inputStream.read(&readBytes, maxLength: 150000))
                outputStream.write(buffer, maxLength: buffer.count)
                ascii = convertFromAscii(readBytes)
                dataString.appendContentsOf(ascii)
                
                if !inputStream.hasBytesAvailable{
                    flag = false
                    break
                }
            }
        }
        print(dataString)
        print(writeCSV(dataString))
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
    
func getFilePath() -> NSURL {
    return filePath
}

private func writeCSV(data: String) -> Bool{
    let fileName = self.fileName
    let path = SymptomsViewController.DocumentsDirectory.URLByAppendingPathComponent(fileName + ".txt")
    self.filePath = path
    print(path)
    //write the file, return true if it works, false otherwise.    
    do{
        try data.writeToURL(path, atomically: false, encoding: NSUTF8StringEncoding)
        return true
    } catch {
        let nsError = error as NSError
        print(nsError.localizedDescription)
        return false
    }
}
}

