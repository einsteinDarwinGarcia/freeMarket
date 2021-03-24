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
    
    func networkingLayerService(text: String) -> Future<CastingModel.FinalData?, Never> {
        return Future<CastingModel.FinalData?, Never> { promise in
            self.networkManager.getCoreDataResult().sink { value in
                return promise(.success(value))
            }.store(in: &self.cancellables)
        }
    }
}
