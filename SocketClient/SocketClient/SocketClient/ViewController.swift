//
//  ViewController.swift
//  SocketClient
//
//  Created by Yu, Peter M on 4/6/17.
//  Copyright © 2017 Yu, Peter M. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSStreamDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let addr = "10.146.6.161"
        let port = 8080
        var inp : NSInputStream?
        var out :NSOutputStream?
    
        
        
        
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
        var readBytes = [UInt8](count: 5, repeatedValue: 0)
        var dataList = [String]()
        var flag = true
        while flag{
        while inputStream.hasBytesAvailable{
            inputStream.read(&readBytes, maxLength: 5)
            outputStream.write(buffer, maxLength: buffer.count)
            var ascii = convertFromAscii(readBytes)
            print(ascii)
            if ascii == "end"{
                flag = false
                break;
            }
            else{
                
            dataList.append(ascii)
            readBytes = [UInt8](count: 5, repeatedValue: 0)
            }
        }
            
        }
        print(dataList)
    }
    func convertFromAscii(buffer: [UInt8]) -> String{
        var s = String()
        for value in buffer{
            if value != 0{
                if value == 33{
                    return "end"
                }
                else{
                    s += String(UnicodeScalar(value))
                }
            }
        }
        return s
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

