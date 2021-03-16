//
//  Paging.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation

struct Paging : Decodable {

        let limit : Int?
        let offset : Int?
        let primaryResults : Int?
        let total : Int?

        enum CodingKeys: String, CodingKey {
                case limit = "limit"
                case offset = "offset"
                case primaryResults = "primary_results"
                case total = "total"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                limit = try values.decodeIfPresent(Int.self, forKey: .limit)
                offset = try values.decodeIfPresent(Int.self, forKey: .offset)
                primaryResults = try values.decodeIfPresent(Int.self, forKey: .primaryResults)
                total = try values.decodeIfPresent(Int.self, forKey: .total)
        }

}
