//
//  CoreDataPredictiveSearching.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 26/03/21.
//

import Combine
import CoreData

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
    
    func networkingLayerService(text: String) -> Future<CastingModel.FinalData?, Error> {
        return Future<CastingModel.FinalData?, Error> { promise in
            let nameSort = NSSortDescriptor(key:"category", ascending:true)
            
            self.networkManager.getCoreDataResult(sort:nameSort).sink { (completion) in
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
