//
//  FavoriteWord+CoreDataProperties.swift
//  
//
//  Created by LamTran on 6/24/17.
//
//

import Foundation
import CoreData


extension FavoriteWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteWord> {
        return NSFetchRequest<FavoriteWord>(entityName: "FavoriteWord")
    }

    @NSManaged public var word: String?

}
