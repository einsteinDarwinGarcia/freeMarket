//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct DetailSaleTerm : Codable {

        let id : String?
        let name : String?
        let valueId : String?
        let valueName : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
                case valueId = "value_id"
                case valueName = "value_name"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                valueId = try values.decodeIfPresent(String.self, forKey: .valueId)
                valueName = try values.decodeIfPresent(String.self, forKey: .valueName)
        }

}
