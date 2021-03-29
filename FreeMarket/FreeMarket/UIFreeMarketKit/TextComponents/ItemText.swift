//
//  ItemTitle.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 24/03/21.
//

import SwiftUI

struct ItemTitle: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.subheadline)
            .foregroundColor(Color.textColor)
            .padding(.top, 7)
    }
}

struct ItemPrice: View {
    
    var totalPrice: String {
    
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"

        let total = Double(price)

        return formatter.string(from: NSNumber(value: total )) ?? "$0"
    }
    
    var price: Double
    
    var body: some View {
        Text(totalPrice)
            .font(.title2)
            .foregroundColor(Color.textColor)
            .frame(height: 15)
    }
}

struct ItemTitle_Previews: PreviewProvider {
    static var previews: some View {
        ItemTitle(text: "iPhone")
    }
}
