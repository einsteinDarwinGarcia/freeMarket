//
//  CoreDataPredictiveSearching.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 26/03/21.
//

import Combine

final class CoreDataPredictiveSearching: NetworkingLayer {
    
    var configurationService: ConfigurationPredictiveEntity
    var networkManager: NetworkManager<ConfigurationPredictiveEntity>
    var castingModel: CastingCoreDataToViewModel<ItemPredictiveModel>
    var cancellables: Set<AnyCancellable>
    
    init() {
        self.configurationService = ConfigurationPredictiveEntity()
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
