//
//  Video+CoreDataProperties.swift
//  
//
//  Created by LamTran on 7/5/17.
//
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video")
    }

    @NSManaged public var length: Double
    @NSManaged public var link: String?
    @NSManaged public var name: String?
    @NSManaged public var speed: Int32
    @NSManaged public var timeLoop: Int32
    @NSManaged public var timePlaying: Int32
    @NSManaged public var translated: String?
    @NSManaged public var date: NSDate

}
