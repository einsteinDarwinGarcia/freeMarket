//
//  CastingModels.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation
import Combine

class CastingToSearchViewModels: CastingToModels {
     
    func casting(rootClass: [Results]?) -> Future<SearchingModel?, Error> {
        return Future<SearchingModel?, Error> { promise in
            var items: [ItemsModel]?
            var itemSearchModel: [ItemSearchModel]? = []
            
            items = rootClass?.lazy.compactMap({ (model) -> ItemsModel? in
                
                let modelItem = model.attributes?.lazy.compactMap { $0 }.filter { $0.id == "title" }.first
                
                let modelProduct = (modelItem?.valueName) == nil ? model.title : modelItem?.valueName
                
                let attributes: [Attributes]? = model.attributes?.lazy.compactMap({ (attribute) -> Attributes? in
                    let attributes = Attributes(name: attribute.name,
                                                value: attribute.valueName,
                                                attributeGroupId: attribute.attributeGroupId)
                    return attributes
                })
                
                
                let itemModel = ItemsModel(id:model.id ?? "",
                                           siteId: model.siteId,
                                           categoryId: model.categoryId,
                                           title: model.title ?? String(),
                                           price: model.price,
                                           availableQuantity: model.availableQuantity,
                                           thumbnail: model.thumbnail,
                                           cityName: model.address?.cityName,
                                           freeChipping: model.shipping?.freeShipping,
                                           model: modelProduct ?? String(),
                                           attributes: attributes)
                
                itemSearchModel?.append(ItemSearchModel(id: model.title ?? String(),
                                                        category: model.categoryId ?? String(),
                                                        saved: false))
                
                return itemModel
            })
            
            guard let itemsModel = items, let itemSearch = itemSearchModel else {
                return promise(.success(nil))
            }
            
            return promise(.success(SearchingModel(itemSearch: itemSearch, items: itemsModel)))
        
        }
        
           
    }
    
    
}
