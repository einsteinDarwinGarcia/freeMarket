//
//  NetworkingSearchItems.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//

import Combine

final class NetworkingSearchItems: NetworkingLayer {
 
    var configurationService: ConfigurationSearchService
    var networkManager: NetworkManager<ConfigurationSearchService>
    var castingModel: CastingToSearchViewModels
    var cancellables: Set<AnyCancellable>
    
    init() {
        self.configurationService = ConfigurationSearchService()
        self.networkManager = NetworkManager(configuration: self.configurationService)
        self.castingModel = CastingToSearchViewModels()
        cancellables = []
    }
    
    func networkingLayerService() -> Future<SearchingModel?, Never> {
        return Future<SearchingModel?, Never> { [castingModel] promise in
            self.networkManager.getData().sink {  (response) in
                castingModel.casting(rootClass: response)
            }.store(in: &self.cancellables)
            
            castingModel.itemCasted.sink { (items) in
                return promise(.success(items))
            }.store(in: &self.cancellables)
        }
    }
    
}
