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
    func presentSomewhere(isPresented: Binding<Bool>) -> some View {
        let coordinator = SearchListResultCoordinator<Self>(isPresented: isPresented, searchedItem: [], totalItems: [])
        return coordinate(to: coordinator)
    }
}

final class SearchListResultCoordinator<P: Coordinator>: SearchListResultViewCoordinator {
   
    private var isPresented: Binding<Bool>
    private var searchedItem: [ItemsModel]?
    private var totalItems:  [ItemsModel]?
    
    init(isPresented: Binding<Bool>, searchedItem: [ItemsModel]?, totalItems: [ItemsModel]?) {
        self.isPresented = isPresented
        self.searchedItem = searchedItem
        self.totalItems = totalItems
    }
    
    deinit {
//        print("\(identifier) deinit SearchListResultCoordinator")
    }
    
    @discardableResult
    func start() -> some View {
        let modelStore = SearchListResultModelStore()
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
