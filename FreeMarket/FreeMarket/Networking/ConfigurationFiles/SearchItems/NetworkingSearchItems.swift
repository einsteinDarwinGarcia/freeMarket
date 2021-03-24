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
    
    func networkingLayerService(text: String) -> Future<SearchingModel?, Never> {
        return Future<SearchingModel?, Never> { [weak self, castingModel] promise in
            guard let strongSelf = self else {
                return promise(.success(nil)) // TODO: Logger manage error
            }
            strongSelf.networkManager.getData(text:text).sink {  (response) in
                castingModel.casting(rootClass: response).sink { value in
                    return promise(.success(value))
                }.store(in: &strongSelf.cancellables)
            }.store(in: &strongSelf.cancellables)
        }
    }
    
}
