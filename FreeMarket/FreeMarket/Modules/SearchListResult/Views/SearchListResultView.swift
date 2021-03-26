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
                Divider()
                Group {
                    ListView(items: store.searchedItem) { item  in
                        NavigationButton(contentView: RowListResults(item: item),
                                         navigationView: { isPresented in
                                            self.actions.goToItemDetail(isPresented: isPresented, item: item)
                        })
                    }
                    .navigationTitle("Resultados")
                }
            }.onAppear{
                validateService()
            }
            
    }
    
    func validateService() {
        guard let itemsSaved = store.searchItemSaved else {
            self.actions.combineItems()
            return
        }
        self.actions.getItemsSavedCategory(categoryId: itemsSaved)
    }
    
   
}

struct SearchListResultView_Previews: PreviewProvider {
    
    @State static var isActive = false
    static var modelStore = SearchListResultModelStore()
    
    static var previews: some View {
        return SearchListResultFactory.make(with: SearchListResultCoordinator<AppCoordinator>(isPresented: $isActive, searchedItem: [], totalItems: []), modelStore: modelStore, searchedItem: [], totalItems: [])
    }
}
