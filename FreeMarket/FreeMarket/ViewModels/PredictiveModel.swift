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
    case cars(Int?)
    case mobiles(Int?)
    case meat(Int?)
    
    func getValue() -> String {
        switch self {
        case .cars:
            return "cars"
        case .mobiles:
            return "mobiles"
        default:
            return "meat"
        }
    }
    
    func getData(total: Int) -> String {
        switch self {
        case .cars(let val):
            return "Vehiculos: \(val ?? 0)"
        case .mobiles(let val):
            return "Celularres: \(val ?? 0)"
        case .meat(let val):
            return "Asadores: \(val ?? 0)"
        }
    }
}

struct PredictiveData {
    let cars: CategoriesPredictive
    let mobiles: CategoriesPredictive
    let meat: CategoriesPredictive
    
    let totalSearched: Int
}
