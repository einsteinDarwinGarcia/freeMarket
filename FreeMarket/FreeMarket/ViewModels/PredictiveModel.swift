//
//  PredictiveModel.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 26/03/21.
//

import Foundation

struct ItemPredictiveModel: Hashable, Decodable {
    let category: String
}

enum CategoriesPredictive {
    case iphone(Int?)
    case samsung(Int?)
    
    func getValue() -> String {
        switch self {
        case .iphone:
            return "iphone"
        case .samsung:
            return "samsung"
        }
    }
    
    func getData(total: Int) -> String {
        switch self {
        case .iphone(let val):
            guard let value = val else {
                return String()
            }
            return "iPhones: \(value * 100 / total)%"
        case .samsung(let val):
            guard let value = val else {
                return String()
            }
            return "Samsungs: \(value * 100 / total)%"
       
        }
    }
    
    func getNumber() -> Int {
        switch self {
        case .iphone(let val):
            return val ?? 0
        case .samsung(let val):
            return val ?? 0
        }
    }
}

struct PredictiveData {
    let iphone: CategoriesPredictive
    let samsung: CategoriesPredictive
    
    let totalSearched: Int
}
