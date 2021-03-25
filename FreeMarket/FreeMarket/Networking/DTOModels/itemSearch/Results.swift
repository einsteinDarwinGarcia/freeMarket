//
//  Result.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation

struct Results : Decodable {

        let acceptsMercadopago : Bool?
        let address : Address?
        let attributes : [Attribute]?
        let availableQuantity : Int?
        let buyingMode : String?
        let catalogListing : Bool?
        let catalogProductId : String?
        let categoryId : String?
        let condition : String?
        let currencyId : String?
        let id : String?
        let installments : Installment?
        let listingTypeId : String?
        let officialStoreId : Int?
        let originalPrice : Double?
        let permalink : String?
        let price : Double?
        let seller : Seller?
        let sellerAddress : SellerAddress?
        let shipping : Shipping?
        let siteId : String?
        let soldQuantity : Int?
        let stopTime : String?
        let tags : [String]?
        var thumbnail : String?
        let title : String?

        enum CodingKeys: String, CodingKey {
                case acceptsMercadopago = "accepts_mercadopago"
                case address = "address"
                case attributes = "attributes"
                case availableQuantity = "available_quantity"
                case buyingMode = "buying_mode"
                case catalogListing = "catalog_listing"
                case catalogProductId = "catalog_product_id"
                case categoryId = "category_id"
                case condition = "condition"
                case currencyId = "currency_id"
                case id = "id"
                case installments = "installments"
                case listingTypeId = "listing_type_id"
                case officialStoreId = "official_store_id"
                case originalPrice = "original_price"
                case permalink = "permalink"
                case price = "price"
                case seller = "seller"
                case sellerAddress = "seller_address"
                case shipping = "shipping"
                case siteId = "site_id"
                case soldQuantity = "sold_quantity"
                case stopTime = "stop_time"
                case tags = "tags"
                case thumbnail = "thumbnail"
                case title = "title"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                acceptsMercadopago = try values.decodeIfPresent(Bool.self, forKey: .acceptsMercadopago)
                address = try values.decodeIfPresent(Address.self, forKey: .address)
                attributes = try values.decodeIfPresent([Attribute].self, forKey: .attributes)
                availableQuantity = try values.decodeIfPresent(Int.self, forKey: .availableQuantity)
                buyingMode = try values.decodeIfPresent(String.self, forKey: .buyingMode)
                catalogListing = try values.decodeIfPresent(Bool.self, forKey: .catalogListing)
                catalogProductId = try values.decodeIfPresent(String.self, forKey: .catalogProductId)
                categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
                condition = try values.decodeIfPresent(String.self, forKey: .condition)
                currencyId = try values.decodeIfPresent(String.self, forKey: .currencyId)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                installments = try values.decodeIfPresent(Installment.self, forKey: .installments)
                listingTypeId = try values.decodeIfPresent(String.self, forKey: .listingTypeId)
                officialStoreId = try values.decodeIfPresent(Int.self, forKey: .officialStoreId)
                originalPrice = try values.decodeIfPresent(Double.self, forKey: .originalPrice)
                permalink = try values.decodeIfPresent(String.self, forKey: .permalink)
                price = try values.decodeIfPresent(Double.self, forKey: .price)
                seller = try values.decodeIfPresent(Seller.self, forKey: .seller)
                sellerAddress = try values.decodeIfPresent(SellerAddress.self, forKey: .sellerAddress)
                shipping = try values.decodeIfPresent(Shipping.self, forKey: .shipping)
                siteId = try values.decodeIfPresent(String.self, forKey: .siteId)
                soldQuantity = try values.decodeIfPresent(Int.self, forKey: .soldQuantity)
                stopTime = try values.decodeIfPresent(String.self, forKey: .stopTime)
                tags = try values.decodeIfPresent([String].self, forKey: .tags)
                thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
                title = try values.decodeIfPresent(String.self, forKey: .title)
        }

}
