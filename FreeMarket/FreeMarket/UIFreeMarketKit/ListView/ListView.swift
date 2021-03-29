//
//  ListView.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//

import SwiftUI

struct ListView<Element: Hashable, view: View>: View {
    
    var items: [Element]
    var response: (Element) -> view
    
    init(items: [Element], response: @escaping (Element) -> view ) {
        self.items = items
        self.response = response
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(items, id: \.self) { eachItem in
                    response(eachItem)
                }
            }
        }.animation(.linear)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
//        ListView()
        Text("Hola")
    }
}
