//
//  HeroesListViewController+List.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

extension HeroesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? .init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection(section) ?? .init()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HeroTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        if let totalItems = viewModel?.numberOfItemsInSection(indexPath.section), indexPath.row >= totalItems - 1 {
            viewModel?.loadHeroes()
        }
        
        if let hero = viewModel?.getHero(atIndexPath: indexPath) {
            cell.setupCell(withHero: hero)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectHero(atIndexPath: indexPath)
    }
    
}
