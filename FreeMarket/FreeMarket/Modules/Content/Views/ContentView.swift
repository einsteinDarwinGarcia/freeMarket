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
    
   
    private var actions: A
    
    init(actions: A,  modelStore: ContentModelStore) {
        self.store = modelStore
        self.actions = actions
        self.actions.configureViewStore(modelStore: store)
    }
    
    var body: some View {
        NavigationView {
            Group {
                ZStack {
                    if searchBar.beginEditing {
                        
                        ListView(items: store.items.lazy.filter {
                            searchBar.text.isEmpty ||
                                $0.id.localizedStandardContains(searchBar.text)
                        }) { item  in
                            NavigationButton(contentView: RowSearchBar(title: item.id, saved: item.saved),
                                             navigationView: { isPresented in
                                                self.actions.presentListResult(isPresented: isPresented, itemSelected: item)
                            })
                        }
                    } else {
                        Text("Hello, world!")
                            .padding()
                    }
                    
                }
                .add(self.searchBar)
                .navigationBarTitleDisplayMode(.inline)
            }
        }.onAppear {
            actions.initSearchBar(searchBar: searchBar)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    
    @State static var isActive = false
    static var modelStore = ContentModelStore()
    
    static var previews: some View {
        return ContentFactory.make(with: ContentCoordinator<AppCoordinator>(isPresented:$isActive), modelStore: modelStore)
    }
}
