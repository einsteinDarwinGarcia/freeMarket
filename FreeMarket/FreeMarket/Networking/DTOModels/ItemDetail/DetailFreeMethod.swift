//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct DetailFreeMethod : Codable {

        let id : Int?
        let rule : DetailRule?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case rule = "rule"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                rule = try DetailRule(from: decoder)
        }

}
