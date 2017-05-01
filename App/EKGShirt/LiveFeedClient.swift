//
//  LiveFeedClient.swift
//  EKGShirt
//
//  Created by BME261L on 4/28/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation
import UIKit

class LiveFeedClient  {
    let addr = "10.146.24.104"
    let port = 8083
    var inp : NSInputStream?
    var out :NSOutputStream?
    var inputStream : NSInputStream
    var outputStream : NSOutputStream
    var fileName = String()
    var filePath = NSURL()
    var liveFeed = LiveFeedViewController()
    var liveFeedActive = false
    weak var timer: NSTimer?
    var sent = 0.0
    var received = 0.0
    
    
    init(storyboard :UIStoryboard) {
        liveFeedActive = true
        liveFeed = storyboard.instantiateViewControllerWithIdentifier("LiveFeedViewController") as! LiveFeedViewController
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        
        self.inputStream = inp!
        self.outputStream = out!
        
        inputStream.open()
        outputStream.open()
        print("writing to stream")
        outputStream.write(getSignalToSend(), maxLength: 4)
        startTimer()
    }
    
    private func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(handleTimer(_:)), userInfo: nil, repeats: true)
    }
    
    @objc private func handleTimer(timer: NSTimer) {
        var readBytes = [UInt8](count: 190, repeatedValue: 0)
        var dataString = String()
        var ascii = String()
        outputStream.write(getSignalToSend(), maxLength: 4)
        sent += 1.0
        if inputStream.hasBytesAvailable {
            print("byte input size: " + String(inputStream.read(&readBytes, maxLength: 190)))
            ascii = convertFromAscii(readBytes)
            dataString.appendContentsOf(ascii)
            print("read size: " + String(dataString.characters.count))
            
            let values = dataString.componentsSeparatedByString(",")
            if(values.count > 1) {
                LiveFeedViewController.liveFeedData.enqueue(convertToIntArray(values))
                liveFeed.updateChartWithData()
                received += 1.0
            }
            print("% received = " + String(received*100.0/sent))
        }
        

    }
    func getLiveFeedVC() -> LiveFeedViewController{
        return self.liveFeed
    }
    private func asciiValue(str: String) -> UInt8 {
        let s = str.unicodeScalars
        return UInt8(s[s.startIndex].value)
        
    }
    private func getSignalToSend() -> String {
        let activeLead = LiveFeedViewController.displayedLead.characters.last!
        print("Writing: " + String(activeLead))
        return String(activeLead) + "\n"
    }
    
    private func convertFromAscii(buffer: [UInt8]) -> String{
        var s = String()
        for value in buffer{
            if value != 0 {  //null terminated
                s += String(UnicodeScalar(value))
            }
        }
        return s  //add extra comma in case two packets get read consecutively
    }
    
    
    private func convertToIntArray(stringData: [String]) -> [Int] {
        var intData = [Int]()
        for i in stringData {
            if(i != "") {
                intData.append(Int(i)!)
            }
        }
        return intData
    }
    
    func stopLiveFeed() {
        timer?.invalidate()
    }
    
}