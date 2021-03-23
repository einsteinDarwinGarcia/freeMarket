//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct DetailSearchLocation : Codable {

        let city : DetailCity?
        let state : DetailState?

        enum CodingKeys: String, CodingKey {
                case city = "city"
                case state = "state"
        }
    
        init(from decoder: Decoder) throws {
                let _ = try decoder.container(keyedBy: CodingKeys.self)
                city = try DetailCity(from: decoder)
                state = try DetailState(from: decoder)
        }

}
