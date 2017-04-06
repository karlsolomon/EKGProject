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
        var readBytes = [UInt8](count: 4, repeatedValue: 0)
        while true{
        while inputStream.hasBytesAvailable{
            inputStream.read(&readBytes, maxLength: 5)
            outputStream.write(buffer, maxLength: buffer.count)
            print(readBytes)
           
        }
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

