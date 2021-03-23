//
//  RowExtraInfo.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import SwiftUI

struct RowExtraInfo: View {
    
    let image: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 12, height: 12)
                .padding(.leading, 25)
            Text(title)
                .font(.caption)
        }.padding(.top, -5)
    }
}

struct RowExtraInfo_Previews: PreviewProvider {
    static var previews: some View {
        RowExtraInfo(image: "rosette", title: "garantia")
    }
}
