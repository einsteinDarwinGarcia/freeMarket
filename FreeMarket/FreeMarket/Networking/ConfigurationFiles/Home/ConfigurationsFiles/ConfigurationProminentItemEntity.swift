//
//  ConfigurationProminentItemEntity.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 24/03/21.
//

import Foundation

class ConfigurationProminentItemEntity: NetworkConfiguration {
    typealias responseDataType = ItemsModel
    var provider: Provider = .coreData(coreDataPersistence: CoreDataPersistence<ItemDetailHistoryEntity>(typeStorage: CoreDataStore.default))
}
