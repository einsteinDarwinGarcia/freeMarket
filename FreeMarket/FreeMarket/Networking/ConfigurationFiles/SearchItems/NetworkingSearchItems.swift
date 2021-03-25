//
//  NetworkingSearchItems.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 17/03/21.
//

import Combine

final class NetworkingSearchItems<C:NetworkConfiguration>: NetworkingLayer {
 
    var configurationService: C
    var networkManager: NetworkManager<C>
    var castingModel: CastingToSearchViewModels
    var cancellables: Set<AnyCancellable>
    
    init(configService: C) {
        self.configurationService = configService
        self.networkManager = NetworkManager(configuration: self.configurationService)
        self.castingModel = CastingToSearchViewModels()
        cancellables = []
    }
    
    
    func networkingLayerService(text: String) -> Future<CastingModel.FinalData?, Never> {
        
        self.configurationService.provider = .APIRest(serviceItem: .searchItems)
        
        return Future<CastingModel.FinalData?, Never> { [weak self, castingModel] promise in
            guard let strongSelf = self else {
                return promise(.success(nil)) // TODO: Logger manage error
            }
            strongSelf.networkManager.getData(text:text).sink {  (response) in
                guard let rootResponse = response as? RootClass else {
                    return promise(.success(nil)) // TODO: Logger manage error
                }
                
               /* castingModel.casting(rootClass: rootResponse.results).sink { value in
                    return promise(.success(value))
                }.store(in: &strongSelf.cancellables)*/
                strongSelf.getSecurityThumbnail(data: rootResponse.results!).sink { (resultWithSecureThumbnail) in
                    
                    castingModel.casting(rootClass: resultWithSecureThumbnail).sink { value in
                        return promise(.success(value))
                    }.store(in: &strongSelf.cancellables)
                    
                }.store(in: &strongSelf.cancellables) 
                
                
                
            }.store(in: &strongSelf.cancellables)
        }
    }
    
    func getSecurityThumbnail(data: [Results]) ->  AnyPublisher<[Results]?, Never> {
        return Future<[Results]?, Never> { [weak self] promise in
            guard let strongSelf = self else {
                return promise(.success(nil)) // TODO: Logger manage error
            }
            
            var nuevaData: [Results] = []
            
            let request = data.compactMap { result in
                return strongSelf.changeThumbnail(data: result)
            }
            
            Publishers.MergeMany(request).compactMap { $0 }
                .sink { (response) in
                    switch response {
                    case .failure(let error):
                        print(error.localizedDescription) // TODO: logger
                    case .finished:
                        return promise(.success(nuevaData))
                    }
                } receiveValue: { (securityThumbnail) in
                    nuevaData.append(securityThumbnail)
                }.store(in: &strongSelf.cancellables)
            
        }.eraseToAnyPublisher()
    }
    
    func changeThumbnail(data: Results) -> AnyPublisher<Results, Error> {
        return Future<Results, Error> { [weak self] promise in
            var dataThumbnail = data
            guard let strongSelf = self, let id = data.id else {
                return promise(.failure(ParsingError.weakself)) // TODO: Logger manage error
            }
            strongSelf.networkManager.getSecurityThumbnail(text: id).sink {  (response) in
                dataThumbnail.thumbnail = response?.first?.body?.secure_thumbnail
                return promise(.success(dataThumbnail))
            }.store(in: &strongSelf.cancellables)
        }.eraseToAnyPublisher()
    }
    
}
