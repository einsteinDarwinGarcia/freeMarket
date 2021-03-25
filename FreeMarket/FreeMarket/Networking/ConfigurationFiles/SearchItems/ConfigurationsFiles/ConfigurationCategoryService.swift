//
//  ConfigurationCategoryService.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 25/03/21.
//

import Combine

class ConfigurationCategoryService: NetworkConfiguration {
    typealias responseDataType = RootClass
//    var provider: Provider = .mock(jsonName: "itemSearch")
    var provider: Provider = .APIRest(serviceItem: .categoryItems)
}
