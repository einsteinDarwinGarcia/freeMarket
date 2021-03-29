//
//  NetworkManager.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Combine

protocol NetworkManagerLayer {
    associatedtype Configuration:NetworkConfiguration
    func getData(text: String) -> Future<Configuration.responseDataType?, Error>
    func getCoreDataResult() -> AnyPublisher<[Configuration.responseDataType]?, Error>
    func getSecurityThumbnail(text: String) -> AnyPublisher<[DetailRootSecureThumbnail]?, Error>
}

class NetworkManager<Configuration: NetworkConfiguration>: NetworkManagerLayer {
    
    
    typealias response = Future<Configuration.responseDataType?, Error>
    
    private var configuration: Configuration
    private var persistenceBridge: PersistenceManager<Configuration.responseDataType>?
    private var miPersistence = PersistenceManager<[DetailRootSecureThumbnail]>(persistenceType: APIRestPersistence(serviceType: .secureThumbnail))
    
    var cancellabe: Set<AnyCancellable> = []
    
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
        Future<Configuration.responseDataType?, Error> { [weak self] promise in
            
            guard let strongSelf = self else {
                return promise(.success(nil))
            }
            
            guard let persistence = strongSelf.persistenceBridge else {
                return promise(.failure(ParsingError.persistenceNil))
             }
            
            persistence.getData(text: text).sink { (completion) in
                switch completion {
                case .failure(let error):
                    CLogger.log(category: .parsing).error("error: '\(error.localizedDescription)'")
                    return promise(.failure(error))
                default:
                    break
                }
            } receiveValue: { (value) in
                return promise(.success(value))
            }.store(in: &strongSelf.cancellabe)

        }
       
    }
    
    func getSecurityThumbnail(text: String) -> AnyPublisher<[DetailRootSecureThumbnail]?, Error> {
         return miPersistence.getData(text: text)
    }
    
    func getCoreDataResult() -> AnyPublisher<[Configuration.responseDataType]?, Error> {
        return Future<[Configuration.responseDataType]?, Error> { [weak self] promise in
            
            guard let strongSelf = self else {
                return promise(.success(nil))
            }
            
            strongSelf.persistenceBridge?.getItems().sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    CLogger.log(category: .parsing).error("error: '\(error.localizedDescription)'")
                    return promise(.failure(error))
                default:
                    break
                }
            }, receiveValue: { (value) in
                return promise(.success(value))
            }).store(in: &strongSelf.cancellabe)
            
        }.eraseToAnyPublisher()
    }
}

struct CastingDataResult {
    var result: Any
}
