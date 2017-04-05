//
//  CSVParse.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 4/5/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation

class CSVParse {
 
    final let encoding = NSUTF8StringEncoding
    private var columns = [String: [String]]()
    var text = String()
    var header = [String]()
    
    init(url: NSURL) {
        do {
            text = try String(contentsOfURL: url, encoding: encoding)
            let rows = text.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
            header = rows[0].componentsSeparatedByString(",")
            for i in 1..<rows.count {
                let row = rows[i].componentsSeparatedByString(",")
                for j in 0..<row.count {
                    columns[header[j]]?.append(row[j])
                }
            }
        } catch {
            print("Error parsing CSV")
        }
    }
    
    func getColumnsAsInts() -> [String: [Int]]{
        var intArray = [String: [Int]]()
        for i in columns.keys {
            intArray[i] = columns[i]?.map{Int($0)!}
        }
        return intArray
    }
    
    func getHeader() -> [String] {
        return header
    }
    
}