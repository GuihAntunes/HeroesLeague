//
//  HeroesListViewModel.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

protocol HeroesListViewModelProtocol: class {
    func getTitle() -> String
    func loadHeroes()
    func selectHero(atIndexPath indexPath: IndexPath)
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func getHero(atIndexPath indexPath: IndexPath) -> Hero
    func searchHero(withName name: String)
}

class HeroesListViewModel: HeroesListViewModelProtocol, FavoriteHeroDelegate {
    
    // MARK: - Properties
    var heroes: [Hero] = .init()
    var selectedHero: Hero?
    var coordinator: AppCoordinatorProtocol?
    var repository: HeroesRepositoryProtocol?
    weak var view: HeroesListPresentable?
    var lastIndexFetched: Int = 0
    var wasSearching = false
    
    // MARK: - Protocol Methods
    func searchHero(withName name: String) {
        wasSearching = true
        self.view?.startLoading()
        repository?.searchHero(withName: name, completion: { [weak self] (response, error) in
            if let heroes = response?.data?.results, error == nil {
                self?.heroes = heroes
                self?.updateResponseWithFavorites()
                self?.view?.reloadList()
                return
            }
            
            self?.view?.showError(error ?? CustomError.generalError("Unexpected error!"))
        })
    }
    
    func loadHeroes() {
        if wasSearching {
            wasSearching.toggle()
            heroes.removeAll()
            lastIndexFetched = 0
        }
        self.view?.startLoading()
        repository?.fetchHeroesList(lastIndex: lastIndexFetched, completion: { [weak self] (response, error) in
            if let heroes = response?.data?.results, error == nil {
                self?.heroes.append(contentsOf: heroes)
                self?.updateResponseWithFavorites()
                self?.view?.reloadList()
                self?.lastIndexFetched = self?.heroes.count ?? .init()
                return
            }
            
            self?.view?.showError(error ?? CustomError.generalError("Unexpected error!"))
        })
    }
    
    func selectHero(atIndexPath indexPath: IndexPath) {
        selectedHero = heroes[indexPath.row]
        coordinator?.presentNextStep()
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
    
    func getTitle() -> String {
        return "Heroes League"
    }
    
    // MARK: - Favorites Delegate and Favorite Helper Methods
    func toggleFavorite(shouldSave: Bool, _ hero: Hero, _ heroDetails: [HeroAppearance]?, withThumbnail thumbnail: UIImage?) {
        if shouldSave {
            repository?.saveHeroLocally(hero, details: heroDetails, withThumbnail: thumbnail)
            return
        }
        
        repository?.deleteHeroLocally(hero)
    }
    
    func updateResponseWithFavorites() {
        let favorites: [Hero] = repository?.retriveFavorites() ?? .init()
        let responseFavorites = heroes.filter { (hero) -> Bool in
            return favorites.contains(where: { hero.id == $0.id })
        }
        
        responseFavorites.forEach({ $0.isFavorite = true })
    }
    
}
