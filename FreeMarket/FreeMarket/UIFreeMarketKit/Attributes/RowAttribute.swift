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
        VStack(alignment:.trailing) {
            HStack(alignment:.center) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding()
                    .frame(width:200)
                Spacer()
                
                    Text(value)
                            .font(.caption)
                            .foregroundColor(Color.textColor)
                        .padding()
                        .frame(width:200)
                    Spacer()
                
            }.background(Color.background)
        }
        .border(Color.backgroundSecondary, width: 0.4)
       
    }
}

struct RowAttribute_Previews: PreviewProvider {
    static var previews: some View {
        RowAttribute(title: "Marca", value: "iPhone")
    }
}
