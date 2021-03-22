//
//  ItemSearchModel.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//

import Foundation

struct ItemSearchModel: Hashable, Identifiable, Decodable {
    let id: String
    let category: String
    var saved: Bool?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(category + id)
    }
    
    static func ==(lhs: ItemSearchModel, rhs: ItemSearchModel) -> Bool {
        return lhs.category == rhs.category && lhs.id == rhs.id
    }
}
