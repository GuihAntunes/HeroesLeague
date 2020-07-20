//
//  HeroDetailViewModel.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

protocol HeroDetailViewModelProtocol: class {
    func getTitle() -> String
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func getTitleForHeaderInSection(_ section: Int) -> String
    func getDetail(forIndexPath indexPath: IndexPath) -> (name: String, resource: String)
}

class HeroDetailViewModel: HeroDetailViewModelProtocol {
    
    // MARK: - Properties
    weak var view: HeroDetailPresentable?
    var comics: [HeroAppearance] = .init()
    var events: [HeroAppearance] = .init()
    var stories: [HeroAppearance] = .init()
    var series: [HeroAppearance] = .init()
    var selectedHero: Hero? {
        didSet {
            getHeroDetails(forHero: selectedHero)
        }
    }
    
    // MARK: - Protocol Methods
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
    
    func getDetail(forIndexPath indexPath: IndexPath) -> (name: String, resource: String) {
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
        switch section {
        case 0:
            return "Comics"
        case 1:
            return "Events"
        case 2:
            return "Stories"
        case 3:
            return "Series"
        default:
            return .init()
        }
    }
    
    // MARK: - Private Methods
    
    private func getHeroDetails(forHero hero: Hero?) {
        guard let hero = hero else { return }
        
    }
}
