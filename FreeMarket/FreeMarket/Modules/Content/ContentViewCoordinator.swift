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
    func presentSomewhere(isPresented: Binding<Bool>) -> some View {
        // send to true view
        let coordinator = ContentCoordinator<Self>(isPresented: isPresented)
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
