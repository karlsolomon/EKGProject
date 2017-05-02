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
    
    func enqueue(_items: [Int]) {
        dataSource.appendContentsOf(_items)
        if(dataSource.count > LiveFeedViewController.maxDataPoints) {
            let overflow = dataSource.count - LiveFeedViewController.maxDataPoints
            print(overflow)
            dataSource.removeRange(0...overflow)
        }
    }
    
    func getDataSource() -> [Int]
    {
        return dataSource
    }
    
    func getDataSource() -> [Double] {
        return dataSource.map{Double($0)}
    }
    
    func clear() {
        dataSource = [Int]()
    }
}