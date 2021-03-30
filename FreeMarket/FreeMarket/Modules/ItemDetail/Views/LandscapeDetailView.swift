//
//  LandscapeDetailView.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 25/03/21.
//

import SwiftUI

struct LandscapeDetailView: View {
    var itemDetail: ItemDetailModel
    @State var position = CardPosition.bottom
    var totalPrice: String
    
    var body: some View {
            ScrollView {
                VStack(alignment:.center) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(itemDetail.condition ?? String())
                                .font(.title3)
                                .foregroundColor(Color.textColor)
                                .padding(.leading, 25)
                            Text(itemDetail.title ?? String())
                                .font(.title)
                                .foregroundColor(Color.textColor)
                                .padding(.leading, 25)
                                .padding(.trailing, 25)
                            
                            Text(totalPrice)
                                .font(.largeTitle)
                                .foregroundColor(Color.textColor)
                                .padding(.leading, 25)
                                .padding(.top, 50)
                            
                            VStack(alignment: .leading) {
                                RowExtraInfo(image: "creditcard", title: Strings.detailViewMercadoPago)
                                RowExtraInfo(image: "server.rack", title: Strings.searchResultCantidad + " \(itemDetail.stock ?? 0)")
                                RowExtraInfo(image: "rosette", title: itemDetail.warranty ?? String())
                            }
                        }.frame(width:300)
                        
                        Carousel(images: itemDetail.photos)
                            .frame(height:310)
                            .padding(.top, 20)
                        
                    }
                        
                            AttributesSelectView()
                                .padding(.top, -35)
                                .padding(.trailing, 5)
                                .padding(.leading, 5)
                            
                            AttributesDetail(attributes: itemDetail.attributes)
                   
                }
        }
    }
}
