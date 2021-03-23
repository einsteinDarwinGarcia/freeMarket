//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation

struct DetailBody : Codable {

        let acceptsMercadopago : Bool?
        let attributes : [DetailAttribute]?
        let automaticRelist : Bool?
        let availableQuantity : Int?
        let basePrice : Int?
        let buyingMode : String?
        let catalogListing : Bool?
        let catalogProductId : String?
        let categoryId : String?
        let channels : [String]?
        let condition : String?
        let currencyId : String?
        let dateCreated : String?
        let descriptions : [DetailDescription]?
        let domainId : String?
        let id : String?
        let initialQuantity : Int?
        let internationalDeliveryMode : String?
        let lastUpdated : String?
        let listingSource : String?
        let listingTypeId : String?
        let permalink : String?
        let pictures : [DetailPicture]?
        let price : Double?
        let saleTerms : [DetailSaleTerm]?
        let secureThumbnail : String?
        let sellerId : Int?
        let shipping : DetailShipping?
        let siteId : String?
        let soldQuantity : Int?
        let startTime : String?
        let status : String?
        let stopTime : String?
        let tags : [String]?
        let thumbnail : String?
        let thumbnailId : String?
        let title : String?
        let warranty : String?

        enum CodingKeys: String, CodingKey {
                case acceptsMercadopago = "accepts_mercadopago"
                case attributes = "attributes"
                case automaticRelist = "automatic_relist"
                case availableQuantity = "available_quantity"
                case basePrice = "base_price"
                case buyingMode = "buying_mode"
                case catalogListing = "catalog_listing"
                case catalogProductId = "catalog_product_id"
                case categoryId = "category_id"
                case channels = "channels"
                case condition = "condition"
                case currencyId = "currency_id"
                case dateCreated = "date_created"
                case descriptions = "descriptions"
                case domainId = "domain_id"
                case id = "id"
                case initialQuantity = "initial_quantity"
                case internationalDeliveryMode = "international_delivery_mode"
                case lastUpdated = "last_updated"
                case listingSource = "listing_source"
                case listingTypeId = "listing_type_id"
                case permalink = "permalink"
                case pictures = "pictures"
                case price = "price"
                case saleTerms = "sale_terms"
                case secureThumbnail = "secure_thumbnail"
                case sellerId = "seller_id"
                case shipping = "shipping"
                case siteId = "site_id"
                case soldQuantity = "sold_quantity"
                case startTime = "start_time"
                case status = "status"
                case stopTime = "stop_time"
                case tags = "tags"
                case thumbnail = "thumbnail"
                case thumbnailId = "thumbnail_id"
                case title = "title"
                case warranty = "warranty"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                acceptsMercadopago = try values.decodeIfPresent(Bool.self, forKey: .acceptsMercadopago)
                attributes = try values.decodeIfPresent([DetailAttribute].self, forKey: .attributes)
                automaticRelist = try values.decodeIfPresent(Bool.self, forKey: .automaticRelist)
                availableQuantity = try values.decodeIfPresent(Int.self, forKey: .availableQuantity)
                basePrice = try values.decodeIfPresent(Int.self, forKey: .basePrice)
                buyingMode = try values.decodeIfPresent(String.self, forKey: .buyingMode)
                catalogListing = try values.decodeIfPresent(Bool.self, forKey: .catalogListing)
                catalogProductId = try values.decodeIfPresent(String.self, forKey: .catalogProductId)
                categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
                channels = try values.decodeIfPresent([String].self, forKey: .channels)
                condition = try values.decodeIfPresent(String.self, forKey: .condition)
                currencyId = try values.decodeIfPresent(String.self, forKey: .currencyId)
                dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
                descriptions = try values.decodeIfPresent([DetailDescription].self, forKey: .descriptions)
                domainId = try values.decodeIfPresent(String.self, forKey: .domainId)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                initialQuantity = try values.decodeIfPresent(Int.self, forKey: .initialQuantity)
                internationalDeliveryMode = try values.decodeIfPresent(String.self, forKey: .internationalDeliveryMode)
                lastUpdated = try values.decodeIfPresent(String.self, forKey: .lastUpdated)
                listingSource = try values.decodeIfPresent(String.self, forKey: .listingSource)
                listingTypeId = try values.decodeIfPresent(String.self, forKey: .listingTypeId)
                permalink = try values.decodeIfPresent(String.self, forKey: .permalink)
                pictures = try values.decodeIfPresent([DetailPicture].self, forKey: .pictures)
                price = try values.decodeIfPresent(Double.self, forKey: .price)
                saleTerms = try values.decodeIfPresent([DetailSaleTerm].self, forKey: .saleTerms)
                secureThumbnail = try values.decodeIfPresent(String.self, forKey: .secureThumbnail)
                sellerId = try values.decodeIfPresent(Int.self, forKey: .sellerId)
                shipping = try DetailShipping(from: decoder)
                siteId = try values.decodeIfPresent(String.self, forKey: .siteId)
                soldQuantity = try values.decodeIfPresent(Int.self, forKey: .soldQuantity)
                startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                stopTime = try values.decodeIfPresent(String.self, forKey: .stopTime)
                tags = try values.decodeIfPresent([String].self, forKey: .tags)
                thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
                thumbnailId = try values.decodeIfPresent(String.self, forKey: .thumbnailId)
                title = try values.decodeIfPresent(String.self, forKey: .title)
                warranty = try values.decodeIfPresent(String.self, forKey: .warranty)
        }

}
