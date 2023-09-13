//
//  CoreDataManager.swift
//  Diary
//
//  Created by 박종화 on 2023/09/01.
//

import UIKit

class CoreDataManager {
    static var shared: CoreDataManager = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entities: [Entity] = []
    
    // MARK: CRUD 구현
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Create
    func createEntity(title: String, body: String) {
        let newEntity = Entity(context: context)
        newEntity.title = title
        newEntity.body = body
        
        saveToContext()
        getAllEntity()
    }
    
    // MARK: Read
    func getAllEntity() {
        do {
            entities = try context.fetch(Entity.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Update
    func update(entity: Entity, newTitle: String, newBody: String) {
        entity.title = newTitle
        entity.body = newBody
        
        saveToContext()
    }
    
    // MARK: Delete
    func delete(entity: Entity) {
        context.delete(entity)
        
        saveToContext()
    }
}
