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
import CoreData

protocol ContentActionsProtocol: ViewActionsProtocol {
    associatedtype V: View
    func initSearchBar(searchBar: SearchBar)
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

    private var searchBar: SearchBar?
    private var cancellables: Set<AnyCancellable>!
    
    private var totalItemsSearched: [ItemsModel]?
    private var searchTotalFilter: [ItemSearchModel]?
    
    private var networkingLayer: NetworkingSearchItems!
    private var networkingLayerCoreData: CoreDataSearchItem!
    
    lazy var coreDataStore: CoreDataStoring = {
        return CoreDataStore.default
    }()
    
    
    init(coordinator: C, dispatcher: D) {
        self.dispatcher = dispatcher
        super.init(coordinator: coordinator)
        setupNetworkingLayer()
    }
    
    func configureViewStore(modelStore: ContentModelStore) {
        self.contentViewStore = ContentViewStore(dispatcher: self.dispatcher, modelStore: modelStore)
    }
    
    func clearData() {
        self.totalItemsSearched?.removeAll()
        self.searchTotalFilter?.removeAll()
        searchSavedItems()
    }
    
    func initSearchBar(searchBar: SearchBar) {
        self.searchBar = searchBar
        
        self.searchBar?.activeSearchService.sink(receiveValue: { [weak self] searchingText in
            if SearchBarValidations.isValidateTextToActiveSearchService(text: searchingText) {
                self?.networkingAction(text: searchingText)
            }
        }).store(in: &cancellables)
        
        self.searchBar?.$resetSearching.sink(receiveValue: { [weak self] searchingText in
            self?.clearData()
        }).store(in: &cancellables)
        
    }
    
    func presentListResult(isPresented: Binding<Bool>, itemSelected: ItemSearchModel) -> some View {
       /* if self.totalItemsSearched == nil {
            self.networkingAction(text: itemSelected.category) // TODO: waiting to make a search
        }
        */
        let itemSearched = self.totalItemsSearched?.filter { $0.model == itemSelected.id }
        return coordinator?.presentListResult(isPresented: isPresented, itemSelected: itemSearched, totalItems: self.totalItemsSearched)
    }
    
    func searchSavedItems() {
        self.networkingLayerCoreData.networkingLayerService().sink { [weak self] (value) in
            // get saved Items, remove duplicates and set true flag saved to visual propouse
            self?.searchTotalFilter = value?.map({ $0 }).removingDuplicates().map {
                let model = ItemSearchModel(id:$0.id, category: $0.category, saved: true)
                return model
            }
            self?.dispatcher.dispatch(.setItems(self?.searchTotalFilter))
        }.store(in: &cancellables)
    }
    
}

// MARK: networking conection layer
extension ContentActions {
    func setupNetworkingLayer() {
        self.networkingLayer = NetworkingSearchItems()
        self.networkingLayerCoreData = CoreDataSearchItem()
        cancellables = []
    }
    
    func networkingAction(text: String) {
        self.networkingLayer.networkingLayerService().sink(receiveValue: { (items) in
            
            self.totalItemsSearched = items?.items
            // remove items with the same category
            var searchFilter = items?.itemSearch.removingDuplicates()
            
            // remove items saved from items service
            self.searchTotalFilter?.forEach { item in
                searchFilter?.removeAll(where: { $0.hashValue == item.hashValue })
            }
            
            guard let searchFilterService = searchFilter, let searchFilterSaved = self.searchTotalFilter else {
                return // TODO: logger
            }
            
            self.dispatcher.dispatch(.setItems(searchFilterSaved + searchFilterService  ))
            
        }).store(in: &cancellables)
    }
}


