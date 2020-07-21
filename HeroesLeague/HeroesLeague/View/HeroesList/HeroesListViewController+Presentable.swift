//
//  HeroesListViewController+Presentable.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

protocol HeroesListPresentable: class {
    func reloadList()
    func stopLoading()
    func startLoading()
}

extension HeroesListViewController: HeroesListPresentable {
    
    func startLoading() {
        DispatchQueue.main.async {
            self.addBlurLoading()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.removeBlurLoading()
        }
    }
    
    func reloadList() {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
            self.stopLoading()
        }
    }
}
