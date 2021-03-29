//
//  ProminentItem.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 24/03/21.
//

import SwiftUI

struct ProminentItem: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var item: ItemsModel
    
    var body: some View {
        if sizeClass == .compact {
            PortraitProminentItem(item: item)
        } else {
            LandscapeProminentItem(item:item)
        }
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
