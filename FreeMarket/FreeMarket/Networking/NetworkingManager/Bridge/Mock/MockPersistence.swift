//
//  MockPersistence.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation
import Combine

final class MockPersistence: Persistence {
    
    var jsonName: String
    
    init(name: String) {
        self.jsonName = name
    }
    
    func getData<T: Decodable>(text: String) -> AnyPublisher<T?, Error> {
        return Future<T?, Error> { promise in
            return promise(.success(self.jsonFetch())) 
        }.eraseToAnyPublisher()
    }
    
    func jsonFetch<T: Decodable>() -> T? {
        
        guard
            let url = Bundle.main.url(forResource: self.jsonName , withExtension: "json"),
          let data = try? Data(contentsOf: url)
          else {
            return nil
        }
        
        return JsonFetch.jsonFetch(data: data)
        
    }
    
}

struct JsonFetch {
    static func jsonFetch<T: Decodable>(data: Data) -> T? {
        do {
          let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
          return try decoder.decode(T.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            
            CLogger.log(category: .parsing).fault("Key '\(context.codingPath)' data corrupted \(context.debugDescription)")
            return nil
        } catch let DecodingError.keyNotFound(key, context) {
            CLogger.log(category: .parsing).fault("Key '\(key.stringValue)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
            return nil
        } catch let DecodingError.valueNotFound(value, context) {
            CLogger.log(category: .parsing).fault("Value '\(value.self)' not found: \(context.debugDescription), codingPath: \(context.codingPath)")
            return nil
        } catch let DecodingError.typeMismatch(type, context)  {
            CLogger.log(category: .parsing).fault("type '\(type.self)' mismatch: \(context.debugDescription), codingPath: \(context.codingPath)")
            return nil
        } catch {
            CLogger.log(category: .parsing).error("error: '\(error.localizedDescription)'")
            return nil
        }
    }
}
