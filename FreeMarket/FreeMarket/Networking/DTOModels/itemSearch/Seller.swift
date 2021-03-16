//
//  Seller.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation

struct Seller : Decodable {

        let carDealer : Bool?
        let id : String?
        let powerSellerStatus : String?
        let realEstateAgency : Bool?
        let tags : [String]?

        enum CodingKeys: String, CodingKey {
                case carDealer = "car_dealer"
                case id = "id"
                case powerSellerStatus = "power_seller_status"
                case realEstateAgency = "real_estate_agency"
                case tags = "tags"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                carDealer = try values.decodeIfPresent(Bool.self, forKey: .carDealer)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                powerSellerStatus = try values.decodeIfPresent(String.self, forKey: .powerSellerStatus)
                realEstateAgency = try values.decodeIfPresent(Bool.self, forKey: .realEstateAgency)
                tags = try values.decodeIfPresent([String].self, forKey: .tags)
        }

}
