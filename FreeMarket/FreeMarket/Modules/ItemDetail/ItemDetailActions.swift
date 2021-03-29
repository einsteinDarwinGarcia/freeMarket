//
//  
//  ItemDetailActions.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 22/03/21.
//
//
import SwiftUI
import Combine
import CoreML

protocol ItemDetailActionsProtocol: ViewActionsProtocol {
    func loadData()
}

enum ItemDetailListActions: ListActions {
    case setItemDetail(ItemDetailModel)
    
    func setCategoryToCLog() -> Category {
        .itemDetail
    }
}

class ItemDetailActions<C: ItemDetailViewCoordinator, D: FluxDispatcher>:  Action<C>, ItemDetailActionsProtocol where D.L == ItemDetailListActions {
    
    private let dispatcher: D
    
    private var contentViewStore: AnyObject?
    
    private var itemDetail: ItemsModel
    
    private var networkingLayer: NetworkingDetailItems<ConfigurationDetailItemService>?
    private var cancellables: Set<AnyCancellable> = []
    private var modelMeli: ModelMELIPhones?
    
    lazy var coreDataStore: CoreDataStoring = {
        return CoreDataStore.default
    }()
    
    init(coordinator: C, dispatcher: D, itemDetail: ItemsModel) {
        self.dispatcher = dispatcher
        self.itemDetail = itemDetail
        super.init(coordinator: coordinator)
        setupNetworkingLayer()
        
    }
    
    func configureViewStore(modelStore: ItemDetailModelStore) {
        self.contentViewStore = ItemDetailViewStore(dispatcher: self.dispatcher, modelStore: modelStore)
    }
    
    func predictiveProduct() {
        do {
            modelMeli = try ModelMELIPhones(configuration: MLModelConfiguration())
            let meliPredictor = try modelMeli?.prediction(text: itemDetail.title)
            guard let predictionItem = meliPredictor?.label else {
                return
            }
            savePredictionProduct(prediction: predictionItem)
        } catch {
            print(error.localizedDescription) // TODO: logger
        }
    }
    
    func savePredictionProduct(prediction: String) {
        let action: ActionCoreData = { [coreDataStore] in
            let predictionEntity: ItemPredictionEntity = coreDataStore.createEntity()
            predictionEntity.category = prediction
        }
        
        coreDataStore
            .publicher(save: action).sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription) // TODO: logger
                }
            } receiveValue: { success in
                if success {
                  print("Saving PREDICTION") // TODO: logger
                }
            }
            .store(in: &cancellables)
        
    }
    
    func saveCoreData() {
        
        let action: ActionCoreData = { [coreDataStore, itemDetail] in
            let item: ItemDetailHistoryEntity = coreDataStore.createEntity()
            item.id = itemDetail.id
            item.title = itemDetail.title
            item.thumbnail = itemDetail.thumbnail
            item.price = itemDetail.price ?? 0.0
            item.categoryId = itemDetail.categoryId
            item.model = itemDetail.model
        }
        
        coreDataStore
            .publicher(save: action)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription) // TODO: logger
                }
            } receiveValue: { success in
                if success {
                  print("Saving entities succeeded") // TODO: logger
                }
            }
            .store(in: &cancellables)
    }
    
}

// MARK: networking conection layer
extension ItemDetailActions {
    
    func setupNetworkingLayer() {
        self.networkingLayer = NetworkingDetailItems(configService: ConfigurationDetailItemService())
    }
    
    func loadData() {
        
        self.networkingLayer?.networkingLayerService(text: self.itemDetail.id).sink { (completion) in
            switch completion {
            case .failure(let error):
                CLogger.log(category: .parsing).error("error: '\(error.localizedDescription)'")
                return
            default:
                break
            }
        } receiveValue: { [weak self]  (itemDetailModel) in
            guard let item = itemDetailModel else {
                return // TODO: logger
            }
            self?.saveCoreData()
            
            if itemDetailModel?.categoryId == "MCO1055" {
                self?.predictiveProduct()
            }
            
            self?.dispatcher.dispatch(.setItemDetail(item))
        }.store(in: &cancellables)

    }
}
