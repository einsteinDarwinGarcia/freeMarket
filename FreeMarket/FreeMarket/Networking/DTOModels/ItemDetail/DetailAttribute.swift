//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct DetailAttribute : Codable {

        let attributeGroupId : String?
        let attributeGroupName : String?
        let id : String?
        let name : String?
        let valueId : String?
        let valueName : String?

        enum CodingKeys: String, CodingKey {
                case attributeGroupId = "attribute_group_id"
                case attributeGroupName = "attribute_group_name"
                case id = "id"
                case name = "name"
                case valueId = "value_id"
                case valueName = "value_name"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                attributeGroupId = try values.decodeIfPresent(String.self, forKey: .attributeGroupId)
                attributeGroupName = try values.decodeIfPresent(String.self, forKey: .attributeGroupName)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                valueId = try values.decodeIfPresent(String.self, forKey: .valueId)
                valueName = try values.decodeIfPresent(String.self, forKey: .valueName)
        }

}
