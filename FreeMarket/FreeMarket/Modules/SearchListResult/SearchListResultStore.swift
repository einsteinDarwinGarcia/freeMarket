//
//  
//  SearchListResultStore.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//
//

import Combine
import SwiftUI

class ToggleViewModel: ObservableObject {
    let priceDidChange = PassthroughSubject<Bool, Never>()
    let availableDidChange = PassthroughSubject<Bool, Never>()

    var priceSort = false {
        didSet {
            priceDidChange.send(priceSort)
        }
    }

    var availableSort = false {
        didSet {
            availableDidChange.send(availableSort)
        }
    }
}

class SearchListResultModelStore: ObservableObject {
    @Published var searchItemSaved: String? = nil
    @Published var searchedItem: [ItemsModel] = []
    var price = CurrentValueSubject<Binding<Bool>, Never>(.constant(false))
}

class SearchListResultViewStore<D: FluxDispatcher, MS: SearchListResultModelStore >: FluxStore where D.L == SearchListResultListActions {
    
    var modelStore: MS
    var dispatcher: D
    
    required init(dispatcher: D, modelStore: MS) {
        self.dispatcher = dispatcher
        self.modelStore = modelStore
        self.dispatcher.register { [weak self] (SearchListResultListActions) in
            
            guard let strongSelf = self else { return }
            
            switch SearchListResultListActions {
            case .loadItems(let value):
                strongSelf.modelStore.searchedItem = value
            }
        }
    }
    
    deinit {
        self.modelStore.searchedItem.removeAll()
    }
}
