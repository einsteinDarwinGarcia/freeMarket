//
//  Attribute.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation

struct Attribute : Decodable {

        let attributeGroupId : String?
        let attributeGroupName : String?
        let id : String?
        let name : String?
        let source : Int?
        let valueId : String?
        let valueName : String?
        let valueStruct : ValueStruct?

        enum CodingKeys: String, CodingKey {
                case attributeGroupId = "attribute_group_id"
                case attributeGroupName = "attribute_group_name"
                case id = "id"
                case name = "name"
                case source = "source"
                case valueId = "value_id"
                case valueName = "value_name"
                case valueStruct = "value_struct"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                attributeGroupId = try values.decodeIfPresent(String.self, forKey: .attributeGroupId)
                attributeGroupName = try values.decodeIfPresent(String.self, forKey: .attributeGroupName)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                source = try values.decodeIfPresent(Int.self, forKey: .source)
                valueId = try values.decodeIfPresent(String.self, forKey: .valueId)
                valueName = try values.decodeIfPresent(String.self, forKey: .valueName)
                valueStruct = try values.decodeIfPresent(ValueStruct.self, forKey: .valueStruct)
        }

}

struct ValueStruct: Decodable {
    let number: Double?
    let unit: String?
}
