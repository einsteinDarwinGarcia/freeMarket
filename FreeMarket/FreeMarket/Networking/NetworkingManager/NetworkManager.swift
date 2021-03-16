//
//  NetworkManager.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Combine


enum Provider {
    case mock(jsonName: String)
    case APIRest
    case coreData
}

protocol NetworkConfiguration {
    associatedtype responseDataType: Decodable
    var provider: Provider { get set }
    var networkResponse: CurrentValueSubject<responseDataType?, Never> { get set }
}

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
