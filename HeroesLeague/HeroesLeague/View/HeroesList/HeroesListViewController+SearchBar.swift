//
//  HeroesListViewController+SearchBar.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 21/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

extension HeroesListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchIsActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            searchIsActive = false
            return
        }
        
        searchIsActive = searchText.count > 0
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        guard let searchText = searchBar.text, searchText.count > 0 else {
            searchIsActive = false
            viewModel?.loadHeroes()
            return
        }
        viewModel?.searchHero(withName: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.text?.removeAll()
        searchIsActive = false
        viewModel?.loadHeroes()
    }
}
