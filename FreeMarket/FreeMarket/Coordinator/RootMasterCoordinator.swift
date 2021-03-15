//
//  RootMasterCoordinator.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import UIKit
import SwiftUI
import Combine


final class RootMasterCoordinator<P: Coordinator>: ContentViewCoordinator {
    
    private weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() -> some View {
        let modelStore = ContentModelStore()
        let view = ContentFactory.make(with:self,  modelStore: modelStore)
        let hosting = UIHostingController(rootView: view)
        window?.rootViewController = hosting
        window?.makeKeyAndVisible()
        return EmptyView()
    }
    
}
