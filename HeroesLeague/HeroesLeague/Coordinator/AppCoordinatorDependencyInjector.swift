//
//  AppCoordinatorDependencyInjector.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

class AppCoordinatorDependencyInjector {
    
    // MARK: - Main Navigation
    
    lazy var navigationController: UINavigationController = {
        let navigation = UINavigationController()
        navigation.navigationBar.prefersLargeTitles = true
        navigation.navigationBar.barStyle = .black
        navigation.navigationBar.tintColor = .white
        return navigation
    }()
    
    // MARK: - Controllers
    
    lazy var heroesListViewController: HeroesListViewController = {
        let controller: HeroesListViewController = .instantiate()
        heroesListViewModel.view = controller
        controller.viewModel = heroesListViewModel
        return controller
    }()
    
    // MARK: - View Models
    
    lazy var heroesListViewModel: HeroesListViewModel = {
        let viewModel: HeroesListViewModel = .init()
        viewModel.repository = HeroesRepository()
        return viewModel
    }()
}
