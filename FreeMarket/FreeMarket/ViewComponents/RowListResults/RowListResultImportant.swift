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
                    
                }
                .frame(width: 100, height: 120, alignment: .center)
                .padding()
                .background(Color(UIColor.systemGray5))
                
                VStack(alignment: .leading) {
                    Text(item?.title ?? "Product Title ")
                        .font(.subheadline)
                        .padding(.top, 7)
                    Spacer()
                    Text(String(item?.price ?? 0))
                        .font(.title2)
                        .frame(height: 15)
                    Spacer()
                    Text("Envio Gratis")
                        .font(.caption)
                        .frame(height: 15)
                    Spacer()
                    Text("Disponibles \(item?.availableQuantity ?? 0)")
                        .font(.footnote)
                        .frame(height: 15)
                    
                }
                Spacer()
            }
            .frame(height:120 ,alignment: .center)
            .padding()
            .background(Color(UIColor.systemGray6).shadow(radius: 2))
            
        }
        
    }
}

struct RowListResultImportant_Previews: PreviewProvider {
    static var previews: some View {
        RowListResultImportant()
    }
}
