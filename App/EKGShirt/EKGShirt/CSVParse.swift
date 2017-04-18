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
    var columns = [String:[Int]]()
    var text = String()
    var header = [String]()
    var initial = [Int]()
    
    //Parses CSV File in memory as Map of [LeadName : [LeadData]]
    init(url: NSURL) {
        do {
            self.text = try String(contentsOfURL: url, encoding: encoding)
            let rows = text.componentsSeparatedByString("\r\n")
            self.header = rows[0].componentsSeparatedByString(",")
            print("Header: \(self.header.count)")
            for k in 0..<self.header.count {
                self.columns[header[k]] = [Int]()
            }
            
            print("Rows \(rows.count)")
            for i in 1..<rows.count {
                let cells = rows[i].componentsSeparatedByString(",")
                for j in 0..<cells.count {
                    let value = Int(cells[j])!
                    self.columns[header[j]]!.append(value)
                }
            }
        } catch {
            print("Could Not Find File")
        }
    }
    
    //Returns EKG map keyed on Lead Name, valued on lead data
    func getcolumns() -> [String: [Int]]{
        return columns
    }
    
    //Returns Lead Names
    func getHeader() -> [String] {
        return self.header
    }
    
}