//
//  
//  ContentActions.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//
//
import SwiftUI
import Combine

protocol ContentActionsProtocol: ViewActionsProtocol {
    associatedtype V: View
    func loadData()
    func goToSomewhere(isPresented: Binding<Bool>) -> V
}

enum ContentListActions: ListActions {
    case isLoggedOut(Bool)
    case setItems([ItemsModel]?)
    func setCategoryToCLog() -> Category {
        .login
    }
}

class ContentActions<C: ContentViewCoordinator, D: FluxDispatcher>:  Action<C>, ContentActionsProtocol where D.L == ContentListActions {
    
    private let dispatcher: D
    
    private var contentViewStore: AnyObject?
    
    private var networkManager: NetworkManager<ConfigurationSearchService>?
    private var cancellables: Set<AnyCancellable>!
    
    init(coordinator: C, dispatcher: D) {
        self.dispatcher = dispatcher
        super.init(coordinator: coordinator)
        cancellables = []
    }
    
    func configureViewStore(modelStore: ContentModelStore) {
        self.contentViewStore = ContentViewStore(dispatcher: self.dispatcher, modelStore: modelStore)
    }
    
    func loadData() {
        
        let configurationService = ConfigurationSearchService()
        let castingModel = CastingModels()
        
        networkManager = NetworkManager(configuration: configurationService)
        networkManager?.getData()
        
        configurationService.networkResponse.sink { (response) in
            castingModel.casting(rootClass: response)
        }.store(in: &cancellables)
        
        castingModel.itemCasted.sink { [weak self] (items) in
            self?.dispatcher.dispatch(.setItems(items))
        }.store(in: &cancellables)
        
    }
    
    func goToSomewhere(isPresented: Binding<Bool>) -> some View {
        return coordinator?.presentSomewhere(isPresented: isPresented)
    }
}
