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
        var readBytes = [UInt8](count: 60000, repeatedValue: 0)
        var dataList = [String]()
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
        let adjustedList = adjustList(dataList)
        print(adjustedList)
    }
    func convertFromAscii(buffer: [UInt8]) -> [String]{
        var list = [String]()
        var s = String()
        for value in buffer{
            if value != 0{
                if value == 44 || value == 10{//delimiter is a comma
                    list.append(s)
                    s = ""
                }
                else{
                    s += String(UnicodeScalar(value))
                }
            }
        }
        return list
    }
    func adjustList(list : [String]) -> [String]{
        var temp = list
        var size = list.count
        var list1 = [String]()
        var list2 = [String]()
        var list3 = [String]()
        var list4 = [String]()
        var x = 1
        for i in 0..<size{
            if x == 1 {
                list1.append(temp.removeAtIndex(0))
                x+=1
            }
            else if x == 2 {
                list2.append(temp.removeAtIndex(0))
                x+=1
            }
            else if x == 3 {
                list3.append(temp.removeAtIndex(0))
                x+=1
            }
            else if x == 4{
                list4.append(temp.removeAtIndex(0))
                x=1
            }
            
        }
        
        return list1+list2+list3+list4
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

