//
//  ItemsModel.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct ItemsModel: Identifiable, Hashable {
    var id: UUID = UUID()
    var siteId: String?
    var categoryId: String?
    var title: String
    var price: Int?
    var availableQuantity: Int?
    var thumbnail: String?
    var cityName: String?
    var freeChipping: Bool?
    var model: String
    var attributes: [Attributes]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(model + title)
    }
}

struct Attributes: Hashable {
    var id: UUID = UUID()
    var name: String?
    var value: String?
    var attributeGroupId: String?
}
