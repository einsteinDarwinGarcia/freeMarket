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
    
    func getData<T : Decodable>(text: String) -> AnyPublisher<T?, Never>  {
        return Future<T?,Never> { promise in
            
        }.eraseToAnyPublisher()
    }
    
    func getItems<T : Decodable>() -> AnyPublisher<[T]?, Never>  {
        return Future<[T]?, Never> { [coreDataStore] promise in
            let request = NSFetchRequest<Entity>(entityName: Entity.entityName)
            let cancellable = coreDataStore
                .publicher(fetch: request)
                .sink { completion in
                    if case .failure(let error) = completion {
                        print(error.localizedDescription) // TODO: logger
                    }
                } receiveValue: { entity   in
                    var items: [T] = []
                    
                    entity.forEach {
                        guard let entityJson = $0.toJSON() else {
                            return // TODO: logger
                        }
                        
                        guard let data = entityJson.data(using: .utf8) else {
                            return // TODO: logger
                        }
                        
                        guard let itemCasting: T = JsonFetch.jsonFetch(data: data) else {
                            return // TODO: logger
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

class DecoderWrapper: Decodable {

    let decoder:Decoder

    required init(from decoder:Decoder) throws {
        self.decoder = decoder
    }
}

protocol JSONDecoding {
     func decodeWith(_ decoder: Decoder) throws
}

extension JSONDecoding where Self:NSManagedObject {

    func decode(json:[String:Any]) throws {

        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        let wrapper = try JSONDecoder().decode(DecoderWrapper.self, from: data)
        try decodeWith(wrapper.decoder)
    }
}

extension ItemSearchEntity: JSONDecoding {

    enum CodingKeys: String, CodingKey {
        case category // For example
        case id
    }

    func decodeWith(_ decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.category = try container.decode(String.self, forKey: .category)
        self.id = try container.decode(String.self, forKey: .id)
    }
}

