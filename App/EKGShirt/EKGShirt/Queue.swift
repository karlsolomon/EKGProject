//
//  Queue.swift
//  EKGShirt
//
//  Created by BME261L on 4/27/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation

class Queue {
    var dataSource = [Int]()
    
    func enqueue(_item: Int) {
        dataSource.append(_item)
    }
    
    func enqueue(_items: [Int]) {
        dataSource.appendContentsOf(_items)
        if(dataSource.count > LiveFeedViewController.maxDataPoints) {
            dequeue(dataSource.count - LiveFeedViewController.maxDataPoints)
        }
    }
    
    func dequeue() -> Int {
        return dataSource.removeFirst()
    }
    
    func dequeue(numberToDequeue: Int) {
        return dataSource.removeFirst(numberToDequeue)
    }
    
    func getDataSource() -> [Int]
    {
        return dataSource
    }
    
    func getDataSource() -> [Double] {
        return dataSource.map{Double($0)}
    }
}