//
//  
//  SearchListResultView.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//
//

import SwiftUI

struct SearchListResultView<A: SearchListResultActionsProtocol>: View where A.M == SearchListResultModelStore {
    
    @ObservedObject var store: SearchListResultModelStore
    private var actions: A
    
    init(actions: A,  modelStore: SearchListResultModelStore) {
        self.store = modelStore
        self.actions = actions
        self.actions.configureViewStore(modelStore: store)
    }

    var body: some View {
        VStack {
            ListView(items: store.searchedItem) { item  in
                
                HStack {
                    Text(item.title)
                        .padding()
                    Text(item.categoryId ?? "***")
                }
                
                
            }
        }.onAppear{
            print("La RE CONCHA QUE SI ESTOY CARGANDO *******")
            self.actions.combineItems()
        }
    }
}

struct SearchListResultView_Previews: PreviewProvider {
    
    @State static var isActive = false
    static var modelStore = SearchListResultModelStore()
    
    static var previews: some View {
        return SearchListResultFactory.make(with: SearchListResultCoordinator<AppCoordinator>(isPresented: $isActive, searchedItem: [], totalItems: []), modelStore: modelStore, searchedItem: [], totalItems: [])
    }
}