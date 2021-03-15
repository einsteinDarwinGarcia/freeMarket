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
    func login()
    func goToSomewhere(isPresented: Binding<Bool>) -> V
}

enum ContentListActions: ListActions {
    case isLoggedOut(Bool)
    
    func setCategoryToCLog() -> Category {
        .login
    }
}

class ContentActions<C: ContentViewCoordinator, D: FluxDispatcher>:  Action<C>, ContentActionsProtocol where D.L == ContentListActions {
    
    private let dispatcher: D
    
    private var contentViewStore: AnyObject?
    
    init(coordinator: C, dispatcher: D) {
        self.dispatcher = dispatcher
        super.init(coordinator: coordinator)
    }
    
    func configureViewStore(modelStore: ContentModelStore) {
        self.contentViewStore = ContentViewStore(dispatcher: self.dispatcher, modelStore: modelStore)
    }
    
    func login() {
        self.dispatcher.dispatch(.isLoggedOut(true))
    }
    
    func goToSomewhere(isPresented: Binding<Bool>) -> some View {
        return coordinator?.presentSomewhere(isPresented: isPresented)
    }
}
