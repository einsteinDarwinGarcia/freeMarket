//
//  NetworkingDetaiIItem.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//

import Combine

final class NetworkingDetailItems<C:NetworkConfiguration>: NetworkingLayer {
    
    var configurationService: C
    var networkManager: NetworkManager<C>
    var castingModel: CastingToItemDetailModels
    var cancellables: Set<AnyCancellable>
    
    init(configService: C) {
        self.configurationService = configService
        self.networkManager = NetworkManager(configuration: self.configurationService)
        self.castingModel = CastingToItemDetailModels()
        cancellables = []
    }
    
    func networkingLayerService(text: String) -> Future<ItemDetailModel?, Error> {
        return Future<ItemDetailModel?, Error> { [weak self, castingModel] promise in
            guard let strongSelf = self else {
                return promise(.success(nil)) 
            }
            strongSelf.networkManager.getData(text: text).sink { (completion) in
                switch completion {
                case .failure(let error):
                    CLogger.log(category: .parsing).error("error: '\(error.localizedDescription)'")
                    return promise(.failure(error))
                default:
                    break
                }
            } receiveValue: { (response) in
                
                guard let rootResponse = response as? [DetailRootClass] else {
                    return promise(.success(nil))
                }
                
                castingModel.casting(rootClass: rootResponse.first).sink { (completion) in
                    switch completion {
                    case .failure(let error):
                        CLogger.log(category: .parsing).error("error: '\(error.localizedDescription)'")
                        return promise(.failure(error))
                    default:
                        break
                    }
                } receiveValue: { (value) in
                    return promise(.success(value))
                }.store(in: &strongSelf.cancellables)
            }.store(in: &strongSelf.cancellables)
           
        }
    }
    
}
