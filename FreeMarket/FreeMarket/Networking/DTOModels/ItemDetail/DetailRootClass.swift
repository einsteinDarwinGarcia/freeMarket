//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct DetailRootClass : Codable {

        let body : DetailBody?
        let code : Int?

        enum CodingKeys: String, CodingKey {
                case body = "body"
                case code = "code"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                body = try values.decodeIfPresent(DetailBody.self, forKey: .body)
                code = try values.decodeIfPresent(Int.self, forKey: .code)
        }

}
