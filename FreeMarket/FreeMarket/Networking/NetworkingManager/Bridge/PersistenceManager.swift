//
//  PersistenceManager.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation

final class PersistenceManager<T: Decodable>: Switch {
    
    var persistence: Persistence
    
    init(persistenceType: Persistence) {
        self.persistence = persistenceType
    }
    
    func getData() -> T? {
        return self.persistence.getData()
    }
    
}
