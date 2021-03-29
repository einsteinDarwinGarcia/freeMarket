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
    var castingModel: CastingCoreDataToViewModel<ItemSearchModel>
    var cancellables: Set<AnyCancellable>
    
    init() {
        self.configurationService = ConfigurationSearchEntity()
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
