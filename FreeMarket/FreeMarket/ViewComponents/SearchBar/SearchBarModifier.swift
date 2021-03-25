//
//  SearchBarModifier.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//

import SwiftUI

struct SearchBarModifier: ViewModifier {
    
    let searchBar: SearchBar
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerResolver { viewController in
                    viewController.navigationItem.searchController = self.searchBar.searchController
                    viewController.navigationController?.navigationBar.barTintColor = UIColor(Color.black)
                    viewController.navigationController?.navigationBar.tintColor = UIColor(Color.backgroundSecondary)
                    viewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :  UIColor.gray]
                    viewController.navigationItem.searchController?.searchBar.searchBarStyle = .prominent
                    viewController.navigationItem.searchController?.searchBar.searchTextField.tintColor = .white
                }
                    .frame(width: 0, height: 0)
            )
    }
}

extension View {
    func add(_ searchBar: SearchBar) -> some View {
        return self.modifier(SearchBarModifier(searchBar: searchBar))
    }
}
