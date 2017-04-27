//
//  Archive.swift
//  EKGShirt
//
//  Created by Yu, Peter M on 4/2/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//
// Container for Archived information: Date, Time, File Path, EKG Data, & Symptoms

import Foundation

class Archive: NSObject, NSCoding{
    
//MARK: Statics
    static var newArchiveList = [Archive]()
    
//MARK: Properties
    private var date = String()
    private var time = String()
    private var path = NSURL()
    private var data = [String: [Int]]()
    private var leads = [String]()
    private var symptoms = String()
    private var symptomsAbbreviations = String()
    
    //Constructor for creating New Archives
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
    
    //Constructor for bringing Old Archives back into scope from memory
    required convenience init?(coder aDecoder: NSCoder) {
        guard let date = aDecoder.decodeObjectForKey("date") as? String else {return nil}
        let time = aDecoder.decodeObjectForKey("time") as? String
        let path = aDecoder.decodeObjectForKey("path") as? NSURL
        let symptoms = aDecoder.decodeObjectForKey("symptoms") as? String
        let symptomsAbbreviations = aDecoder.decodeObjectForKey("symptomsAbbreviations") as? String
        self.init(date: date, time: time!, path: path!, symptoms: symptoms!, symptomsAbbreviations: symptomsAbbreviations!)
    }
    
    //Constructor for populating values once brought back from memory
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
    
//MARK: Coding to store simple variables as Bytes in Documents Directory
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(time, forKey: "time")
        aCoder.encodeObject(path, forKey: "path")
        aCoder.encodeObject(symptoms, forKey: "symptoms")
        aCoder.encodeObject(symptomsAbbreviations, forKey: "symptomsAbbreviations")
    }
    
    func setDateTime(date: NSDate){
        let formatter = NSDateFormatter()
        var dateStringSplit = [String]()
        formatter.dateFormat = "MM/dd/yy hh:mm"
        let dateString = formatter.stringFromDate(date)
        dateStringSplit =  dateString.componentsSeparatedByString(" ")
        self.date = dateStringSplit[0]
        self.time = dateStringSplit[1]
    }
    
    func getSymptoms() -> String {
        return symptoms
    }
    
    func getSymptomsAbbreviations() -> String {
        return symptomsAbbreviations
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
    
    func getData(lead: String) ->[Int]?{
        return data[lead]
    }
    
    func getLeads() -> [String] {
        return self.leads
    }
    
}