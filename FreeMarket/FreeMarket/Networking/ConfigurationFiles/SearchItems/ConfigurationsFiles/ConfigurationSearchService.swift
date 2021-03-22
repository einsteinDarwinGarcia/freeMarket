//
//  ConfigurationSearchService.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Combine

class ConfigurationSearchService: NetworkConfiguration {
    typealias responseDataType = RootClass
    var provider: Provider = .mock(jsonName: "itemSearch")
}
