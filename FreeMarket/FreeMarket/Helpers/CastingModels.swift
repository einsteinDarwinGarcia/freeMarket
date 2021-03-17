//
//  CastingModels.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation
import Combine

class CastingModels {

    var itemCasted = CurrentValueSubject<[ItemsModel]?, Never>(nil)
     
    func casting(rootClass: RootClass?) {
        
        var items: [ItemsModel]?
        
        items = rootClass?.results?.compactMap({ (model) -> ItemsModel? in
            
            let modelItem = model.attributes?.compactMap { $0 }.filter { $0.id == "MODEL" }.first
            
            let attributes: [Attributes]? = model.attributes?.compactMap({ (attribute) -> Attributes? in
                let attributes = Attributes(name: attribute.name,
                                            value: attribute.valueName,
                                            attributeGroupId: attribute.attributeGroupId)
                return attributes
            })
            
            let itemModel = ItemsModel(siteId: model.siteId,
                                       title: model.title ?? String(),
                                       price: model.price,
                                       availableQuantity: model.availableQuantity,
                                       thumbnail: model.thumbnail,
                                       cityName: model.address?.cityName,
                                       freeChipping: model.shipping?.freeShipping,
                                       model: modelItem?.valueName,
                                       attributes: attributes)
            
            return itemModel
        })
        
        self.itemCasted.value = items
        
    }
    
    
}
