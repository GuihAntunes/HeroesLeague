//
//  HeroDetailViewModel.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

protocol HeroDetailViewModelProtocol: class {
    var selectedHero: Hero? { get }
    func updateFavorites()
    func getTitle() -> String
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func getTitleForHeaderInSection(_ section: Int) -> String
    func getDetail(forIndexPath indexPath: IndexPath) -> (title: String, description: String)
    func dismissScreen()
}

class HeroDetailViewModel: HeroDetailViewModelProtocol {
    
    // MARK: - Properties
    weak var view: HeroDetailPresentable?
    var comics: [HeroAppearance] = .init()
    var events: [HeroAppearance] = .init()
    var stories: [HeroAppearance] = .init()
    var series: [HeroAppearance] = .init()
    var repository: HeroesRepositoryProtocol?
    var coordinator: AppCoordinatorProtocol?
    let sectionsTitles = ["Comics", "Events", "Stories", "Series"]
    var selectedHero: Hero? {
        didSet {
            getHeroDetails(forHero: selectedHero)
        }
    }
    
    // MARK: - Protocol Methods
    func updateFavorites() {
        
    }
    
    func dismissScreen() {
        coordinator?.presentPreviousStep()
    }
    
    func getTitle() -> String {
        return selectedHero?.name ?? .init()
    }
    
    func numberOfSections() -> Int {
        return 4
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        switch section {
        case 0:
            return comics.count
        case 1:
            return events.count
        case 2:
            return stories.count
        case 3:
            return series.count
        default:
            return .init()
        }
    }
    
    func getDetail(forIndexPath indexPath: IndexPath) -> (title: String, description: String) {
        switch indexPath.section {
        case 0:
            return (comics[indexPath.row].title ?? .init(), comics[indexPath.row].description ?? .init())
        
        case 1:
            return (events[indexPath.row].title ?? .init(), events[indexPath.row].description ?? .init())
        
        case 2:
            return (stories[indexPath.row].title ?? .init(), stories[indexPath.row].description ?? .init())
        
        case 3:
            return (series[indexPath.row].title ?? .init(), series[indexPath.row].description ?? .init())
        
        default:
            return (.init(), .init())
        }
    }
    
    func getTitleForHeaderInSection(_ section: Int) -> String {
        return sectionsTitles[section]
    }
    
    // MARK: - Private Methods
    
    private func setupDetailsLists(withLists lists: [MarvelCharacterDetailsResponse?]) {
        lists.forEach({
            guard let response = $0, let details = response.data?.results, let firstDetail = details.first?.resourceURI else { return }
            
            if firstDetail.contains(sectionsTitles[0].lowercased()) {
                comics = details
            }
            
            if firstDetail.contains(sectionsTitles[1].lowercased()) {
                events = details
            }
            
            if firstDetail.contains(sectionsTitles[2].lowercased()) {
                stories = details
            }
            
            if firstDetail.contains(sectionsTitles[3].lowercased()) {
                series = details
            }
        })
    }
    
    private func getHeroDetails(forHero hero: Hero?) {
        guard let hero = hero, let heroId = hero.id else { return }
        view?.startLoading()
        repository?.fetchHeroDetails(forHero: heroId, completion: { [weak self] (response, error) in
            if error == nil, let response = response {
                self?.setupDetailsLists(withLists: response)
                self?.view?.reloadList()
                return
            }
            
            self?.view?.showError(error ?? CustomError.generalError("Unexpected error!"))
        })
    }
    
}
