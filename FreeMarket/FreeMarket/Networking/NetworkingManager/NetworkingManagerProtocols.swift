//
//  NetworkingManagerProtocols.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//

import Combine

enum Provider {
    case mock(jsonName: String)
    case APIRest
    case coreData
}

protocol NetworkConfiguration {
    associatedtype responseDataType: Decodable
    var provider: Provider { get set }
    var networkResponse: CurrentValueSubject<responseDataType?, Never> { get set }
}

protocol CastingToModels {
    associatedtype T
    associatedtype BC
    var itemCasted: CurrentValueSubject<T?, Never> { get set }
    func casting(rootClass: BC?)
}

protocol NetworkingLayer {
    associatedtype NC: NetworkConfiguration where CM.BC == NC.responseDataType
    associatedtype CM: CastingToModels
    var configurationService: NC { get set }
    var networkManager: NetworkManager<NC> { get set }
    var castingModel: CM  { get set }
    var cancellables: Set<AnyCancellable> { get set}
    
    func networkingLayerService() -> Future<CM.T?, Never>
}
