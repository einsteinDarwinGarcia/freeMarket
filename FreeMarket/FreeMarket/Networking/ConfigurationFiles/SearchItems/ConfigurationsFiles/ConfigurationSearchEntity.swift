//
//  ConfigurationSearchEntity.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 19/03/21.
//

import Foundation

class ConfigurationSearchEntity: NetworkConfiguration {
    typealias responseDataType = ItemSearchModel
    var provider: Provider = .coreData(coreDataPersistence: CoreDataPersistence<ItemSearchEntity>())
}
