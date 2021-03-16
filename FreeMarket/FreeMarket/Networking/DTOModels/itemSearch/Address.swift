//
//  Address.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation

struct Address : Decodable {

        let cityId : String?
        let cityName : String?
        let stateId : String?
        let stateName : String?

        enum CodingKeys: String, CodingKey {
                case cityId = "city_id"
                case cityName = "city_name"
                case stateId = "state_id"
                case stateName = "state_name"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                cityId = try values.decodeIfPresent(String.self, forKey: .cityId)
                cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
                stateId = try values.decodeIfPresent(String.self, forKey: .stateId)
                stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
        }

}
