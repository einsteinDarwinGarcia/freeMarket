//
//  
//  ContentStore.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//
//

import Combine

class ContentModelStore: ObservableObject {
    @Published var isLoggedOut: Bool = true
    @Published var items: [ItemSearchModel] = []
}

class ContentViewStore<D: FluxDispatcher, MS: ContentModelStore >: FluxStore where D.L == ContentListActions {
    
    var modelStore: MS
    var dispatcher: D
    
    required init(dispatcher: D, modelStore: MS) {
        self.dispatcher = dispatcher
        self.modelStore = modelStore
        self.dispatcher.register { [weak self] (ContentListActions) in
            
            guard let strongSelf = self else { return }
            
            switch ContentListActions {
            case .isLoggedOut(let value):
                strongSelf.modelStore.isLoggedOut = value
            case .setItems(let items):
                guard let items = items else {
                    return
                }
                strongSelf.modelStore.items = items
            }
        }
    }
}
