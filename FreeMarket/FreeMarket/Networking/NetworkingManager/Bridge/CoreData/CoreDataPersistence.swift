//
//  CoreDataPersistence.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 18/03/21.
//

import Combine
import CoreData

final class CoreDataPersistence<Entity: NSManagedObject>: Persistence {
    
    lazy var coreDataStore: CoreDataStoring = {
        return CoreDataStore.default
    }()
    
    var cancellable: [AnyCancellable] = []
    
    func getData<T : Decodable>(text: String) -> AnyPublisher<T?, Error>  {
        return Future<T?,Error> { promise in
            
        }.eraseToAnyPublisher()
    }
    
    func getItems<T : Decodable>() -> AnyPublisher<[T]?, Error>  {
        return Future<[T]?, Error> { [coreDataStore] promise in
            let request = NSFetchRequest<Entity>(entityName: Entity.entityName)
            let cancellable = coreDataStore
                .publicher(fetch: request)
                .sink { completion in
                    if case .failure(let error) = completion {
                        CLogger.log(category: .parsing).error("error: '\(error.localizedDescription)'")
                        return promise(.failure(error))
                    }
                } receiveValue: { entity   in
                    var items: [T] = []
                    
                    entity.forEach {
                        guard let entityJson = $0.toJSON() else {
                            CLogger.log(category: .parsing).error("error JSON: '\(ParsingError.parsingError)'")
                            return promise(.failure(ParsingError.parsingError))
                        }
                        
                        guard let data = entityJson.data(using: .utf8) else {
                            CLogger.log(category: .parsing).error("error DATA: '\(ParsingError.parsingError)'")
                            return promise(.failure(ParsingError.parsingError))
                        }
                        
                        guard let itemCasting: T = JsonFetch.jsonFetch(data: data) else {
                            CLogger.log(category: .parsing).error("error Casting: '\(ParsingError.parsingError)'")
                            return promise(.failure(ParsingError.parsingError))
                        }
                        
                        items.append(itemCasting)
                        
                    }
        
                    promise(.success(items))
                    
                }
            cancellable.cancel()
        }.eraseToAnyPublisher()
    }
    
}

extension NSManagedObject {
  func toJSON() -> String? {
    let keys = Array(self.entity.attributesByName.keys)
    let dict = self.dictionaryWithValues(forKeys: keys)
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let reqJSONStr = String(data: jsonData, encoding: .utf8)
        return reqJSONStr
    }
    catch{}
    return nil
  }
}


