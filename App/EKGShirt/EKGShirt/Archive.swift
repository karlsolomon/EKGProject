//
//  Archive.swift
//  EKGShirt
//
//  Created by Yu, Peter M on 4/2/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation

class Archive: NSObject, NSCoding{
    
    static var newArchiveList = [Archive]()
    
    
    
    
//MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("archives")
    
//MARK: Properties
    private var date = String()
    private var time = String()
    private var path = NSURL()
    private var data = [String: [Int]]()
    private var leads = [String]()
    private var symptoms = String()
    private var symptomsAbbreviations = String()
    
    init(date: NSDate, path: NSURL, symptoms: [String]){
        super.init()
        setDateTime(date)
        self.path = path
        let csv = CSVParse(url: path)
        self.data = csv.getcolumns()
        self.leads = csv.getHeader()
        self.symptoms = symptoms.joinWithSeparator(", ")
        self.symptomsAbbreviations = Symptoms.instance.getSymptomsAbbreviations(symptoms).joinWithSeparator(",")
    }
    
    init(date: String, time: String, path: NSURL, symptoms: String, symptomsAbbreviations: String) {
        self.date = date
        self.time = time
        self.path = path
        let csv = CSVParse(url: path)
        self.data = csv.getcolumns()
        self.leads = csv.getHeader()
        self.symptoms = symptoms
        self.symptomsAbbreviations = symptomsAbbreviations
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let date = aDecoder.decodeObjectForKey("date") as? String else {return nil}
        let time = aDecoder.decodeObjectForKey("time") as? String
        let path = aDecoder.decodeObjectForKey("path") as? NSURL
        let symptoms = aDecoder.decodeObjectForKey("symptoms") as? String
        let symptomsAbbreviations = aDecoder.decodeObjectForKey("symptomsAbbreviations") as? String
        self.init(date: date, time: time!, path: path!, symptoms: symptoms!, symptomsAbbreviations: symptomsAbbreviations!)
    }
    
//MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(time, forKey: "time")
        aCoder.encodeObject(path, forKey: "path")
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
    func getData(lead: String) ->[Int]{
        return data[lead]!
    }
    func getLeads() -> [String] {
        return self.leads
    }
    
}