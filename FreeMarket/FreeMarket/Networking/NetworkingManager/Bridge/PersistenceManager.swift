//
//  PersistenceManager.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Combine
import CoreData

final class PersistenceManager<T: Decodable>: Switch {
    
    var persistence: Persistence
    
    init(persistenceType: Persistence) {
        self.persistence = persistenceType
    }
    
    func getData(text: String) -> AnyPublisher<T?, Error> {
        return self.persistence.getData(text: text)
    }
    
    func getItems(sort: NSSortDescriptor) -> AnyPublisher<[T]?, Error> {
        return self.persistence.getItems(sort: sort)
    }
    
    func saveData(action: @escaping ActionCoreData) {
        self.persistence.saveData(action: action)
    }
    
}
