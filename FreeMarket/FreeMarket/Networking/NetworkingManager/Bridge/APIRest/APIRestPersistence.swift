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
    
    func returnEndpoint(text: String) -> Endpoint {
        switch self {
        case .detailItems:
           return Endpoint.searchItemDetail(idItem: text)
        case .searchItems:
            return Endpoint.searchItems(text: text)
        case .categoryItems:
            return Endpoint.searchCategories(idCategory: text)
        }
    }
}

class APIRestPersistence: APIRestProtocol, Persistence {
    
    enum ParsingError: Error {
        case parsingError
        case weakself
    }

    var cancellabe: Set<AnyCancellable>
    var serviceType: ServiceItem
    
    init(serviceType: ServiceItem) {
        self.serviceType = serviceType
        cancellabe = []
    }
    
    
    func getData<T>(text: String) -> AnyPublisher<T?, Never> where T : Decodable {
        
        return Future<T?, Never> { [weak self] promise in
            
            guard let strongSelf = self else {
                return promise(.success(nil)) // TODO: Logger manage error
            }
            
            let endpoint = strongSelf.serviceType.returnEndpoint(text: text)
            
            strongSelf.get(type: T.self, url: endpoint.url, headers: endpoint.headers).sink { (response) in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)
                    break // TODO: logger
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
                return promise(.failure(ParsingError.weakself)) // TODO: Logger manage error
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            headers.forEach { (key, value) in
                if let value = value as? String {
                    urlRequest.setValue(value, forHTTPHeaderField: key)
                }
            }
            
           URLSession.shared.dataTaskPublisher(for: urlRequest).tryMap { data, response in
                return data
           }
           .receive(on: RunLoop.main)
           .sink { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            default:
                break
            }
           } receiveValue: { (data) in
            guard let itemCasting: T = JsonFetch.jsonFetch(data: data) else {
                return // TODO: logger
            }
            promise(.success(itemCasting))
            
           }.store(in: &strongSelf.cancellabe)
            
        }
        .eraseToAnyPublisher()
    }
}
