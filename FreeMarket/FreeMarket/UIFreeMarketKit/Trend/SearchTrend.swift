//
//  SearchTrend.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 27/03/21.
//

import SwiftUI

struct SearchTrend: View {
    var prediction: PredictiveData?
    var body: some View {
        HStack {
            Text("Tendencias de Busqueda").font(.caption).bold().padding()
            Spacer()
            if let prediction = validatePrediction(prediction: prediction) {
                Text(prediction.iphone.getData(total: prediction.totalSearched)).font(.caption).padding()
                Text(prediction.samsung.getData(total: prediction.totalSearched)).font(.caption).padding()
            }
        }
        .background(Color.backgroundPrimary)
    }
}

struct SearchTrend_Previews: PreviewProvider {
    static var previews: some View {
        SearchTrend()
    }
}
