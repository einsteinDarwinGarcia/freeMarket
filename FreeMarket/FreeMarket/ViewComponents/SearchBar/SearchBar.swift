//
//  SearchBar.swift
//  FreeMarket
//
//  Created by Einstein Darwin Garcia Mendez on 16/03/21.
//


import SwiftUI
import Combine

class SearchBar: NSObject, ObservableObject {
    
    @Published var text: String = ""
    @Published var beginEditing: Bool = false
    var activeSearchService = CurrentValueSubject<String, Never>("")
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    override init() {
        super.init()
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
    }
}

extension SearchBar: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchBarText = searchController.searchBar.text {
            self.text = searchBarText
            if SearchBarValidations.isValidateTextToActiveSearchService(text: self.text) {
                activeSearchService.value = self.text
            }
        }
    }
}

extension SearchBar: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.beginEditing = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.beginEditing = false
    }
}

struct SearchBarValidations {
    static func isValidateTextToActiveSearchService(text: String) -> Bool {
        return text.count > 2
    }
}
