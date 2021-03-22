//
//  Persistence.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation
import Combine

protocol Switch {
    associatedtype T: Decodable
    var persistence: Persistence { get set }
    func getData() -> AnyPublisher<T?, Never>
    func getItems() -> AnyPublisher<[T]?, Never>
}

protocol Persistence {
    func getData<T: Decodable>() -> AnyPublisher<T?, Never>
    func getItems<T : Decodable>() -> AnyPublisher<[T]?, Never>
}

extension Persistence {
    func getItems<T : Decodable>() -> AnyPublisher<[T]?, Never> {
        return Future<[T]?, Never> { promise in
            // TODO: logger
        }.eraseToAnyPublisher()
    }
}

protocol DTOModel: Decodable, Persistence {
    func jsonName() -> String
}

