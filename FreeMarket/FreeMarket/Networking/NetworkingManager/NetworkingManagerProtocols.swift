//
//  NetworkingManagerProtocols.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//

import Combine
import CoreData

protocol CoreDataEntity {
   associatedtype CoreDataEntity
}

enum Provider {
    case mock(jsonName: String)
    case APIRest(serviceItem: ServiceItem)
    case coreData(coreDataPersistence: Persistence)
}

protocol NetworkConfiguration {
    associatedtype responseDataType: Decodable
    var provider: Provider { get set }
}

protocol CastingToModels {
    associatedtype FinalData
    associatedtype BaseClass
    func casting(rootClass: BaseClass?) -> Future<FinalData?, Never>
}

protocol NetworkingLayer {
//     where CastingModel.BaseClass == NetworkingConfiguration.responseDataType
    associatedtype NetworkingConfiguration: NetworkConfiguration
    associatedtype CastingModel: CastingToModels
    
    var configurationService: NetworkingConfiguration { get set }
    var networkManager: NetworkManager<NetworkingConfiguration> { get set }
    var castingModel: CastingModel  { get set }
    var cancellables: Set<AnyCancellable> { get set}
    
    func networkingLayerService(text: String) -> Future<CastingModel.FinalData?, Never>
}
