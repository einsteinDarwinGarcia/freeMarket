//
//  
//  SearchListResultActions.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//
//
import SwiftUI
import Combine

protocol SearchListResultActionsProtocol: ViewActionsProtocol {
    associatedtype V: View
    func combineItems()
    func getItemsSavedCategory(categoryId: String)
    func goToItemDetail(isPresented: Binding<Bool>, item: ItemsModel) -> V
    func sorted(sort: ToggleViewModel)
}

enum SearchListResultListActions: ListActions {
    case loadItems([ItemsModel])
    func setCategoryToCLog() -> Category {
        .login
    }
}

class SearchListResultActions<C: SearchListResultViewCoordinator, D: FluxDispatcher>:  Action<C>, SearchListResultActionsProtocol where D.L == SearchListResultListActions {
    
    private let dispatcher: D
    private var contentViewStore: AnyObject?
    
    private var searchedItem: [ItemsModel]?
    private var totalItems: [ItemsModel]?
    
    private var networkingLayer: NetworkingSearchItems<ConfigurationSearchService>!
    var cancellables: [AnyCancellable] = []
    
    lazy var coreDataStore: CoreDataStoring = {
        return CoreDataStore.default
    }()
    
    init(coordinator: C, dispatcher: D, searchedItem: [ItemsModel]?, totalItems: [ItemsModel]?) {
        self.dispatcher = dispatcher
        self.searchedItem = searchedItem
        self.totalItems = totalItems
        super.init(coordinator: coordinator)
        setupNetworkingLayer()
    }
    
    func configureViewStore(modelStore: SearchListResultModelStore) {
        self.contentViewStore = SearchListResultViewStore(dispatcher: self.dispatcher, modelStore: modelStore)
    }
    
    func combineItems() {
        
        var removeSearched: [ItemsModel] = []
        
        guard var searchedItem = searchedItem, let totalItems = totalItems else {
             return // TODO: logger
         }
        
        saveCoreData()
        
        for (index, _) in searchedItem.enumerated() { searchedItem[index].changeStateImportant() }
        
        let combineItems = searchedItem + totalItems
        removeSearched = combineItems.removingDuplicates()
        
        self.dispatcher.dispatch(.loadItems(removeSearched))
    }
    
    func goToItemDetail(isPresented: Binding<Bool>, item: ItemsModel) -> some View {
        return coordinator?.presentDetailItem(isPresented: isPresented, itemDetail: item)
    }
    
    
    func saveCoreData() {
        
        let action: ActionCoreData = { [coreDataStore, searchedItem] in
            let item: ItemSearchEntity = coreDataStore.createEntity()
            item.id = searchedItem?.first?.model
            item.category = searchedItem?.first?.categoryId
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
    
    func sorted(sort: ToggleViewModel) {
        sort.priceDidChange.sink { [weak self] (sort) in
            self?.priceSort(sort: sort)
        }.store(in: &cancellables)
        
        sort.availableDidChange.sink { [weak self] (sort) in
            self?.availableSort(sort: sort)
        }.store(in: &cancellables)
    }
    
    func priceSort(sort: Bool) {
        totalItems?.sort(by: { (item, item2) -> Bool in
            guard let price1 = item.price, let price2 = item2.price else {
                return false
            }
            return (sort) ? price1 < price2 : price1 > price2
        })
        guard let sortItems = totalItems else {
            return // TODO: logger
        }
        dispatcher.dispatch(.loadItems(sortItems))
    }
    
    func availableSort(sort: Bool) {
        totalItems?.sort(by: { (item, item2) -> Bool in
            guard let available = item.availableQuantity, let available2 = item2.availableQuantity else {
                return false
            }
            return (sort) ? available < available2 : available > available2
        })
        guard let sortItems = totalItems else {
            return // TODO: logger
        }
        dispatcher.dispatch(.loadItems(sortItems))
    }
    
}

// MARK: networking conection layer
extension SearchListResultActions {
    func setupNetworkingLayer() {
        self.networkingLayer = NetworkingSearchItems(configService: ConfigurationSearchService())
        cancellables = []
    }
    
    func getItemsSavedCategory(categoryId: String) {
        self.networkingLayer.networkingLayerService(text: categoryId).sink(receiveValue: { (items) in
            guard let totalItems = items?.items else {
                return // TODO: Logger
            }
            self.totalItems = totalItems
            self.dispatcher.dispatch(.loadItems(totalItems))
        }).store(in: &cancellables)
    }
}
