//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct DetailPicture : Codable {

        let id : String?
        let maxSize : String?
        let quality : String?
        let secureUrl : String?
        let size : String?
        let url : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case maxSize = "max_size"
                case quality = "quality"
                case secureUrl = "secure_url"
                case size = "size"
                case url = "url"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                maxSize = try values.decodeIfPresent(String.self, forKey: .maxSize)
                quality = try values.decodeIfPresent(String.self, forKey: .quality)
                secureUrl = try values.decodeIfPresent(String.self, forKey: .secureUrl)
                size = try values.decodeIfPresent(String.self, forKey: .size)
                url = try values.decodeIfPresent(String.self, forKey: .url)
        }

}
