//
//  BannerTrend.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 27/03/21.
//

import SwiftUI

struct BannerTrend: View {
    
    var prediction: PredictiveData?
    
    var body: some View {
        BannerTrendStack(prediction: prediction) { product in
            VStack(alignment: .center) {
               Text("Promociones").font(.title3)
               Text(product).font(.title).bold()
            }.padding()
        }.overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.backgroundPrimary, lineWidth: 1)
        ).background(Color.backgroundClear)
    }
}

struct BannerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Banner Publicitario.").font(.caption)
            Text("Activa promoción según la tendencia de busqueda entre iPhone, Samsung").font(.caption)
            Text("Modelo de Machine Learning").font(.subheadline).bold()
        }
        .frame(width:200)
        .padding()
    }
}

struct BannerTrendStack<view: View>: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var prediction: PredictiveData?
    var response: (String) -> view
    
    
    init(prediction: PredictiveData?, response: @escaping (String) -> view) {
        self.response = response
        self.prediction = prediction
    }
    var body: some View {
        if let prediction = validatePrediction(prediction: prediction) {
            if prediction.iphone.getNumber() > prediction.samsung.getNumber() {
                if sizeClass == .compact {
                    HStack {
                        BannerView()
                        self.response("iPhone")
                    }
                } else {
                    VStack {
                        BannerView()
                        self.response("iPhone")
                    }
                }
                
            } else {
                if sizeClass == .compact {
                    HStack {
                        BannerView()
                        self.response("Samsung")
                    }
                } else {
                    VStack {
                        BannerView()
                        self.response("Samsung")
                    }
                }
            }
        }
    }
}

struct BannerTrend_Previews: PreviewProvider {
    static let predictive = PredictiveData(iphone: .iphone(1), samsung: .samsung(3), totalSearched: 13)
    static var previews: some View {
        BannerTrend(prediction: predictive)
    }
}
