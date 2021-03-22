//
//  CoreDataStore.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 18/03/21.
//

import CoreData

enum StorageType {
    case persistent, inMemory
}

extension NSManagedObject {
    class var entityName: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

protocol EntityCreating {
    var viewContext: NSManagedObjectContext { get }
    func createEntity<T: NSManagedObject>() -> T
}

extension EntityCreating {
    func createEntity<T: NSManagedObject>() -> T {
        T(context: viewContext)
    }
}

protocol CoreDataFetchResultsPublishing {
    var viewContext: NSManagedObjectContext { get }
    func publicher<T: NSManagedObject>(fetch request: NSFetchRequest<T>) -> CoreDataFetchResultsPublisher<T>
}

extension CoreDataFetchResultsPublishing {
    func publicher<T: NSManagedObject>(fetch request: NSFetchRequest<T>) -> CoreDataFetchResultsPublisher<T> {
        return CoreDataFetchResultsPublisher(request: request, context: viewContext)
    }
}

protocol CoreDataSaveModelPublishing {
    var viewContext: NSManagedObjectContext { get }
    func publicher(save action: @escaping ActionCoreData) -> CoreDataSaveModelPublisher
}

extension CoreDataSaveModelPublishing {
    func publicher(save action: @escaping ActionCoreData) -> CoreDataSaveModelPublisher {
        return CoreDataSaveModelPublisher(action: action, context: viewContext)
    }
}

protocol CoreDataStoring: EntityCreating, CoreDataFetchResultsPublishing, CoreDataSaveModelPublishing {
    var viewContext: NSManagedObjectContext { get }
}

class CoreDataStore: CoreDataStoring {
    
    private let container: NSPersistentContainer
    
    static var `default`: CoreDataStoring = {
        return CoreDataStore(name: "FreeMarketCoreData", in: .persistent)
    }()
    
    var viewContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    init(name: String, in storageType: StorageType) {
        self.container = NSPersistentContainer(name: name)
        self.setupIfMemoryStorage(storageType)
        self.container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    private func setupIfMemoryStorage(_ storageType: StorageType) {
        if storageType  == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.container.persistentStoreDescriptions = [description]
        }
    }
}
