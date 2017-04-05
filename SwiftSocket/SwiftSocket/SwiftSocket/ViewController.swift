//
//  ViewController.swift
//  SwiftSocket
//
//  Created by Yu, Peter M on 4/4/17.
//  Copyright © 2017 Yu, Peter M. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let address = InternetAddress(hostnam: "http://10.146.26.31", port:8080)
        do{
            let client = try TCPClient(address: address)
            try client.send(10)
            print("sent")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

