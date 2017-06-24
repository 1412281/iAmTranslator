//
//  HistoryDict+CoreDataProperties.swift
//  
//
//  Created by LamTran on 6/24/17.
//
//

import Foundation
import CoreData


extension HistoryDict {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryDict> {
        return NSFetchRequest<HistoryDict>(entityName: "HistoryDict")
    }

    @NSManaged public var word: String?

}
