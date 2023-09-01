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
    
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setUpEntity(_ sample: Sample) {
        if let entity = diaryEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(sample.title, forKey: "title")
            managedObject.setValue(sample.body, forKey: "body")
            managedObject.setValue(sample.createdDate, forKey: "createdDate")
        }
    }
    
    func fetchEntity() -> [Entity] {
        do {
            let readRequest = Entity.fetchRequest()
            let sampleData = try context.fetch(readRequest)
            return sampleData
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func getEntity() -> [Sample] {
        var samples: [Sample] = []
        let fetchResults = fetchEntity()
        for result in fetchResults {
            let sample = Sample(title: result.title ?? "", body: result.body ?? "", createdDate: Int(result.createdDate))
            samples.append(sample)
        }
        
        return samples
    }
    
    func updateEntity(_ sample: Sample) {
        let fetchResults = fetchEntity()
        for result in fetchResults {
            if result.body == sample.body {
                result.title = "Updated"
            }
        }
        saveToContext()
    }
}
