//
//  RowAttribute.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import SwiftUI

struct RowAttribute: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack(alignment:.center) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                Text(value)
                        .font(.caption)
                    .padding()
                Spacer()
            }
        }
        .border(Color.gray, width: 0.4)
       
    }
}

struct RowAttribute_Previews: PreviewProvider {
    static var previews: some View {
        RowAttribute(title: "Marca", value: "iPhone")
    }
}