//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct DetailRule : Codable {

        let defaultField : Bool?
        let freeMode : String?
        let freeShippingFlag : Bool?

        enum CodingKeys: String, CodingKey {
                case defaultField = "default"
                case freeMode = "free_mode"
                case freeShippingFlag = "free_shipping_flag"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                defaultField = try values.decodeIfPresent(Bool.self, forKey: .defaultField)
                freeMode = try values.decodeIfPresent(String.self, forKey: .freeMode)
                freeShippingFlag = try values.decodeIfPresent(Bool.self, forKey: .freeShippingFlag)
        }

}
