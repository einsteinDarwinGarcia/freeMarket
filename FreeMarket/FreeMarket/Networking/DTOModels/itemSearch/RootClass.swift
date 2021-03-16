//
//  RootClass.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation

struct RootClass : Decodable {

        let paging : Paging?
        let query : String?
        let results : [Results]?
        let siteId : String?

        enum CodingKeys: String, CodingKey {
                case paging = "paging"
                case query = "query"
                case results = "results"
                case siteId = "site_id"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                paging = try Paging(from: decoder)
                query = try values.decodeIfPresent(String.self, forKey: .query)
                results = try values.decodeIfPresent([Results].self, forKey: .results)
                siteId = try values.decodeIfPresent(String.self, forKey: .siteId)
        }

}
