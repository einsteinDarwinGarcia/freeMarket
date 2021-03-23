//
//  ItemDetailModel.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import Foundation

struct ItemDetailModel: Hashable, Identifiable {
    let id: String
    let condition: String?
    let title: String?
    let photos: [String]?
    let attributes: [AttributesItem]
    let price: Double?
    let mercadoPago: Bool?
    let warranty: String?
    let stock: Int?
    
}

struct AttributesItem: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let value: String
}
