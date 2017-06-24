//
//  HistoryDict+CoreDataClass.swift
//  
//
//  Created by LamTran on 6/24/17.
//
//

import Foundation
import CoreData


public class HistoryDict: NSManagedObject {
    static let entityName = "HistoryDict"
    
    // Lấy tất cả danh sách
    static func all() -> [NSManagedObject] {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        do {
            let list = try DB.MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            return list
        } catch let error as NSError {
            print("Cannot get all from entity \(entityName), error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    // Tạo mới một đối tượng để chèn vào CSDl
    static func create() -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: DB.MOC)
    }
    
    
    // Chèn một word vào CSDl
    static func insert(word word: String) -> HistoryDict? {
        let new = create() as! HistoryDict
        new.word = word
        
        do {
            try DB.MOC.save()
            return new
        } catch let error as NSError{
            print("Can not insert word, \(error), \(error.userInfo)");
        }
        
        return nil
    }
    
    
    //delete all data
    static func deleteAllRecords() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try DB.MOC.execute(deleteRequest)
        } catch {
            print ("Error in delete entity")
        }
    }
}
