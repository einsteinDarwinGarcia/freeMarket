//
//  ConfigurationPredictiveEntity.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 26/03/21.
//

import Foundation


class ConfigurationPredictiveEntity: NetworkConfiguration {
    typealias responseDataType = ItemPredictiveModel
    var provider: Provider = .coreData(coreDataPersistence: CoreDataPersistence<ItemPredictionEntity>(typeStorage: CoreDataStore.default))
}
