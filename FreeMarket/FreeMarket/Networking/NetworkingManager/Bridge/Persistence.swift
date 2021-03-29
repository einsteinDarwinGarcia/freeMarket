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
    func getData(text: String) -> AnyPublisher<T?, Error>
    func getItems(sort: NSSortDescriptor) -> AnyPublisher<[T]?, Error>
}

protocol Persistence {
    func getData<T: Decodable>(text: String) -> AnyPublisher<T?, Error>
    func getItems<T : Decodable>(sort: NSSortDescriptor) -> AnyPublisher<[T]?, Error>
    func saveData(action: @escaping ActionCoreData)
}

extension Persistence {
    func getItems<T : Decodable>(sort: NSSortDescriptor) -> AnyPublisher<[T]?, Error> {
        return Future<[T]?, Error> { promise in
            // TODO: logger
        }.eraseToAnyPublisher()
    }
    
    func saveData(action: @escaping ActionCoreData) { }
}

protocol DTOModel: Decodable, Persistence {
    func jsonName() -> String
}

