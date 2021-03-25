//
//  
//  ContentViewCoordinator.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//
//

import UIKit
import SwiftUI
import Combine


protocol ContentViewCoordinator: Coordinator {} // empty for now

extension ContentViewCoordinator {
    func presentListResult(isPresented: Binding<Bool>, itemSelected: [ItemsModel]?, totalItems: [ItemsModel]?) -> some View {
        let coordinator = SearchListResultCoordinator<Self>(isPresented: isPresented, searchedItem: itemSelected, totalItems: totalItems)
        return coordinate(to: coordinator)
    }
    
    func presentItemsSaved(isPresented: Binding<Bool>, categoryId: String) -> some View {
        let coordinator = SearchListResultCoordinator<Self>(isPresented: isPresented, searchedItem: nil, totalItems: nil, categoryId: categoryId)
        return coordinate(to: coordinator)
    }
}

final class ContentCoordinator<P: Coordinator>: ContentViewCoordinator {
   
    private var isPresented: Binding<Bool>
    
    init(isPresented: Binding<Bool>) {
        self.isPresented = isPresented
    }
    
    deinit {
        print("\(identifier) deinit ContentCoordinator")
    }
    
    @discardableResult
    func start() -> some View {
        let modelStore = ContentModelStore()
        let view = ContentFactory.make(with:self,  modelStore: modelStore)
        return view
    }

}

// MARK: Factory

enum ContentFactory {
    static func make<C: ContentViewCoordinator>(with coordinator: C, modelStore: ContentModelStore) -> some View {
        let distpatcher = Dispatcher<ContentListActions>()
        let actions = ContentActions(coordinator: coordinator, dispatcher: distpatcher)
        let view = ContentView(actions: actions, modelStore: modelStore)
        return view
    }
}
