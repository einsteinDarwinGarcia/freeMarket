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
    
    @ObservedObject var toggleViewModel: ToggleViewModel = ToggleViewModel()
    
    init(actions: A,  modelStore: SearchListResultModelStore) {
        self.store = modelStore
        self.actions = actions
        self.actions.configureViewStore(modelStore: store)
    }

    var body: some View {
            VStack {
                VStack {
                    HStack(alignment:.center) {
                        Text("Ordenar: ")
                            .font(.subheadline)
                            .bold()
                            .frame(width: 100)
                        Toggle("Precio", isOn: $toggleViewModel.priceSort)
                            .toggleStyle(SwitchToggleStyle(tint: .black))
                            .font(.caption)
                            .frame(width:120)
                        Spacer()
                        Toggle("Cantidad", isOn: $toggleViewModel.availableSort)
                            .toggleStyle(SwitchToggleStyle(tint: .black))
                            .font(.caption)
                            
                            .frame(width:120)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.trailing, 20)
                }.background(Color.backgroundPrimary)
                
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
                self.actions.sorted(sort: self.toggleViewModel)
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
