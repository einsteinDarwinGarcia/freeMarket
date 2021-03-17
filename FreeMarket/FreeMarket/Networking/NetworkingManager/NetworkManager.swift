//
//  NetworkManager.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Combine


class NetworkManager<configuration: NetworkConfiguration> {
    
    private var configuration: configuration
    private var persistenceBridge: PersistenceManager<configuration.responseDataType>?
    
    init(configuration: configuration) {
        self.configuration = configuration
    }
    
    func getData() {
        switch self.configuration.provider {
        case .mock(let name):
            self.persistenceBridge = PersistenceManager<configuration.responseDataType>(persistenceType: MockPersistence(name: name))
        case .APIRest:
            break
        case .coreData:
            break
        }
        self.configuration.networkResponse.value = self.persistenceBridge?.getData()
    }
    
}


