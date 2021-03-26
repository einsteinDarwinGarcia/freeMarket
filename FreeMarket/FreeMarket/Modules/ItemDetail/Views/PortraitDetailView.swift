//
//  PortraitDetailView.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 25/03/21.
//

import SwiftUI

struct PortraitDetailView: View {
    
    var itemDetail: ItemDetailModel
    
    @State var position = CardPosition.bottom
    
    var totalPrice: String
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment:.leading) {
                    Text(itemDetail.condition ?? String())
                        .font(.caption)
                        .foregroundColor(Color.textColor)
                        .padding(.leading, 25)
                    Text(itemDetail.title ?? String())
                        .font(.title3)
                        .foregroundColor(Color.textColor)
                        .padding(.leading, 25)
                        .padding(.trailing, 25)
                    
                    Carousel(images: itemDetail.photos)
                   
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
                        RowExtraInfo(image: "server.rack", title: "Cantidad \(itemDetail.stock ?? 0)")
                        RowExtraInfo(image: "rosette", title: itemDetail.warranty ?? String())
                    }
                    
                }.padding(.top, 100)
                .padding(.bottom, 200)
            }
            
            SlideOverCard(position: $position) {
                AttributesDetail(attributes: itemDetail.attributes)
            }.frame(maxWidth:.infinity)
        }
    }
}
