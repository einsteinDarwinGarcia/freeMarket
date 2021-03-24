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
                    AsyncImage(url: validateImage(),
                               placeholder: { Text("Loading ...") },
                               image: { Image(uiImage: $0).resizable() }
                               )
                    .aspectRatio(contentMode: .fit)
                    .frame(idealHeight: 100 / 2 * 3)
                }
                .padding()
                .frame(width: 150)
                 
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
            .background(Color(UIColor.white).shadow(radius: 2))
            
        }
    }
    
    func validateImage() -> URL {
        guard let thumbnail = item?.thumbnail, let url = URL(string: thumbnail) else { return URL(string: "")! }
        return url
    }
}

struct RowListResultImportant_Previews: PreviewProvider {
    static var previews: some View {
        RowListResultImportant()
    }
}
