//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import SwiftUI

struct RowSearchBar: View {
    
    var title: String
    
    var body: some View {
        HStack {
            
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 15, height: 15)
                .padding(10)
            
            Text(title)
                .font(.subheadline)
                .padding()
        }
    }
}

struct RowSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        RowSearchBar(title: "Iphone")
    }
}
