//
//  PersistenceManager.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Combine

final class PersistenceManager<T: Decodable>: Switch {
    
    var persistence: Persistence
    
    init(persistenceType: Persistence) {
        self.persistence = persistenceType
    }
    
    func getData() -> AnyPublisher<T?, Never> {
        return self.persistence.getData()
    }
    
    func getItems() -> AnyPublisher<[T]?, Never> {
        return self.persistence.getItems()
    }
    
}
