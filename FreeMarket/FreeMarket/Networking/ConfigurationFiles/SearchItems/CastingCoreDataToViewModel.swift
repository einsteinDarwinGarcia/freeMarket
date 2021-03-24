//
//  CastingCoreDataToViewModel.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 19/03/21.
//

import Combine

class CastingCoreDataToViewModel<T>: CastingToModels {
   
    typealias FinalData = [T]
    typealias BaseClass = [T]
    
    func casting(rootClass: BaseClass?) -> Future<FinalData?, Never> {
        return Future<FinalData?, Never> { promise in
            return promise(.success(rootClass))
        }
    }
    
}
