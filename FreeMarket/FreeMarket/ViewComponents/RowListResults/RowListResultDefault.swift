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
                    AsyncImage(url: validateImage(),
                               placeholder: { Text("Loading ...") },
                               image: { Image(uiImage: $0).resizable() }
                               )
                    .aspectRatio(contentMode: .fit)
                    .frame(idealHeight: 100 / 2 * 3)
                }.frame(width: 150)
                
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
                    if item?.freeChipping != nil {
                        Text("Envio Gratis")
                            .font(.caption)
                            .frame(height: 15)
                    }
                    if let available = item?.availableQuantity {
                        Text("Disponibles \(available)")
                            .font(.footnote)
                            .frame(height: 15)
                    }
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
    
    func validateImage() -> URL {
        guard let thumbnail = item?.thumbnail, let url = URL(string: thumbnail) else { return URL(string: "")! }
        return url
    }
}

struct RowListResultDefault_Previews: PreviewProvider {
    static var previews: some View {
        RowListResultDefault()
    }
}
