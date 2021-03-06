//
//  RowSearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import SwiftUI

struct RowSearchBar: View {
    
    var title: String
    var saved: Bool?
    
    var body: some View {
        HStack {
            if saved ?? false {
                
                Image(systemName: "square.and.arrow.down")
                    .resizable()
                    .frame(width: 12, height: 15)
                    .foregroundColor(Color.textColor)
                    .padding(10)
                
            } else {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.textColor)
                    .padding(10)
            }
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color.textColor)
                .padding()
        }
    }
}

struct RowSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        RowSearchBar(title: "Iphone")
    }
}
