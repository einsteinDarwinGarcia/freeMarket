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
    
    func networkingLayerService() -> Future<ItemDetailModel?, Never> {
        return Future<ItemDetailModel?, Never> { [castingModel] promise in
            self.networkManager.getData().sink {  (response) in
                castingModel.casting(rootClass: response)
            }.store(in: &self.cancellables)
            
            castingModel.itemCasted.sink { (items) in
                return promise(.success(items))
            }.store(in: &self.cancellables)
        }
    }
    
}
