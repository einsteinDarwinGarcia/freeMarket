//
//  Persistence.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation

protocol Switch {
    associatedtype T: Decodable
    var persistence: Persistence { get set }
    func getData() -> T?
}

protocol Persistence {
    func getData<T: Decodable>() -> T?
}

protocol DTOModel: Decodable, Persistence {
    func jsonName() -> String
}

extension Persistence {
   
    
   
    
}
