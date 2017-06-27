//
//  Text+CoreDataClass.swift
//  
//
//  Created by LamTran on 6/24/17.
//
//

import Foundation
import CoreData


public class Text: NSManagedObject {
    static let entityName = "Text"
    
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
    static func insert(textObj obj: Text) -> Text? {
        let new = create() as! Text
        new.name = obj.name
        new.indexCurrent = 0
        new.text = obj.text
        new.translated = ""
        do {
            try DB.MOC.save()
            return new
        } catch let error as NSError{
            print("Can not insert Area by this name, \(error), \(error.userInfo)");
        }
        
        return nil
    }

    //delete object
    static func delete(obj: Text) {
        DB.MOC.delete(obj)
        DB.save()
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
