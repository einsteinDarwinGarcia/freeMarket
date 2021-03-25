//
//  APIRestLayerImplementation.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//
import Foundation
import Combine

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mercadolibre.com"
        components.path =  path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var headers: [String: Any] {
        return [:]
    }
}

extension Endpoint {
    static func searchItems(text: String) -> Self {
        return Endpoint(path: "/sites/MCO/search",
                        queryItems: [URLQueryItem(name: "q", value: text)])
    }
    
    static func searchCategories(idCategory: String) -> Self {
        return Endpoint(path: "/sites/MCO/search",
                        queryItems: [URLQueryItem(name: "category", value: idCategory)])
    }
    
    static func searchItemDetail(idItem: String) -> Self {
        return Endpoint(path: "/items",
                        queryItems: [URLQueryItem(name: "ids", value: idItem)])
    }
    
    static func searchItemDetailSecureThumbnail(idItem: String) -> Self {
        return Endpoint(path: "/items",
                        queryItems: [URLQueryItem(name: "ids", value: idItem), URLQueryItem(name: "attributes", value: "secure_thumbnail")])
    }
  
}

protocol APIRestProtocol: class {
    typealias Headers = [String: Any]
    
    func get<T>(type: T.Type,
                url: URL,
                headers: Headers
    ) -> AnyPublisher<T, Error> where T: Decodable
}
