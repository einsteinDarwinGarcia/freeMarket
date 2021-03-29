//
//  CoreDataProminentItem.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 24/03/21.
//

import Combine

final class CoreDataProminentItem: NetworkingLayer {
    
    var configurationService: ConfigurationProminentItemEntity
    var networkManager: NetworkManager<ConfigurationProminentItemEntity>
    var castingModel: CastingCoreDataToViewModel<ItemsModel>
    var cancellables: Set<AnyCancellable>
    
    init() {
        self.configurationService = ConfigurationProminentItemEntity()
        self.networkManager = NetworkManager(configuration: self.configurationService)
        self.castingModel = CastingCoreDataToViewModel()
        cancellables = []
    }
    
    func networkingLayerService(text: String) -> Future<CastingModel.FinalData?, Error> {
        return Future<CastingModel.FinalData?, Error> { promise in
            self.networkManager.getCoreDataResult().sink { (completion) in
                switch completion {
                case .failure(let error):
                    CLogger.log(category: .parsing).error("error: '\(error.localizedDescription)'")
                    return promise(.failure(error))
                default:
                    break
                }
            } receiveValue: { (value) in
                return promise(.success(value))
            }.store(in: &self.cancellables)
        }
    }
}
