//
//  Archive.swift
//  EKGShirt
//
//  Created by Yu, Peter M on 4/2/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation
import SwiftCSV

class Archive: NSObject, NSCoding{
    
    static var newArchiveList = [Archive]()
    
    enum LeadNum{
        case LEAD1,LEAD2,LEAD3,AVF,AVL,AVR,V
    }
    
    
//MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("archives")
    
//MARK: Properties
    private var date = String()
    private var time = String()
    private var path = NSURL()
    private var data = [String: [Double]]()
    private var symptoms = String()
    private var symptomsAbbreviations = String()
    
    init(date: NSDate, path: NSURL, symptoms: [String]){
        super.init()
        setDateTime(date)
        self.path = path
        readFile(path)
        self.symptoms = symptoms.joinWithSeparator(", ")
        self.symptomsAbbreviations = Symptoms.instance.getSymptomsAbbreviations(symptoms).joinWithSeparator(",")
        Archive.newArchiveList.append(self)
    }
    
    init(date: String, time: String, path: NSURL, data: [String: [Double]], symptoms: String, symptomsAbbreviations: String) {
        self.date = date
        self.time = time
        self.path = path
        self.data = data
        self.symptoms = symptoms
        self.symptomsAbbreviations = symptomsAbbreviations
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let date = aDecoder.decodeObjectForKey("date") as? String else {return nil}
        let time = aDecoder.decodeObjectForKey("time") as? String
        let path = aDecoder.decodeObjectForKey("path") as? NSURL
        let data = aDecoder.decodeObjectForKey("data") as? [String: [Double]]
        let symptoms = aDecoder.decodeObjectForKey("symptoms") as? String
        let symptomsAbbreviations = aDecoder.decodeObjectForKey("symptomsAbbreviations") as? String
        self.init(date: date, time: time!, path: path!, data: data!, symptoms: symptoms!, symptomsAbbreviations: symptomsAbbreviations!)
    }
    
    
    static func getNewArchiveList() -> [Archive] {
        let list = Archive.newArchiveList
        Archive.newArchiveList = [Archive]()
        return list
    }

    
//MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(time, forKey: "time")
        aCoder.encodeObject(path, forKey: "path")
        aCoder.encodeObject(data, forKey: "data")
        aCoder.encodeObject(symptoms, forKey: "symptoms")
        aCoder.encodeObject(symptomsAbbreviations, forKey: "symptomsAbbreviations")
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
        formatter.dateFormat = "MM/dd/yy hh:mm"
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
    func getPath()->NSURL{
        return path
    }
    func getData(lead: LeadNum) ->[Double]{
        switch lead{
        case .LEAD1:
            return data["Lead 1"]!
        case .LEAD2:
            return data["Lead 2"]!
        case .LEAD3:
            return data["Lead 3"]!
        /*case .AVF:
            return data["aVF"]!
        case .AVR:
            return data["aVR"]
        case .AVL:
            return data["aVL"]
        case .V:
            return data["V"]*/
        default:
            return [Double]()
        }
    }
    
    private func readFile(path: NSURL) {
        do {
            let csv = try CSV(url: path)
            let csvData = csv.columns // [String: [String]]
            var allData = [String: [Double]]()
            
            for (lead, value) in csvData {
                let doubleArray = value.flatMap{Double($0)}
                allData[lead] = doubleArray
            }
            self.data = allData
            
        } catch {
            print("Couldn't Find file at: \(path.absoluteString)")
        }
    }
}