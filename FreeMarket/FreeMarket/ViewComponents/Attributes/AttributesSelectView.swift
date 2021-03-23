//
//  AttributesView.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import SwiftUI

struct AttributesSelectView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Caracteristicas")
                    .padding()
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 10, height: 15)
                    .padding()
            }
            .background(Color.gray)
            .cornerRadius(10)
        }.padding()
    }
}

struct AttributesView_Previews: PreviewProvider {
    static var previews: some View {
        AttributesSelectView()
    }
}
