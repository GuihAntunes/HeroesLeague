//
//  HeroesListViewModel.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

protocol HeroesListViewModelProtocol: class {
    func loadHeroes()
    func selectHero(atIndexPath indexPath: IndexPath)
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func getHero(atIndexPath indexPath: IndexPath) -> Hero
}

class HeroesListViewModel: HeroesListViewModelProtocol {
    
    var heroes: [Hero] = .init()
    var selectedHero: Hero?
    var coordinator: AppCoordinatorProtocol?
    var repository: HeroesRepositoryProtocol?
    weak var view: HeroesListPresentable?
    var lastIndex: Int = 0
    
    func loadHeroes() {
        self.view?.startLoading()
        repository?.fetchHeroesList(lastIndex: lastIndex, completion: { [weak self] (response, error) in
            self?.view?.stopLoading()
            if let heroes = response?.data?.results, error == nil {
                self?.heroes = heroes
                self?.view?.reloadList()
                return
            }
        })
    }
    
    func selectHero(atIndexPath indexPath: IndexPath) {
        self.selectedHero = heroes[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return heroes.count
    }
    
    func getHero(atIndexPath indexPath: IndexPath) -> Hero {
        return heroes[indexPath.row]
    }
}
