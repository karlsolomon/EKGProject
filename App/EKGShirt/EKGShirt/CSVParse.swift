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
    var leads = [String:[Int]]()
    var text = String()
    var header = [String]()
    var initial = [Int]()
    
    //Parses CSV File in memory as Map of [LeadName : [LeadData]]
    init(url: NSURL) {
        do {
            self.text = try String(contentsOfURL: url, encoding: encoding)
            let rows = text.componentsSeparatedByString("\r\n")
            for k in 0..<rows.count {
                var values = rows[k].componentsSeparatedByString(",")
                let leadName = values.removeAtIndex(0)
                self.leads[leadName] = values.map{Int($0)!}
            }
        } catch {
            print("Could Not Find File")
        }
    }
    
    //Returns EKG map keyed on Lead Name, valued on lead data
    func getLeads() -> [String: [Int]]{
        return self.leads
    }
    
    //Returns Lead Names
    func getHeader() -> [String] {
        return self.header
    }
    
}