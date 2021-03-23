//
//  
//  ItemDetailActions.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//
//
import SwiftUI
import Combine

protocol ItemDetailActionsProtocol: ViewActionsProtocol {
    func loadData()
}

enum ItemDetailListActions: ListActions {
    case setItemDetail(ItemDetailModel)
    
    func setCategoryToCLog() -> Category {
        .login
    }
}

class ItemDetailActions<C: ItemDetailViewCoordinator, D: FluxDispatcher>:  Action<C>, ItemDetailActionsProtocol where D.L == ItemDetailListActions {
    
    private let dispatcher: D
    
    private var contentViewStore: AnyObject?
    
    private var itemDetail: ItemsModel
    
    private var networkingLayer: NetworkingDetailItems!
    private var cancellables: Set<AnyCancellable>!
    
    init(coordinator: C, dispatcher: D, itemDetail: ItemsModel) {
        self.dispatcher = dispatcher
        self.itemDetail = itemDetail
        super.init(coordinator: coordinator)
        setupNetworkingLayer()
    }
    
    func configureViewStore(modelStore: ItemDetailModelStore) {
        self.contentViewStore = ItemDetailViewStore(dispatcher: self.dispatcher, modelStore: modelStore)
    }
    
}

// MARK: networking conection layer
extension ItemDetailActions {
    
    func setupNetworkingLayer() {
        self.networkingLayer = NetworkingDetailItems()
        cancellables = []
    }
    
    func loadData() {
        let id = self.itemDetail.id
        self.networkingLayer.networkingLayerService().sink { [dispatcher] itemDetailModel in
            guard let item = itemDetailModel else {
                return // TODO: logger
            }
            dispatcher.dispatch(.setItemDetail(item))
        }.store(in: &cancellables)
    }
}
