//
//  ViewController.swift
//  SocketClient
//
//  Created by Yu, Peter M on 4/6/17.
//  Copyright © 2017 Yu, Peter M. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let addr = "10.146.6.161"
        let port = 8080
        var inp :NSInputStream?
        var out :NSOutputStream?
        
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        let inputStream = inp!
        let outputStream = out!
        
        inputStream.open()
        outputStream.open()
        
        var readByte = [UInt8](count: 4, repeatedValue: 0)
        while inputStream.hasBytesAvailable{
            inputStream.read(&readByte, maxLength: 5)
            print(readByte)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

