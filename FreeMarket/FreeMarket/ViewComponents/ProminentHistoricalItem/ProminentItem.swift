//
//  ProminentItem.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 24/03/21.
//

import SwiftUI

struct ProminentItem: View {
    
    var item: ItemsModel
    
    var body: some View {
        
        VStack {
            VStack {
                HStack() {
                    Text("Visto Recientemente")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(Color.textColor)
                        .padding(.leading, 20)
                    Spacer()
                }
                LineBar().frame(height:1)
                
                VStack {
                    AsyncImage(url: validateImage(),
                               placeholder: { Text("Loading ...") },
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
                    LineBar().frame(height:1)
                }
                
                HStack {
                    Text("Ver historial de navegacion")
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
    }
    
    func validateImage() -> URL {
        guard let thumbnail = item.thumbnail, let url = URL(string: thumbnail) else { return URL(string: "")! }
        return url
    }
}

struct ProminentItem_Previews: PreviewProvider {
    static let item = ItemsModel(id: "asdffasd",
                          siteId: "CO",
                          categoryId: "8758",
                          title: "iPhone 11 128 Gb Verde ",
                          price: 2700000,
                          availableQuantity: 12,
                          thumbnail: "",
                          cityName: "Barranquilla",
                          freeChipping: true,
                          model: "iPhone 11",
                          attributes: nil,
                          important: false)
    static var previews: some View {
        ProminentItem(item: item)
    }
}
