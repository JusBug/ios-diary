//
//  CoreDataManager.swift
//  Diary
//
//  Created by 박종화 on 2023/09/01.
//

import Foundation
import CoreData

class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Diary")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            guard let error = error as NSError? else {
                return
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var diaryEntity: NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: "Diary", in: context)
    }
    
    func setUpDiary(_ sample: Sample) {
        if let entity = diaryEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(sample.title, forKey: "title")
            managedObject.setValue(sample.body, forKey: "body")
            managedObject.setValue(sample.createdDate, forKey: "createdDate")
        }
    }
}
