//
//  Archive.swift
//  EKGShirt
//
//  Created by Yu, Peter M on 4/2/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation

class Archive{
    enum LeadNum{
        case LEAD1,LEAD2,LEAD3,AVF,AVL,AVR,V
    }
    static var ArchiveList = [Archive]()
    private var date = NSDate()

    private var path = String()
    private var data = [[Int]]()
    
    private var symptoms = [String]()
    
    init(date: NSDate, path: String, data: [[Int]], symptoms: [String]){
        
        self.date = date
        self.path = path
        self.data = data
        self.symptoms = symptoms
        
    }
    
    func getDate()->String{
        let formatter = NSDateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "mm-dd-yyyy HH:mm:ss"
        let dateString = formatter.stringFromDate(self.date)
        return dateString
    }

    func getPath()->String{
        return path
    }
    func getData(lead: LeadNum) ->[Int]{
        switch lead{
            case .LEAD1:
                return data[0]
            case .LEAD2:
                return data[1]
            case .LEAD3:
                return data[2]
            case .AVF:
                return data[3]
            case .AVR:
                return data[4]
            case .AVL:
                return data[5]
            case .V:
                return data[6]
        }
    }
    func getArchive(path:String)->Archive{
        for archive in Archive.ArchiveList{
            if archive.getPath() == path{
                return archive
            }
        }
    }
    func readFile(path: String) -> [[Int]]{
        var fileContent = [String]()
            
        let data = try? NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        var dataInt = [Int]()
        for i in fileContent{
            var leadArray = data?.componentsSeparatedByString("\n")
            for i in 0..<leadArray!.count{ // index starts at 2 to avoid the date and time
                var valueArray = leadArray![i].componentsSeparatedByString(" ")
                for j in 1..<valueArray.count{
                    dataInt.append(Int16(valueArray[j])!)
                }
                intArray.append(intvalueArray)
            }
        }
        return fileContent
    }

    
}