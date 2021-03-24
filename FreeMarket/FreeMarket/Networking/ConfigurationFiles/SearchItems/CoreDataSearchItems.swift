//
//  CoreDataSearchItems.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 19/03/21.
//

import Combine

final class CoreDataSearchItem: NetworkingLayer {
 
    var configurationService: ConfigurationSearchEntity
    var networkManager: NetworkManager<ConfigurationSearchEntity>
    var castingModel: CastingCoreDataToViewModel
    var cancellables: Set<AnyCancellable>
    
    init() {
        self.configurationService = ConfigurationSearchEntity()
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
