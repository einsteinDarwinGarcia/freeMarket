//
//  RowListResultImportant.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 18/03/21.
//

import SwiftUI

struct RowListResultImportant: View {
    
    var item: ItemsModel?
    
    var body: some View {
        VStack {
            HStack(alignment:.top) {
                VStack {
                    AsyncImage(url: validateImage(item: item),
                               placeholder: { Text(Strings.loading) },
                               image: { Image(uiImage: $0).resizable() }
                               )
                    .aspectRatio(contentMode: .fit)
                    .frame(idealHeight: 100 / 2 * 3)
                }
                .padding()
                .frame(width: 150)
                 
                VStack(alignment: .leading) {
                    ItemTitle(text: item?.title ?? "")
                    Spacer()
                    ItemPrice(price: item?.price ?? 0)
                    Spacer()
                    
                    if item?.freeChipping ?? false {
                        Text(Strings.searchResultEnvioGratis)
                            .font(.caption)
                            .frame(height: 15)
                        Spacer()
                    }
                    
                    Text(Strings.searchRresultDisponibles + " \(item?.availableQuantity ?? 0)")
                        .font(.footnote)
                        .frame(height: 15)
                    
                }
                Spacer()
            }
            .frame(height:120 ,alignment: .center)
            .padding()
            .background(Color.backgroundClear.shadow(radius: 2))
            
        }
    }
}

struct RowListResultImportant_Previews: PreviewProvider {
    static var previews: some View {
        RowListResultImportant()
    }
}
