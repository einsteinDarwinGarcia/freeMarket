//
//  CastingModels.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import Foundation
import Combine

class CastingToSearchViewModels: CastingToModels {

    var itemCasted = CurrentValueSubject<SearchingModel?, Never>(nil)
     
    func casting(rootClass: RootClass?) {
        
        var items: [ItemsModel]?
        var itemSearchModel: [ItemSearchModel]? = []
        
        items = rootClass?.results?.lazy.compactMap({ (model) -> ItemsModel? in
            
            let modelItem = model.attributes?.lazy.compactMap { $0 }.filter { $0.id == "MODEL" }.first
            
            let modelProduct = (modelItem?.valueName) == nil ? model.title : modelItem?.valueName
            
            let attributes: [Attributes]? = model.attributes?.lazy.compactMap({ (attribute) -> Attributes? in
                let attributes = Attributes(name: attribute.name,
                                            value: attribute.valueName,
                                            attributeGroupId: attribute.attributeGroupId)
                return attributes
            })
            
            
            let itemModel = ItemsModel(siteId: model.siteId,
                                       categoryId: model.categoryId,
                                       title: model.title ?? String(),
                                       price: model.price,
                                       availableQuantity: model.availableQuantity,
                                       thumbnail: model.thumbnail,
                                       cityName: model.address?.cityName,
                                       freeChipping: model.shipping?.freeShipping,
                                       model: modelProduct ?? String(),
                                       attributes: attributes)
            
            itemSearchModel?.append(ItemSearchModel(id: modelProduct ?? String(),
                                                    category: model.categoryId ?? String(),
                                                    saved: false))
            
            return itemModel
        })
        
        guard let itemsModel = items, let itemSearch = itemSearchModel else {
            return
        }
        
        self.itemCasted.value = SearchingModel(itemSearch: itemSearch, items: itemsModel)
    }
    
    
}
