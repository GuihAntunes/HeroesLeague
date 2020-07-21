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
    func stopLoading()
    func startLoading()
    func showError(_ error: Error)
}

extension HeroDetailViewController: HeroDetailPresentable {
    
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
            self.detailsListTableView.reloadData()
            self.stopLoading()
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            self.removeBlurLoading()
            self.alert(message: error.localizedDescription)
        }
    }
    
}
