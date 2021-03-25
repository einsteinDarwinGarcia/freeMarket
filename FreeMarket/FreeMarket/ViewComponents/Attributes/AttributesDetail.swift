//
//  AttributesDetail.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import SwiftUI

struct AttributesDetail: View {
    let attributes: [AttributesItem]
    var body: some View {
        VStack {
            LineBar()
                .frame(width: 40, height: 5)
                .padding(.top, 10)
                .padding(.bottom, 10)
            ScrollView {
                ForEach(attributes, id: \.id) { attribute  in
                    RowAttribute(title: attribute.name , value: attribute.value )
                }
            }
        }.background(Color.backgroundClear)
    }
}


