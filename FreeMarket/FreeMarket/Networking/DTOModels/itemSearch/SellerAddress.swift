//
//  SellerAddress.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation

struct SellerAddress : Decodable {

        let addressLine : String?
        let city : City?
        let comment : String?
        let country : Country?
        let id : String?
        let latitude : String?
        let longitude : String?
        let state : StateCountry?
        let zipCode : String?

        enum CodingKeys: String, CodingKey {
                case addressLine = "address_line"
                case city = "city"
                case comment = "comment"
                case country = "country"
                case id = "id"
                case latitude = "latitude"
                case longitude = "longitude"
                case state = "state"
                case zipCode = "zip_code"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                addressLine = try values.decodeIfPresent(String.self, forKey: .addressLine)
                city = try City(from: decoder)
                comment = try values.decodeIfPresent(String.self, forKey: .comment)
                country = try Country(from: decoder)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
                longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
                state = try StateCountry(from: decoder)
                zipCode = try values.decodeIfPresent(String.self, forKey: .zipCode)
        }

}
