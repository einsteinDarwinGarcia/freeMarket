//
//  NetworkManager.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Combine

protocol NetworkManagerLayer {
    associatedtype Configuration:NetworkConfiguration
    func getData(text: String) -> AnyPublisher<Configuration.responseDataType?, Never>
    func getCoreDataResult() -> AnyPublisher<[Configuration.responseDataType]?, Never>
}

class NetworkManager<Configuration: NetworkConfiguration>: NetworkManagerLayer {
    
    typealias response = AnyPublisher<Configuration.responseDataType?, Never>
    
    private var configuration: Configuration
    private var persistenceBridge: PersistenceManager<Configuration.responseDataType>?
    
    init(configuration: Configuration) {
        self.configuration = configuration
        switch self.configuration.provider {
        case .mock(let name):
            self.persistenceBridge = PersistenceManager<Configuration.responseDataType>(persistenceType: MockPersistence(name: name))
        case .APIRest(let serviceItem):
            self.persistenceBridge = PersistenceManager<Configuration.responseDataType>(persistenceType: APIRestPersistence(serviceType: serviceItem))
        case .coreData(let coreDataPersistence):
            self.persistenceBridge = PersistenceManager<Configuration.responseDataType>(persistenceType: coreDataPersistence)
        }
    }
    
    func getData(text: String) -> response {
        guard let persistence = self.persistenceBridge else {
            return errorInitializedPersistence()
        }
        return persistence.getData(text: text)
    }
    
    func getCoreDataResult() -> AnyPublisher<[Configuration.responseDataType]?, Never> {
        return Future<[Configuration.responseDataType]?, Never> { promise in
            let cancellable = self.persistenceBridge?.getItems().sink(receiveValue: { (value) in
                
                return promise(.success(value))
            })
            cancellable?.cancel()
        }.eraseToAnyPublisher()
    }
    
    func errorInitializedPersistence() -> response {
        return Future<Configuration.responseDataType?, Never> { promise in
            // TODO: Logger
        }.eraseToAnyPublisher()
    }
}

struct CastingDataResult {
    var result: Any
}

/*
 
 return Future<Configuration.responseDataType?, Never> { promise in
    let cancellable = self.persistenceBridge?.getData().sink(receiveValue: { value in
         return promise(.success(value)) // TODO: logger
     })
     cancellable?.cancel()
 }.eraseToAnyPublisher()
 
 **/
