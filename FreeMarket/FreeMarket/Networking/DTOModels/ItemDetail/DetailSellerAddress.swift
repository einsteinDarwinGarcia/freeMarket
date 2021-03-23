//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct DetailSellerAddress : Codable {

        let city : DetailCity?
        let country : DetailCountry?
        let id : Int?
        let searchLocation : DetailSearchLocation?
        let state : DetailState?

        enum CodingKeys: String, CodingKey {
                case city = "city"
                case country = "country"
                case id = "id"
                case searchLocation = "search_location"
                case state = "state"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                city = try DetailCity(from: decoder)
                country = try DetailCountry(from: decoder)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                searchLocation = try DetailSearchLocation(from: decoder)
                state = try DetailState(from: decoder)
        }

}
