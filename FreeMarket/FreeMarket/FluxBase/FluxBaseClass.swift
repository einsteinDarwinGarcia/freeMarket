//
//  FluxBaseClass.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Combine

protocol ListActions: ConfigureCategoryCLog {}

protocol ViewActionsProtocol: ObservableObject {
    associatedtype M: ObservableObject
    func configureViewStore(modelStore: M)
}
