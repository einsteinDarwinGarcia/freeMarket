//
//  
//  ItemDetailView.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//
//

import SwiftUI

struct ItemDetailView<A: ItemDetailActionsProtocol>: View where A.M == ItemDetailModelStore {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @ObservedObject var store: ItemDetailModelStore
    private var actions: A
    
    @State var position = CardPosition.bottom
    
    var totalPrice: String {
    
        let formatter = NumberFormatter()
        formatter.currencySymbol = "$"
        formatter.numberStyle = .currency

        let total = Double(store.itemDetail.price ?? 0.0)

        return formatter.string(from: NSNumber(value: total )) ?? "$0"
    }
    
    init(actions: A,  modelStore: ItemDetailModelStore) {
        self.store = modelStore
        self.actions = actions
        self.actions.configureViewStore(modelStore: store)
    }

    var body: some View {
        if sizeClass == .compact {
            PortraitDetailView(itemDetail: store.itemDetail, position: position, totalPrice: totalPrice)
                .onAppear {
                self.actions.loadData()
            }
        } else {
       
            LandscapeDetailView(itemDetail: store.itemDetail, position: position, totalPrice: totalPrice)
                .onAppear {
                self.actions.loadData()
            }
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    
    @State static var isActive = false
    static var modelStore = ItemDetailModelStore()
    static var itemDetail = ItemsModel(id: "", siteId: "COadadsf", categoryId: "asdfasd", title: "iphone", price: 1900000, availableQuantity: 4, thumbnail:"", cityName: "Bogotá", freeChipping: true, model: "iPhone 7", attributes: nil, important: true)
    
    static var previews: some View {
        return ItemDetailFactory.make(with: ItemDetailCoordinator<AppCoordinator>(isPresented:$isActive, itemDetail: itemDetail), modelStore: modelStore, itemDetail: itemDetail)
    }
}
