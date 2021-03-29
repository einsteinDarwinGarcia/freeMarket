//
//  CastingToIItemDetailModel.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import Combine

class CastingToItemDetailModels: CastingToModels {
     
    func casting(rootClass: DetailRootClass?) -> Future<ItemDetailModel?, Error> {
        return Future<ItemDetailModel?, Error> { promise in
            let root = rootClass?.body
            let photos = root?.pictures?.map { $0.secureUrl ?? "" }
            let attributes = root?.attributes?.map {
                            return AttributesItem(name: $0.name ?? "", value: $0.valueName ?? "")
                            }
            
            guard let secureAttribute = attributes else { return }
            guard let securePhotos = photos else { return }
            
            let item = ItemDetailModel(id: root?.id ?? "",
                             condition: root?.condition,
                             title: root?.title,
                             photos: securePhotos,
                             attributes: secureAttribute,
                             price: root?.price,
                             mercadoPago: root?.acceptsMercadopago,
                             warranty: root?.warranty,
                             stock: root?.availableQuantity,
                             categoryId: root?.categoryId)
            
            return promise(.success(item))
        }
    }

}
