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
        
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment:.leading) {
                    Text(store.itemDetail.condition ?? String())
                        .font(.caption)
                        .foregroundColor(Color.textColor)
                        .padding(.leading, 25)
                    Text(store.itemDetail.title ?? String())
                        .font(.title3)
                        .foregroundColor(Color.textColor)
                        .padding(.leading, 25)
                        .padding(.trailing, 25)
                    
                    Carousel(images: store.itemDetail.photos)
                   
                    AttributesSelectView()
                        .gesture(
                            TapGesture().onEnded{
                                position = CardPosition.middle
                            }
                        ).padding(.top, -35)
                        .padding(.trailing, 5)
                        .padding(.leading, 5)
                    
                    Text(totalPrice)
                        .font(.largeTitle)
                        .foregroundColor(Color.textColor)
                        .padding(.leading, 25)
                    
                    VStack(alignment: .leading) {
                        RowExtraInfo(image: "creditcard", title: "Paga con Mercado Pago")
                        RowExtraInfo(image: "server.rack", title: "Cantidad \(store.itemDetail.stock ?? 0)")
                        RowExtraInfo(image: "rosette", title: store.itemDetail.warranty ?? String())
                    }
                    
                }.padding(.top, 100)
                .padding(.bottom, 200)
            }
            
            SlideOverCard(position: $position) {
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
