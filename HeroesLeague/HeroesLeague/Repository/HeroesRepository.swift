//
//  HeroesRepository.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

protocol HeroesRepositoryProtocol: class {
    func fetchHeroesList(lastIndex index: Int, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>)
    func fetchHeroDetails(forHero heroId: Int, completion: @escaping RequesterCompletion<[MarvelCharacterDetailsResponse?]>)
    func searchHero(withName name: String, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>)
    func saveHeroLocally(_ hero: Hero, details: [HeroAppearance]?, withThumbnail thumbnail: UIImage?)
    func deleteHeroLocally(_ hero: Hero)
    func retriveFavorites() -> [Hero]?
}

class HeroesRepository: HeroesRepositoryProtocol {
    
    let marvelService: MarvelService
    let coreDataService: CoreDataService
    
    init(marvelService: MarvelService = .init(), coreDataService: CoreDataService = .init()) {
        self.marvelService = marvelService
        self.coreDataService = coreDataService
    }
    
    func fetchHeroesList(lastIndex index: Int, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>) {
        DispatchQueue.global().async {
            self.marvelService.fetchHeroesList(lastIndex: index) { [weak self] (response, error) in
                if error != nil && !Reachability().isConnected {
                    self?.coreDataService.fetchHeroesList(lastIndex: index, completion: completion)
                    return
                }
                
                completion(response, error)
            }
        }
    }
    
    func fetchHeroDetails(forHero heroId: Int, completion: @escaping RequesterCompletion<[MarvelCharacterDetailsResponse?]>) {
        DispatchQueue.global().async {
            self.marvelService.fetchHeroDetails(forHero: heroId) { [weak self] (response, error) in
                if error != nil && !Reachability().isConnected {
                    self?.coreDataService.fetchHeroDetails(forHero: heroId, completion: completion)
                    return
                }
                
                completion(response, error)
            }
        }
    }
    
    func searchHero(withName name: String, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>) {
        DispatchQueue.global().async {
            self.marvelService.searchHero(withName: name) { [weak self] (response, error) in
                if error != nil && !Reachability().isConnected {
                    self?.coreDataService.searchHero(withName: name, completion: completion)
                    return
                }
                
                completion(response, error)
            }
        }
    }
    
    func saveHeroLocally(_ hero: Hero, details: [HeroAppearance]?, withThumbnail thumbnail: UIImage? = nil) {
        coreDataService.saveHeroLocally(hero, details: details, withThumbnail: thumbnail)
    }
    
    func deleteHeroLocally(_ hero: Hero) {
        coreDataService.deleteHeroLocally(hero)
    }
    
    func retriveFavorites() -> [Hero]? {
        return coreDataService.retriveFavorites()
    }
    
}
