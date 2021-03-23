//
//  
//  ItemDetailViewCoordinator.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//
//

import UIKit
import SwiftUI
import Combine


protocol ItemDetailViewCoordinator: Coordinator {} // empty for now

extension ItemDetailViewCoordinator {
    
}

final class ItemDetailCoordinator<P: Coordinator>: ItemDetailViewCoordinator {
   
    private var isPresented: Binding<Bool>
    private var itemDetail: ItemsModel
    
    init(isPresented: Binding<Bool>, itemDetail: ItemsModel ) {
        self.isPresented = isPresented
        self.itemDetail = itemDetail
    }
    
    deinit {
        print("\(identifier) deinit ItemDetailCoordinator")
    }
    
    @discardableResult
    func start() -> some View {
        let modelStore = ItemDetailModelStore()
        let view = ItemDetailFactory.make(with:self,  modelStore: modelStore, itemDetail: self.itemDetail)
        return NavigationLinkWrapper(destination: view, isPresented: isPresented)
    }

}

// MARK: Factory

enum ItemDetailFactory {
    static func make<C: ItemDetailViewCoordinator>(with coordinator: C, modelStore: ItemDetailModelStore, itemDetail: ItemsModel) -> some View {
        let distpatcher = Dispatcher<ItemDetailListActions>()
        let actions = ItemDetailActions(coordinator: coordinator, dispatcher: distpatcher, itemDetail: itemDetail)
        let view = ItemDetailView(actions: actions, modelStore: modelStore)

        return view
    }
}
