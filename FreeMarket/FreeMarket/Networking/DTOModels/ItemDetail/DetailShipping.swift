//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct DetailShipping : Codable {

        let freeMethods : [DetailFreeMethod]?
        let freeShipping : Bool?
        let localPickUp : Bool?
        let logisticType : String?
        let mode : String?
        let storePickUp : Bool?
        let tags : [String]?

        enum CodingKeys: String, CodingKey {
                case freeMethods = "free_methods"
                case freeShipping = "free_shipping"
                case localPickUp = "local_pick_up"
                case logisticType = "logistic_type"
                case mode = "mode"
                case storePickUp = "store_pick_up"
                case tags = "tags"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                freeMethods = try values.decodeIfPresent([DetailFreeMethod].self, forKey: .freeMethods)
                freeShipping = try values.decodeIfPresent(Bool.self, forKey: .freeShipping)
                localPickUp = try values.decodeIfPresent(Bool.self, forKey: .localPickUp)
                logisticType = try values.decodeIfPresent(String.self, forKey: .logisticType)
                mode = try values.decodeIfPresent(String.self, forKey: .mode)
                storePickUp = try values.decodeIfPresent(Bool.self, forKey: .storePickUp)
                tags = try values.decodeIfPresent([String].self, forKey: .tags)
        }

}
