//
//  StorageManager.swift
//  WeatherForecast
//
//  Created by Jakkidi Chandrasekhar Reddy on 21/08/21.
//

import CoreData

protocol StorageManagerProtocol {
    func saveRecord(forEntity: EntityName,
                    with data: [String: Any],
                    completion: (StorageResult<String, Error>) -> Void)
    func fetchRecords(forEntity: EntityName,
                      completion: (StorageResult<ManagedObjects, Error>) -> Void)
    func deleteRecord(model: NSManagedObject,
                      completion: (StorageResult<String, Error>) -> Void)
    func deleteAllRecords(forEntity: EntityName, completion: (StorageResult<String, Error>) -> Void)
}

class StorageManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: ContainerName.weatherForecast.rawValue)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension StorageManager: StorageManagerProtocol {
    func saveRecord(forEntity: EntityName,
                    with data: [String: Any],
                    completion: (StorageResult<String, Error>) -> Void) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: forEntity.rawValue, in: context)
        let newRecord = NSManagedObject(entity: entity!, insertInto: context)
        data.forEach { (key: String, value: Any) in
            newRecord.setValue(value, forKey: key)
        }
        if context.hasChanges {
            do {
                try context.save()
                completion(.success(Success.message.rawValue))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchRecords(forEntity: EntityName,
                      completion: (StorageResult<ManagedObjects, Error>) -> Void) {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: forEntity.rawValue)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if let managedObjects = result as? [NSManagedObject] {
                completion(.success(managedObjects))
            } else {
                completion(.success([NSManagedObject]()))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteRecord(model: NSManagedObject,
                      completion: (StorageResult<String, Error>) -> Void) {
        let context = persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completion(.success(Success.message.rawValue))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteAllRecords(forEntity: EntityName, completion: (StorageResult<String, Error>) -> Void) {
        let context = persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: forEntity.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
            completion(.success(Success.message.rawValue))
        }
        catch
        {
            completion(.failure(error))
        }
    }
}

enum StorageResult<S, E> {
    case success(S)
    case failure(E)
}

private enum Success: String {
    case message = "Saved Successfully"
}

public typealias ManagedObjects = [NSManagedObject]
