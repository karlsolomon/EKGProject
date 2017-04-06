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
    
    init(path: String) {
        do {
            self.text = try String(contentsOfFile: path)
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
            print(columns)
        } catch {
            print("Error parsing CSV")
        }
    }
    
    func getcolumns() -> [String: [Int]]{
        return columns
    }
    
    func getHeader() -> String {
        var headerAppended = String()
        for i in header {
            headerAppended += "\(i) "
        }
        return headerAppended
    }
    
}