//
//  Text+CoreDataProperties.swift
//  
//
//  Created by LamTran on 6/24/17.
//
//

import Foundation
import CoreData


extension Text {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Text> {
        return NSFetchRequest<Text>(entityName: "Text")
    }

    @NSManaged public var indexCurrent: Int32
    @NSManaged public var name: String?
    @NSManaged public var text: String?
    @NSManaged public var translated: String?

}
