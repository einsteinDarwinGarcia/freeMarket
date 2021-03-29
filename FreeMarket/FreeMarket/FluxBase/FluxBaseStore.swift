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
