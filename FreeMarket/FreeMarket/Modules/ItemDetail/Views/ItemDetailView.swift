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
    
    @ObservedObject var store: ItemDetailModelStore
    private var actions: A
    
    init(actions: A,  modelStore: ItemDetailModelStore) {
        self.store = modelStore
        self.actions = actions
        self.actions.configureViewStore(modelStore: store)
    }

    var body: some View {
        
        ZStack(alignment: .top) {
            VStack(alignment:.leading) {
                Text(store.itemDetail.condition ?? String())
                    .font(.caption)
                    .padding(.leading, 25)
                Text(store.itemDetail.title ?? String())
                    .font(.title3)
                    .padding(.leading, 25)
                Carousel()
                AttributesSelectView()
                Text("19900000").font(.largeTitle)
                    .padding(.leading, 25)
                
                VStack(alignment: .leading) {
                    RowExtraInfo(image: "creditcard", title: "Paga con Mercado Pago")
                    RowExtraInfo(image: "server.rack", title: "Cantidad \(store.itemDetail.stock ?? 0)")
                    RowExtraInfo(image: "rosette", title: store.itemDetail.warranty ?? String())
                }
               
            }.padding(.top, 150)
            
            SlideOverCard {
                AttributesDetail(attributes: store.itemDetail.attributes)
            }.frame(maxWidth:.infinity)
        }
        .onAppear {
            self.actions.loadData()
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
