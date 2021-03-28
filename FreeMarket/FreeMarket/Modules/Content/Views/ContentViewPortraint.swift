//
//  ContentViewPortraint.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 27/03/21.
//

import SwiftUI

struct ContentViewPortraint<view: View>: View {
    var prominent: ItemsModel?
    var prediction: PredictiveData?
    
    var response: (ItemsModel, Binding<Bool>) -> view
    
    init(prediction: PredictiveData?, prominent: ItemsModel?, response: @escaping (ItemsModel, Binding<Bool>) -> view) {
        self.response = response
        self.prediction = prediction
        self.prominent = prominent
    }
    
    var body: some View {
        VStack {
            LineBar().frame(height: 1)
            BannerTrend(prediction: prediction).padding(.top,10)
            
            if let prominent = validateProminentItem(prominent: prominent) {
                NavigationButton(contentView: ProminentItem(item: prominent),
                                 navigationView: { isPresented in
                                    self.response(prominent, isPresented)
                                 })
            }
            Spacer()
            SearchTrend(prediction: prediction)
        }
    }
}
