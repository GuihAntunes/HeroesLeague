//
//  MarvelService.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

protocol HeroesRepositoryProtocol: class {
    func fetchHeroesList(lastIndex index: Int, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>)
    func fetchHeroesDetail(heroID id: Int, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>)
}

class MarvelService: HeroesRepositoryProtocol {
    
    let requester: Requester
    
    init(requester: Requester = Requester()) {
        self.requester = requester
    }
    
    func fetchHeroesList(lastIndex index: Int, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>) {
        requester.request(model: MarvelCharacterListResponse.self, HeroesEndpoints.list(lastIndex: index).request, completion: completion)
    }
    
    func fetchHeroDetails(forHero heroId: Int) {
        
    }
    
    func fetchHeroesDetail(heroID id: Int, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>) {
        requester.request(model: MarvelCharacterListResponse.self, HeroesEndpoints.heroDetail(heroId: id).request, completion: completion)
    }
    
}
