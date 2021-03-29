//
//  APIRestPersistence.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import Foundation
import Combine

enum ServiceItem {
    case searchItems
    case detailItems
    case categoryItems
    case secureThumbnail
    
    func returnEndpoint(text: String) -> Endpoint {
        switch self {
        case .detailItems:
           return Endpoint.searchItemDetail(idItem: text)
        case .searchItems:
            return Endpoint.searchItems(text: text)
        case .categoryItems:
            return Endpoint.searchCategories(idCategory: text)
        case .secureThumbnail:
            return Endpoint.searchItemDetailSecureThumbnail(idItem: text)
        }
    }
}

enum ParsingError: Error, CustomStringConvertible {
    case parsingError
    case weakself
    case error500
    case persistenceNil
}

extension ParsingError {
    var description: String {
        switch self {
        case .parsingError:
            return "Error en el parsing"
        case .weakself:
            return "se perdio la referencia"
        case .error500:
            return "error 500 en la conexion"
        case .persistenceNil:
            return "Persistencia no inicializada"
        }
    }
}

class APIRestPersistence: APIRestProtocol, Persistence {
    
    var cancellabe: Set<AnyCancellable>
    var serviceType: ServiceItem
    
    init(serviceType: ServiceItem) {
        self.serviceType = serviceType
        cancellabe = []
    }
    
    
    func getData<T>(text: String) -> AnyPublisher<T?, Error> where T : Decodable {
        
        return Future<T?, Error> { [weak self] promise in
            
            guard let strongSelf = self else {
                CLogger.log(category: .parsing).warning("error: '\(ParsingError.weakself)'")
                return promise(.success(nil))
            }
            
            let endpoint = strongSelf.serviceType.returnEndpoint(text: text)
            
            strongSelf.get(type: T.self, url: endpoint.url, headers: endpoint.headers).sink { (response) in
                switch response {
                case .failure(let error):
                    CLogger.log(category: .parsing).error("error: '\(error.localizedDescription)'")
                    return promise(.failure(error))
                default:
                    break
                }
                
            } receiveValue: { (data) in
                
                return promise(.success(data))
                
            }.store(in: &strongSelf.cancellabe)
            
            
        }.eraseToAnyPublisher()
  
    }
    
    func get<T: Decodable>(type: T.Type,
                           url: URL,
                           headers: Headers
    ) -> AnyPublisher<T, Error> {
        
        return Future<T, Error> { [weak self] promise in
            
            guard let strongSelf = self else {
                CLogger.log(category: .parsing).error("error: '\(ParsingError.weakself)'")
                return promise(.failure(ParsingError.weakself))
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            headers.forEach { (key, value) in
                if let value = value as? String {
                    urlRequest.setValue(value, forHTTPHeaderField: key)
                }
            }
            
            URLSession.shared.dataTaskPublisher(for: urlRequest).tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw ParsingError.error500
                }
                return data
            }
            .receive(on: RunLoop.main)
            .sink { (response) in
                switch response {
                case .failure(let error):
                    CLogger.log(category: .url).error("error: '\(error.localizedDescription)'")
                    return promise(.failure(error))
                default:
                    break
                }
            } receiveValue: { (data) in
                guard let itemCasting: T = JsonFetch.jsonFetch(data: data) else {
                    CLogger.log(category: .parsing).error("error: '\(ParsingError.parsingError)'")
                    return
                }
                promise(.success(itemCasting))
                
            }.store(in: &strongSelf.cancellabe)
            
        }
        .eraseToAnyPublisher()
    }
}
