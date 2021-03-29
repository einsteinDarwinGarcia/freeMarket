//
//  LineBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 18/03/21.
//

import SwiftUI

struct LineBar: View {
    var body: some View {
            GeometryReader { geometry in
                ZStack {
                           Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                               .opacity(0.3)
                            .foregroundColor(Color.backgroundSecondary)
                       }.cornerRadius(45.0)
                }
    }
}

struct LineBar_Previews: PreviewProvider {
    static var previews: some View {
        LineBar()
    }
}
