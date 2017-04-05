//
//  ViewController.swift
//  SocketTest
//
//  Created by Yu, Peter M on 4/3/17.
//  Copyright © 2017 Yu, Peter M. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var inputStream = NSInputStream()
    var outputStream = NSOutputStream()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initNetworkCommunication()
        receiveData()
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
    func asciiToInt(buffer: [UInt8])-> String{
        var result = String()
        for i in buffer{
        //    print(String(UnicodeScalar(i)))
            result += String(UnicodeScalar(i))
        }
        return result
    }
    func initNetworkCommunication(){
        let addr = "10.146.26.31"
        let port = 9999
        
      //  var host :NSHost = NSHost(address : addr)
        var inp :NSInputStream?
        var out :NSOutputStream?
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
      //  NSStream.getStreamsToHost(host, port: port, inputStream: &inp, outputStream: &out)
        
        self.inputStream = inp!
        self.outputStream = out!
        inputStream.open()
        outputStream.open()


    }
    func receiveData()->[String]{
        var dataList = [String]()
        var buffer: [UInt8] = [1,2,3]
        var readByte = [UInt8](count: 4, repeatedValue: 0)
        while inputStream.hasBytesAvailable {
            inputStream.read(&readByte, maxLength: 5)
            outputStream.write(&buffer, maxLength: buffer.count)
            print(dataList.append(asciiToInt(readByte)))
        }
        print(readByte)
        
        return dataList
    }

}

