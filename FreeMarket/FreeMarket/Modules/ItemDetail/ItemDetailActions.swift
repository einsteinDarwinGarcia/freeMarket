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
    
    lazy var coreDataStore: CoreDataStoring = {
        return CoreDataStore.default
    }()
    
    init(coordinator: C, dispatcher: D, itemDetail: ItemsModel) {
        self.dispatcher = dispatcher
        self.itemDetail = itemDetail
        super.init(coordinator: coordinator)
        setupNetworkingLayer()
        saveCoreData()
    }
    
    func configureViewStore(modelStore: ItemDetailModelStore) {
        self.contentViewStore = ItemDetailViewStore(dispatcher: self.dispatcher, modelStore: modelStore)
    }
    
    func saveCoreData() {
        
        let action: ActionCoreData = { [coreDataStore, itemDetail] in
            let item: ItemDetailHistoryEntity = coreDataStore.createEntity()
            item.id = itemDetail.id
            item.title = itemDetail.title
            item.thumbnail = itemDetail.thumbnail
            item.price = itemDetail.price ?? 0.0
            item.categoryId = itemDetail.categoryId
            item.model = itemDetail.model
        }
        
        coreDataStore
            .publicher(save: action)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription) // TODO: logger
                }
            } receiveValue: { success in
                if success {
                  print("Saving entities succeeded") // TODO: logger
                }
            }
            .store(in: &cancellables)
        
    }
    
}

// MARK: networking conection layer
extension ItemDetailActions {
    
    func setupNetworkingLayer() {
        self.networkingLayer = NetworkingDetailItems()
        cancellables = []
    }
    
    func loadData() {
        self.networkingLayer.networkingLayerService(text: self.itemDetail.id).sink { [dispatcher] itemDetailModel in
            guard let item = itemDetailModel else {
                return // TODO: logger
            }
            dispatcher.dispatch(.setItemDetail(item))
        }.store(in: &cancellables)
    }
}
