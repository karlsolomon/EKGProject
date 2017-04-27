//
//  TabBarController.swift
//  EKGShirt
//
//  Created by BME261L on 4/27/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation
import UIKit

class TabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if(item.title == "Live Feed") {
            LiveFeedViewController.isLiveFeed = true
            print("Live Feed Selected")
        }
    }
    
    class LiveFeedClient {
        let addr = "172.16.25.116"
        let port = 8080
        var inp : NSInputStream?
        var out :NSOutputStream?
        var fileName = String()
        var filePath = NSURL()
        var liveFeed = LiveFeedViewController()
        
        init(storyboard :UIStoryboard) {
            liveFeed = storyboard.instantiateViewControllerWithIdentifier("LiveFeedViewController") as! LiveFeedViewController

            
            
            NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
            
            let inputStream = inp!
            let outputStream = out!
            
            inputStream.open()
            outputStream.open()
            var buffer : [UInt8] = [97]
            var readBytes = [UInt8](count: 2000, repeatedValue: 0)
            var flag = true
            var dataString = String()
            var ascii = String()
//FIXME
            while flag{
                outputStream.write(buffer, maxLength: buffer.count)
                while inputStream.hasBytesAvailable{
                    print(inputStream.read(&readBytes, maxLength: 2000))
                    outputStream.write(buffer, maxLength: buffer.count)
                    ascii = convertFromAscii(readBytes)
                    dataString.appendContentsOf(ascii)
                    
                    if !inputStream.hasBytesAvailable{
                        flag = false
                        break
                    }
                }
            
            print(dataString)
            let values = dataString.componentsSeparatedByString(",")
            LiveFeedViewController.liveFeedData = values.map{ Int($0)!}
            liveFeed.updateChartWithData()
        
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
        
    }
}