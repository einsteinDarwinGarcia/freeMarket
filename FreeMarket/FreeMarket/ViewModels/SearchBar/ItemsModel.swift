//
//  ItemsModel.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct ItemsModel: Identifiable, Hashable, Decodable {
    var id: String
    var siteId: String?
    var categoryId: String?
    var title: String
    var price: Double?
    var availableQuantity: Int?
    var thumbnail: String?
    var cityName: String?
    var freeChipping: Bool?
    var model: String
    var attributes: [Attributes]?
    var important: Bool? = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(model + title)
    }
    
    static func ==(lhs: ItemsModel, rhs: ItemsModel) -> Bool {
        return lhs.model == rhs.model && lhs.title == rhs.title
    }
    
    mutating func changeStateImportant() {
        self.important = true
    }
}

struct Attributes: Hashable, Decodable {
    var id: UUID = UUID()
    var name: String?
    var value: String?
    var attributeGroupId: String?
}
