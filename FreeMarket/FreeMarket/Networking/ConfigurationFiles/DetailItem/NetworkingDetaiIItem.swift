//
//  NetworkingDetaiIItem.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import Combine

final class NetworkingDetailItems: NetworkingLayer {
    
    var configurationService: ConfigurationDetailItemService
    var networkManager: NetworkManager<ConfigurationDetailItemService>
    var castingModel: CastingToItemDetailModels
    var cancellables: Set<AnyCancellable>
    
    init() {
        self.configurationService = ConfigurationDetailItemService()
        self.networkManager = NetworkManager(configuration: self.configurationService)
        self.castingModel = CastingToItemDetailModels()
        cancellables = []
    }
    
    func networkingLayerService(text: String) -> Future<ItemDetailModel?, Never> {
        return Future<ItemDetailModel?, Never> { [weak self, castingModel] promise in
            guard let strongSelf = self else {
                return promise(.success(nil)) // TODO: Logger manage error
            }
            strongSelf.networkManager.getData(text:text).sink {  (response) in
                castingModel.casting(rootClass: response?.first).sink { value in
                    return promise(.success(value))
                }.store(in: &strongSelf.cancellables)
            }.store(in: &strongSelf.cancellables)
        }
    }
    
}
