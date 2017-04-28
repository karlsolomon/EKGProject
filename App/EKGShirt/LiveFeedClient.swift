//
//  LiveFeedClient.swift
//  EKGShirt
//
//  Created by BME261L on 4/28/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation
import UIKit

class LiveFeedClient {
    let addr = "172.16.25.116"
    let port = 8081
    var inp : NSInputStream?
    var out :NSOutputStream?
    var inputStream : NSInputStream
    var outputStream : NSOutputStream
    var fileName = String()
    var filePath = NSURL()
    var liveFeed = LiveFeedViewController()
    var liveFeedActive = false
    weak var timer: NSTimer?
    
    init(storyboard :UIStoryboard) {
        liveFeedActive = true
        liveFeed = storyboard.instantiateViewControllerWithIdentifier("LiveFeedViewController") as! LiveFeedViewController
        
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        
        self.inputStream = inp!
        self.outputStream = out!
        
        inputStream.open()
        outputStream.open()
        outputStream.write(getSignalToSend(), maxLength: 4)
        startTimer()
    }
    
    
    private func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(handleTimer(_:)), userInfo: nil, repeats: true)
    }
    
    
    @objc private func handleTimer(timer: NSTimer) {
        var readBytes = [UInt8](count: 2000, repeatedValue: 0)
        var dataString = String()
        var ascii = String()
        
        while inputStream.hasBytesAvailable {
            print(inputStream.read(&readBytes, maxLength: 2000))
            outputStream.write(getSignalToSend(), maxLength: 4)
            ascii = convertFromAscii(readBytes)
            dataString.appendContentsOf(ascii)
        }
        
        print(dataString)
        let values = dataString.componentsSeparatedByString(",")
        if (values.count > 1) {
            LiveFeedViewController.liveFeedData.enqueue(convertToIntArray(values))
            liveFeed.updateChartWithData()
        }
    }
    
    private func getSignalToSend() -> String {
        let leadNumber = LiveFeedViewController.displayedLead.characters.last!
        return String(leadNumber)
    }
    
    private func convertFromAscii(buffer: [UInt8]) -> String{
        var s = String()
        for value in buffer{
            if value != 0{  //null terminated
                s += String(UnicodeScalar(value))
            }
        }
        return s
    }
    
    private func convertToIntArray(stringData: [String]) -> [Int] {
        var intData = [Int]()
        for i in 0..<stringData.count {
            print(stringData[i] + " " )
            intData.append(Int(stringData[i])!)
        }
        return intData
    }
    
    func stopLiveFeed() {
        timer?.invalidate()
    }
    
}