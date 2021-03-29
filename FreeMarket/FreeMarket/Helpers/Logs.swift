//
//  Logs.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 15/03/21.
//

import Foundation
import os.log

protocol ConfigureCategoryCLog: CustomStringConvertible {
    func setCategoryToCLog() -> Category
}

extension ConfigureCategoryCLog {
    var description: String {
        let mirror = Mirror(reflecting: self)
        for case let (key?, value) in mirror.children {
            print("[\(self.setCategoryToCLog())] action value: \(value)")
            return "\(key)"
        }
        return String()
    }
}

enum Category: String {
    case parsing
    case url
    case itemDetail
    case searchItem
    case coreData
}

struct CLogger {
    static func log(category: Category)  -> Logger {
        return Logger(subsystem: Bundle.main.bundleIdentifier!, category: category.rawValue)
    }
}
