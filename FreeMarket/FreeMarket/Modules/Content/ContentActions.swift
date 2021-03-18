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
    func loadData(text: AnyPublisher<String, Never>)
    func presentListResult(isPresented: Binding<Bool>, itemSelected: ItemSearchModel) -> V
}

enum ContentListActions: ListActions {
    case isLoggedOut(Bool)
    case setItems([ItemSearchModel]?)
    func setCategoryToCLog() -> Category {
        .login
    }
}

class ContentActions<C: ContentViewCoordinator, D: FluxDispatcher>:  Action<C>, ContentActionsProtocol where D.L == ContentListActions {
    
    private let dispatcher: D
    private var contentViewStore: AnyObject?

    private var cancellables: Set<AnyCancellable>!
    
    private var totalItemsSearched: [ItemsModel]?
    
    private var networkingLayer: NetworkingSearchItems!
    
    init(coordinator: C, dispatcher: D) {
        self.dispatcher = dispatcher
        super.init(coordinator: coordinator)
        setupNetworkingLayer()
    }
    
    func configureViewStore(modelStore: ContentModelStore) {
        self.contentViewStore = ContentViewStore(dispatcher: self.dispatcher, modelStore: modelStore)
    }
    
    func loadData(text: AnyPublisher<String, Never>) {
        text.sink { [weak self] searchingText in
            if SearchBarValidations.isValidateTextToActiveSearchService(text: searchingText) {
                self?.networkingAction()
            }
        }.store(in: &cancellables)
    }
    
    func presentListResult(isPresented: Binding<Bool>, itemSelected: ItemSearchModel) -> some View {
        
        let itemSearched = self.totalItemsSearched?.filter { $0.model == itemSelected.id }
        
        return coordinator?.presentListResult(isPresented: isPresented, itemSelected: itemSearched, totalItems: self.totalItemsSearched)
    }
}

// MARK: networking conection layer
extension ContentActions {
    func setupNetworkingLayer() {
        self.networkingLayer = NetworkingSearchItems()
        cancellables = []
    }
    
    func networkingAction() {
        self.networkingLayer.networkingLayerService().sink(receiveValue: { (items) in
            
            self.totalItemsSearched = items?.items
            let searchFilter = items?.itemSearch.removingDuplicates()
            self.dispatcher.dispatch(.setItems(searchFilter))
            
        }).store(in: &cancellables)
    }
}


