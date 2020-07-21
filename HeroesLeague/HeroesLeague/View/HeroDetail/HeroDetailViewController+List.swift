//
//  HeroDetailViewController+List.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

extension HeroDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? .init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection(section) ?? .init()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HeroDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if let details = viewModel?.getDetail(forIndexPath: indexPath) {
            cell.setup(withDetails: details)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.getTitleForHeaderInSection(section)
    }
    
}
