//
//  LandscapeProminentItem.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 25/03/21.
//

import SwiftUI

struct LandscapeProminentItem: View {
    var item: ItemsModel
    
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                HStack() {
                    Text(Strings.prominentItemVistas)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(Color.textColor)
                        .padding(.leading, 20)
                    Spacer()
                }
                LineBar().frame(height:1)
                HStack {
                    VStack {
                        AsyncImage(url: validateImage(item: item),
                                   placeholder: { Text(Strings.loading) },
                                   image: { Image(uiImage: $0).resizable() }
                        )
                        .aspectRatio(contentMode: .fit)
                        .frame(idealHeight: 100 / 2 * 3)
                    }
                    .padding()
                    .frame(width: 200)
                    
                    VStack(alignment:.leading) {
                        ItemTitle(text: item.title)
                        ItemPrice(price: item.price ?? 0).padding(.top, 5)
                        
                    }
                    
                }
                LineBar().frame(height:1)
                HStack {
                    Text(Strings.prominentItemHistorial)
                        .font(.footnote)
                        .foregroundColor(Color.textColor)
                        .padding(.leading, 20)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 10, height: 15)
                        .foregroundColor(Color.backgroundSecondary)
                        .padding(10)
                }
                .padding(.bottom, -10)
                .padding(.top, -5)
                
            }.padding()
            
        }
        .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.backgroundPrimary, lineWidth: 1)
                )
        
        .padding()
        .frame(width: 500)
    }
}

