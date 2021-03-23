//
//  ConfigurationDetailItem.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import Foundation

class ConfigurationDetailItemService: NetworkConfiguration {
    typealias responseDataType = DetailRootClass
    var provider: Provider = .mock(jsonName: "itemDetail")
}
