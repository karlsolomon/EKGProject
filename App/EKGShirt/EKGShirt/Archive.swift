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
    private var date = String()
    private var time = String()
    private var path = NSString()
    private var data = [[Int]]()
    private var symptoms = String()
    private var symptomsAbbreviations = String()
    
    init(date: NSDate, path: NSString, symptoms: [String]){
        setDateTime(date)
        self.path = path
     //   self.data = readFile(path)
        self.symptoms = symptoms.joinWithSeparator(",")
        self.symptomsAbbreviations = Symptoms.instance.getSymptomsAbbreviations(symptoms).joinWithSeparator(",")
        Archive.ArchiveList.append(self)
    }
    
    func getSymptoms() -> String {
        return symptoms
    }
    
    func getSymptomsAbbreviations() -> String {
        return symptomsAbbreviations
    }
    
    func setDateTime(date: NSDate){
        let formatter = NSDateFormatter()
        var dateStringSplit = [String]()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "mm/dd/yy HH:mm"
        let dateString = formatter.stringFromDate(date)
        dateStringSplit =  dateString.componentsSeparatedByString(" ")
        self.date = dateStringSplit[0]
        self.time = dateStringSplit[1]
    }
    func getDate()->String{
        return self.date
    }
    func getTime()->String{
        return self.time
    }
    func getPath()->NSString{
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
    func getArchive(path:String)->Archive?{
        for archive in Archive.ArchiveList{
            if archive.getPath() == path{
                return archive
            }
        }
        return nil
    }
    
    func getFile() -> String {
        return path as String
    }
    
    func readFile(path: String) -> [[Int]]{
        var fileContent = [[Int]]()
        
        let data = try? NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        var dataInt = [Int]()
        let leadArray = data?.componentsSeparatedByString("\n")
        for lead in leadArray!{
            let valueArray = lead.componentsSeparatedByString(" ")
            for value in valueArray{
                let valueInt = Int(value)
                dataInt.append(valueInt!)
            }
            fileContent.append(dataInt)
        }
        return fileContent
        
     
    }
    
    static func getArchiveList() -> [Archive] {
        return ArchiveList
    }
 
    
}