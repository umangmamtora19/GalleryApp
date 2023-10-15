//
//  CoreDataManager.swift
//
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    static let moduleName = "GallaryApp"
    
    static var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: moduleName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    static var applicationDocumentsDirectory: URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }()

//    MARK: - Create sqlite file in document directory
    static var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        let persistenStoreURL = applicationDocumentsDirectory.appendingPathComponent("\(moduleName).sqlite")
        CommonUtility.shared.appPrint("Database pathDatabase path : \(persistenStoreURL.absoluteURL)")
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistenStoreURL, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption : true])
        } catch {
            fatalError("Persistent Store error: \(error)")
        }
        return coordinator
    }()

//    MARK: - Get ManagedObjectContext
    static var objectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType) // As stated in the documentation change this depending on your need, but i recommend sticking to main thread if possible.

        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()

//    MARK: - Save Changes
    static func saveToMainContext() { // Just a helper method for removing boilerplate code when you want to save. Remember this will be done on the main thread if called.
        if objectContext.hasChanges {
            do {
                try objectContext.save()
            } catch {
                CommonUtility.shared.appPrint("Error saving main ManagedObjectContext: \(error.localizedDescription)")
            }
        }
    }
    

//    MARK: - Get Entity Description
    static func getEntityDescription(entityName: Entity) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: entityName.rawValue, in: objectContext)
    }
    
//    MARK: - Insert Operation
    static func insertData(in entity: NSEntityDescription) -> NSManagedObject {
        return NSManagedObject(entity: entity, insertInto: objectContext)
    }
    
    //    MARK: - Fetch All
    static func fetchAll<T: NSManagedObject>(entity: Entity, completion: @escaping(Result<[T], APIError>) -> Void) {
        let fetchRequest = NSFetchRequest<T>(entityName: entity.rawValue)
        do {
            let result = try objectContext.fetch(fetchRequest)
            if result.count > 0 {
                CommonUtility.shared.appPrint("Result got")
                completion(.success(result))
            } else {
                completion(.failure(.NoData))
            }
        } catch {
            CommonUtility.shared.appPrint("Error has occure in fetch")
            completion(.failure(.FetchError))
        }
    }
    
    static func deleteAll(_ entity: Entity, completion: @escaping(Result<Void, APIError>) -> Void) {
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity.rawValue)
            let fetchItem = try objectContext.fetch(fetchRequest)
            if fetchItem.count > 0 {
                fetchItem.forEach { obj in
                    objectContext.delete(obj)
                    saveToMainContext()
                }
                completion(.success(()))
            } else {
                completion(.failure(.NoData))
            }
            
        } catch (let error) {
            completion(.failure(.FetchError))
            CommonUtility.shared.appPrint(error.localizedDescription)
        }
    }
    
//    MARK: - Delete All Data Operation
    static func deleteAllDataOf<T: NSManagedObject>(_ type: T.Type) {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: type.description())
            let fetchItem = try objectContext.fetch(fetchRequest)
            if fetchItem.count > 0 {
                fetchItem.forEach { obj in
                    objectContext.delete(obj)
                    saveToMainContext()
                }
            }

        } catch {
            CommonUtility.shared.appPrint(error.localizedDescription)
        }
    }
}


enum Entity: String {
    case ManagedImage
}
