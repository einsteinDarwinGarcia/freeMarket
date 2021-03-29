//
//  ConfigurationSaveEntity.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 29/03/21.
//

import Foundation

class ConfigurationSaveEntity: NetworkConfiguration {
    typealias responseDataType = ItemSearchModel
    var provider: Provider = .coreData(coreDataPersistence: CoreDataPersistence<ItemSearchEntity>(typeStorage: CoreDataStore.default))
}
