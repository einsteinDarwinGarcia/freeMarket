//
//  
//  SearchListResultViewCoordinator.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//
//

import UIKit
import SwiftUI
import Combine


protocol SearchListResultViewCoordinator: Coordinator {} // empty for now

extension SearchListResultViewCoordinator {
    func presentDetailItem(isPresented: Binding<Bool>, itemDetail: ItemsModel) -> some View {
        let coordinator = ItemDetailCoordinator<Self>(isPresented: isPresented, itemDetail: itemDetail)
        return coordinate(to: coordinator)
    }
}

final class SearchListResultCoordinator<P: Coordinator>: SearchListResultViewCoordinator {
   
    private var isPresented: Binding<Bool>
    private var searchedItem: [ItemsModel]?
    private var totalItems:  [ItemsModel]?
    private var categoryId: String?
    
    init(isPresented: Binding<Bool>, searchedItem: [ItemsModel]?, totalItems: [ItemsModel]?, categoryId: String? = nil) {
        self.isPresented = isPresented
        self.searchedItem = searchedItem
        self.totalItems = totalItems
        self.categoryId = categoryId
    }
    
    deinit {
//        print("\(identifier) deinit SearchListResultCoordinator")
    }
    
    @discardableResult
    func start() -> some View {
        let modelStore = SearchListResultModelStore()
        if let categoryId = self.categoryId {
            modelStore.searchItemSaved = categoryId
        }
        let view = SearchListResultFactory.make(with:self,  modelStore: modelStore, searchedItem: self.searchedItem, totalItems: self.totalItems)
        return NavigationLinkWrapper(destination: view, isPresented: isPresented)
    }

}

// MARK: Factory

enum SearchListResultFactory {
    static func make<C: SearchListResultViewCoordinator>(with coordinator: C, modelStore: SearchListResultModelStore, searchedItem: [ItemsModel]?, totalItems: [ItemsModel]?) -> some View {
        let distpatcher = Dispatcher<SearchListResultListActions>()
        let actions = SearchListResultActions(coordinator: coordinator, dispatcher: distpatcher, searchedItem: searchedItem, totalItems: totalItems)
        let view = SearchListResultView(actions: actions, modelStore: modelStore)

        return view
    }
}
