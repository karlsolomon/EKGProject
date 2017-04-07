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

//MARK: Properties
    @NSManaged var timeStamp: String
    @NSManaged var path: String
    @NSManaged var leads: String
    @NSManaged var symptoms: String
    @NSManaged var symptomsAbbreviations: String
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    func getData() -> [String: [Int]]{
        let csv = CSVParse(path: path)
        let data = csv.getcolumns()
        return data
    }

    func getLeadData(leadName: String) -> [Int]{
        let data = getData()
        return data[leadName]!
    }
}