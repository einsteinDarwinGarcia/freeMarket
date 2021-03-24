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
    func goToItemDetail(isPresented: Binding<Bool>, item: ItemsModel) -> V
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
    
    var cancellables: [AnyCancellable] = []
    
    lazy var coreDataStore: CoreDataStoring = {
        return CoreDataStore.default
    }()
    
    init(coordinator: C, dispatcher: D, searchedItem: [ItemsModel]?, totalItems: [ItemsModel]?) {
        self.dispatcher = dispatcher
        self.searchedItem = searchedItem
        self.totalItems = totalItems
        
        super.init(coordinator: coordinator)
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
}
