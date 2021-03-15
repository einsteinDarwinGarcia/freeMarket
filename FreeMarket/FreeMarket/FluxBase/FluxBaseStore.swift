//
//  FluxBaseStore.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Combine

protocol FluxStore {
    associatedtype D: FluxDispatcher
    associatedtype MS: ObservableObject
    var dispatcher: D { get set }
    init(dispatcher: D, modelStore: MS)
}

protocol FluxStoreNetworking {
    associatedtype D: FluxDispatcher
    associatedtype MS: ObservableObject
    associatedtype DataT
    var dispatcher: D { get set }
    init(dispatcher: D, modelStore: MS, dataRequest: DataT)
}
