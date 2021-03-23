//
//  RowListResults.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 18/03/21.
//

import SwiftUI

struct RowListResults: View {
    
    var item: ItemsModel
    
    var body: some View {
        if item.important {
            RowListResultImportant(item: item)
        } else {
            RowListResultDefault(item: item)
        }
    }
}

struct RowListResults_Previews: PreviewProvider {
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
                          important: true)
    
    static let item2 = ItemsModel(id: "wertwert",
                          siteId: "CO",
                          categoryId: "8758",
                          title: "iPhone 11 128 Gb Verde iPhone 11 128 Gb Verde iPhone 11 128 Gb Verde iPhone 11 128 Gb Verde ",
                          price: 2700000,
                          availableQuantity: 12,
                          thumbnail: "",
                          cityName: "Barranquilla",
                          freeChipping: true,
                          model: "iPhone 11",
                          attributes: nil,
                          important: false)
    
    static var previews: some View {
        VStack {
            RowListResults(item: item)
            RowListResults(item: item)
            RowListResults(item: item2)
            RowListResults(item: item2)
        }
    }
}
