//
//  ViewController.swift
//  SocketTest
//
//  Created by Yu, Peter M on 4/3/17.
//  Copyright © 2017 Yu, Peter M. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initNetworkCommunication()
 /*       let socket = SocketIOClient(socketURL: NSURL(string: "http://10.146.26.31:8080")!)

        socket.emit("fileRead", 1)

        print("waiting for connection")
        socket.connect()
        socket.emit("message", [1,2,3,4])
        socket.on*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initNetworkCommunication(){
        let addr = "10.146.26.31"
        let port = 8080
        
      //  var host :NSHost = NSHost(address: addr)
        var inp :NSInputStream?
        var out :NSOutputStream?
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
      //  NSStream.getStreamsToHost(host, port: port, inputStream: &inp, outputStream: &out)
        
        let inputStream = inp!
        let outputStream = out!
        inputStream.open()
        outputStream.open()
        

        var buffer: [UInt8] = [1,2,3]
        outputStream.write(&buffer, maxLength: buffer.count)
        var readByte = [UInt8](count: 8, repeatedValue: 0)
        while inputStream.hasBytesAvailable {
            inputStream.read(&readByte, maxLength: 1)
            
        }
        print(readByte)


    }

}

