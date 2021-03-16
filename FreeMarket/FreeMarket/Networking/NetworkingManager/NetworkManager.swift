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
    
    var configuration: configuration
    
    init(configuration: configuration) {
        self.configuration = configuration
    }
    
    func getData() {
        
        var jsonName:String
        
        switch self.configuration.provider {
        case .mock(let name):
            jsonName = name
        default:
            jsonName = ""
        }
        
        let persistence = PersistenceManager<configuration.responseDataType>(persistenceType: MockPersistence(name: jsonName))
        self.configuration.networkResponse.value = persistence.getData()
    }
    
}
