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
        let socket = SocketIOClient(socketURL: NSURL(string: "http://128.62.41.153:8080")!)
        socket.on("connect"){data,ack in
            print("socket connected")
        }
        print("waiting for connection")
        socket.connect()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initNetworkCommunication(){
        
    }

}

