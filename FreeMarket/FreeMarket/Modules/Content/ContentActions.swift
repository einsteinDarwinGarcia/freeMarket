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
    associatedtype D: View
    func initSearchBar(searchBar: SearchBar)
    func presentListResult(isPresented: Binding<Bool>, itemSelected: ItemSearchModel) -> V
    func presentListHistoricalProminentItem(isPresented: Binding<Bool>, itemSelected: ItemsModel) -> D
}

enum ContentListActions: ListActions {
    case isLoggedOut(Bool)
    case setItems([ItemSearchModel]?)
    case setProminentItem(ItemsModel?)
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
    private var historicalProminentItems: [ItemsModel]?
    
    private var networkingLayer: NetworkingSearchItems<ConfigurationSearchService>!
    private var networkingLayerSearchedItemsCoreData: CoreDataSearchItem!
    private var networkingLayerProminentCoreData: CoreDataProminentItem!
    
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
        self.historicalProminentItems?.removeAll()
        getSavedItems()
        getProminentItems()
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
    
    @ViewBuilder
    func presentListResult(isPresented: Binding<Bool>, itemSelected: ItemSearchModel) -> some View {
        if self.totalItemsSearched?.count ?? 0 <= 0 {
           presentItemsSavedCategory(isPresented: isPresented, categoryId: itemSelected.id)
        } else {
           presentListResultItems(isPresented: isPresented, itemSelected: itemSelected)
        }
    }
    
    func presentListHistoricalProminentItem(isPresented: Binding<Bool>, itemSelected: ItemsModel) -> some View  {
        return coordinator?.presentListResult(isPresented: isPresented, itemSelected: [itemSelected], totalItems: self.historicalProminentItems)
    }
    
    
    func presentItemsSavedCategory(isPresented: Binding<Bool>, categoryId: String) -> some View {
         return coordinator?.presentItemsSaved(isPresented: isPresented, categoryId: categoryId)
    }
    
    func presentListResultItems(isPresented: Binding<Bool>, itemSelected: ItemSearchModel) -> some View {
        let itemSearched = self.totalItemsSearched?.filter { $0.model == itemSelected.id }
        return coordinator?.presentListResult(isPresented: isPresented, itemSelected: itemSearched, totalItems: self.totalItemsSearched)
    }
    
    func getSavedItems() {
        self.networkingLayerSearchedItemsCoreData.networkingLayerService(text: String()).sink { [weak self] (value) in
            // get saved Items, remove duplicates and set true flag saved to visual propouse
            self?.searchTotalFilter = value?.map({ $0 }).removingDuplicates().map {
                let model = ItemSearchModel(id:$0.id, category: $0.category, saved: true)
                return model
            }
            self?.dispatcher.dispatch(.setItems(self?.searchTotalFilter))
        }.store(in: &cancellables)
    }
    
    func getProminentItems() {
        self.networkingLayerProminentCoreData.networkingLayerService(text: String()).sink { [weak self] (value) in
            self?.historicalProminentItems = value.map { $0 }?.removingDuplicates()
            self?.dispatcher.dispatch(.setProminentItem(self?.historicalProminentItems?.last))
        }.store(in: &cancellables)
    }
    
}

// MARK: networking conection layer
extension ContentActions {
    func setupNetworkingLayer() {
        self.networkingLayer = NetworkingSearchItems(configService: ConfigurationSearchService())
        self.networkingLayerSearchedItemsCoreData = CoreDataSearchItem()
        self.networkingLayerProminentCoreData = CoreDataProminentItem()
        cancellables = []
    }
    
    func networkingAction(text: String) {
        self.networkingLayer.networkingLayerService(text: text).sink(receiveValue: { (items) in
            
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
            
            self.dispatcher.dispatch(.setItems(searchFilterSaved + searchFilterService))
            
        }).store(in: &cancellables)
    }
}


