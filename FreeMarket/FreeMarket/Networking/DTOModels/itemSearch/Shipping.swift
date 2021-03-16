//
//  Shipping.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation

struct Shipping : Decodable {

        let freeShipping : Bool?
        let logisticType : String?
        let mode : String?
        let storePickUp : Bool?
        let tags : [String]?

        enum CodingKeys: String, CodingKey {
                case freeShipping = "free_shipping"
                case logisticType = "logistic_type"
                case mode = "mode"
                case storePickUp = "store_pick_up"
                case tags = "tags"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                freeShipping = try values.decodeIfPresent(Bool.self, forKey: .freeShipping)
                logisticType = try values.decodeIfPresent(String.self, forKey: .logisticType)
                mode = try values.decodeIfPresent(String.self, forKey: .mode)
                storePickUp = try values.decodeIfPresent(Bool.self, forKey: .storePickUp)
                tags = try values.decodeIfPresent([String].self, forKey: .tags)
        }

}
