//
//  Archive.swift
//  EKGShirt
//
//  Created by Yu, Peter M on 4/2/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation
import CoreData

class Archive: NSManagedObject{
    
    static var newArchiveList = [Archive]()
    
//MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("archives")
    
//MARK: Properties
    @NSManaged var date: String
    @NSManaged var time: String
    @NSManaged var path: String
    @NSManaged var leads: String
    @NSManaged var symptoms: String
    @NSManaged var symptomsAbbreviations: String
    var data = [String:[Int]]()
    var dataPopulated = false
    
    init(date: NSDate, path: String, symptoms: [String], entity: NSEntityDescription, context: NSManagedObjectContext) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        let formatter = NSDateFormatter()
        var dateStringSplit = [String]()
        formatter.dateFormat = "MM/dd/yy hh:mm"
        let dateString = formatter.stringFromDate(date)
        dateStringSplit =  dateString.componentsSeparatedByString(" ")
        self.date = dateStringSplit[0]
        self.time = dateStringSplit[1]
        
        self.path = path
        let csv = CSVParse(path: path)
        self.leads = csv.getHeader()
        self.symptoms = symptoms.joinWithSeparator(", ")
        self.symptomsAbbreviations = Symptoms.instance.getSymptomsAbbreviations(symptoms).joinWithSeparator(",")
    }

    static func getNewArchiveList() -> [Archive] {
        let list = Archive.newArchiveList
        Archive.newArchiveList = [Archive]()
        return list
    }
    
    func getData() -> [String: [Int]]{
        let csv = CSVParse(path: path)
        let data = csv.getcolumns()
        dataPopulated = true
        return data
    }
    
    func getSymptoms() -> String {
        return symptoms
    }
    
    func getSymptomsAbbreviations() -> String {
        return symptomsAbbreviations
    }
    
    private static func setDateTime(date: NSDate){

    }
    func getDate()->String{
        return self.date
    }
    func getTime()->String{
        return self.time
    }
    func getPath()->String{
        return path
    }
    func getLeads() -> [String] {
        let leadArray = self.leads.componentsSeparatedByString(" ")
        return leadArray
    }
    func getLeadData(leadName: String) -> [Int]{
        if(data.keys.count == 0 || !dataPopulated) {
            data = getData()
            dataPopulated = true
        }
        return data[leadName]!
    }
    
}