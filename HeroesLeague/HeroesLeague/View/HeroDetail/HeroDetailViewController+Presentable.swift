//
//  HeroDetailViewController+Presentable.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

protocol HeroDetailPresentable: class {
    func reloadList()
}

extension HeroDetailViewController: HeroDetailPresentable {
    
    func reloadList() {
        DispatchQueue.main.async {
            self.detailsListTableView.reloadData()
        }
    }
    
}
