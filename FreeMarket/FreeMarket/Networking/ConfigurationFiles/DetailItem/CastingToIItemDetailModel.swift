//
//  CastingToIItemDetailModel.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import Combine

class CastingToItemDetailModels: CastingToModels {

    var itemCasted = CurrentValueSubject<ItemDetailModel?, Never>(nil)
     
    func casting(rootClass: DetailRootClass?) {
        
        let root = rootClass?.body
        let photos = root?.pictures?.map { $0.secureUrl ?? "" }
        let attributes = root?.attributes?.map {
                        return AttributesItem(name: $0.name ?? "", value: $0.valueName ?? "")
                        }
        
        guard let secureAttribute = attributes else { return }
        
        let item = ItemDetailModel(id: root?.id ?? "",
                         condition: root?.condition,
                         title: root?.title,
                         photos: photos,
                         attributes: secureAttribute,
                         price: root?.price,
                         mercadoPago: root?.acceptsMercadopago,
                         warranty: root?.warranty,
                         stock: root?.availableQuantity)
        
        self.itemCasted.value = item
    }

}
