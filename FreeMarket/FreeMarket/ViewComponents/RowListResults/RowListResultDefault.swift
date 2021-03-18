//
//  RowListResultDefault.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 18/03/21.
//

import SwiftUI

struct RowListResultDefault: View {
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
                    Text(item?.title ?? "Product Title")
                        .font(.subheadline)
                        .padding(.top, 7)
                        .padding(.bottom, 7)
                    
                    Spacer()
                    Text(String(item?.price ?? 0))
                        .font(.title2)
                        .frame(height: 15)
                    Spacer()
                    Text("Envio Gratis")
                        .font(.caption)
                        .frame(height: 15)
                    Text("Disponibles \(item?.availableQuantity ?? 0)")
                        .font(.footnote)
                        .frame(height: 15)
                    
                }
                Spacer()
            }
            .frame(height: 120, alignment: .center)
            .padding()
            LineBar()
                .frame(height: 1)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 0)
        }
    }
}

struct RowListResultDefault_Previews: PreviewProvider {
    static var previews: some View {
        RowListResultDefault()
    }
}
