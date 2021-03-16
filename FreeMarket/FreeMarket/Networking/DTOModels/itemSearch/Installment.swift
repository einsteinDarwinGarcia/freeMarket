//
//  Installment.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation

struct Installment : Decodable {

        let amount : Float?
        let currencyId : String?
        let quantity : Int?
        let rate : Float?

        enum CodingKeys: String, CodingKey {
                case amount = "amount"
                case currencyId = "currency_id"
                case quantity = "quantity"
                case rate = "rate"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                amount = try values.decodeIfPresent(Float.self, forKey: .amount)
                currencyId = try values.decodeIfPresent(String.self, forKey: .currencyId)
                quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
                rate = try values.decodeIfPresent(Float.self, forKey: .rate)
        }

}
