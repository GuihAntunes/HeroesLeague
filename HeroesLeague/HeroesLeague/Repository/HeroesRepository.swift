//
//  HeroesRepository.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

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
    
}
