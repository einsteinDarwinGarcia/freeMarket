//
//  FluxDispatcher.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Combine

protocol FluxDispatcher {
    associatedtype L: ListActions
    func register(callback: @escaping (L) -> ())
    func dispatch(_ action: L)
}

class Dispatcher<L: ListActions>: FluxDispatcher {
    
    private let actionSubject = PassthroughSubject<L, Never>()
    private var cancellables: [AnyCancellable] = []
    
    func register(callback: @escaping (L) -> ()) {
        let actionStream = actionSubject.sink(receiveValue: callback)
        cancellables += [actionStream]
    }
    
    func dispatch(_ action: L) {
        actionSubject.send(action)
        CLog(action: action)
    }
}

extension Dispatcher {
    func CLog(action: L) {
        let category = action.setCategoryToCLog()
        CLogger.log(category: category).notice("action dispatch \(action.self)")
    }
}
