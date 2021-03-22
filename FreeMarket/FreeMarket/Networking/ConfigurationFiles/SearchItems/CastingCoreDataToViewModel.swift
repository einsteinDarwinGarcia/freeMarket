//
//  CastingCoreDataToViewModel.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 19/03/21.
//

import Combine

class CastingCoreDataToViewModel: CastingToModels {
   
    typealias FinalData = [ItemSearchModel]
    typealias BaseClass = [ItemSearchModel]
    
    var itemCasted = CurrentValueSubject<FinalData?, Never>(nil)
    
    func casting(rootClass: BaseClass?) {
        itemCasted.value = rootClass
    }
    
}
