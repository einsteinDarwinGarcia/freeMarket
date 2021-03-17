//
//  
//  ContentView.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//
//

import SwiftUI
import Combine

struct ContentView<A: ContentActionsProtocol>: View where A.M == ContentModelStore {
    
    @ObservedObject var store: ContentModelStore
    @ObservedObject var searchBar: SearchBar = SearchBar()
    private var cancellable: AnyCancellable?
   
    private var actions: A
    
    init(actions: A,  modelStore: ContentModelStore) {
        self.store = modelStore
        self.actions = actions
        self.actions.configureViewStore(modelStore: store)
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        
        NavigationView {
            Group {
                ZStack {
                    
                    if searchBar.beginEditing {
                        
                        ScrollView {
                            
                            LazyVStack(alignment: .leading) {
                                ForEach(store.items.lazy.filter {
                                    searchBar.text.isEmpty ||
                                        $0.id.localizedStandardContains(searchBar.text)
                                }) { eachItem in
                                    RowSearchBar(title: eachItem.id)
                                }
                            }
                            
                        }.animation(.linear)
                        
                        
                    } else {
                        Text("Hello, world!")
                            .padding()
                    }
                    
                }
                .add(self.searchBar)
                .navigationBarTitleDisplayMode(.inline)
            }
        }.onAppear {
            triggerSearchService()
        }
    }
    
    private func triggerSearchService() {
        actions.loadData(text: searchBar.activeSearchService.eraseToAnyPublisher())
    }
    
}


struct ContentView_Previews: PreviewProvider {
    
    @State static var isActive = false
    static var modelStore = ContentModelStore()
    
    static var previews: some View {
        return ContentFactory.make(with: ContentCoordinator<AppCoordinator>(isPresented:$isActive), modelStore: modelStore)
    }
}
