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
    var rows = [String]()
    var text = String()
    var header = [String]()
    var initial = [Int]()
    
    init(path: String) {
        do {
            self.text = try String(contentsOfFile: path)
            self.rows = text.componentsSeparatedByString("\r\n")
            self.header = rows[0].componentsSeparatedByString(",")
        } catch {
            print("Error getting CSV")
        }
    }
    
    func getcolumns() -> [String: [Int]]{
        var columns = [String:[Int]]()
        for k in 0..<self.header.count {
            columns[header[k]] = [Int]()
        }
        for i in 1..<rows.count {
            let cells = rows[i].componentsSeparatedByString(",")
            for j in 0..<cells.count {
                let value = Int(cells[j])!
                columns[header[j]]!.append(value)
            }
        }
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