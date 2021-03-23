//
//  
//  ItemDetailStore.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//
//

import Combine

class ItemDetailModelStore: ObservableObject {
    @Published var itemDetail: ItemDetailModel = ItemDetailModel(id: "ERADFAERQEWGAD",
                                                                 condition: "Nuevo",
                                                                 title: "iPhone 11 128 Gb Verde",
                                                                 photos: [""],
                                                                 attributes: [AttributesItem(name: "Marca", value: "iPhone"), AttributesItem(name: "Modelo", value: "iPhone SSE (2nd Generaciion)")],
                                                                 price: 1799900,
                                                                 mercadoPago: true,
                                                                 warranty: "Garantía de fábrica: 12 meses",
                                                                 stock: 4)
}

class ItemDetailViewStore<D: FluxDispatcher, MS: ItemDetailModelStore >: FluxStore where D.L == ItemDetailListActions {
    
    var modelStore: MS
    var dispatcher: D
    
    required init(dispatcher: D, modelStore: MS) {
        self.dispatcher = dispatcher
        self.modelStore = modelStore
        self.dispatcher.register { [weak self] (ItemDetailListActions) in
            
            guard let strongSelf = self else { return }
            
            switch ItemDetailListActions {
            case .setItemDetail(let value):
                strongSelf.modelStore.itemDetail = value
            }
        }
    }
}
