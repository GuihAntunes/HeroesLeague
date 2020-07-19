//
//  MarvelService.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

protocol HeroesRepositoryProtocol: class {
    func fetchHeroesList(lastIndex index: Int, completion: @escaping RequesterCompletion<MarvelServiceResponse>)
    func fetchHeroesDetail(heroID id: Int, completion: @escaping RequesterCompletion<MarvelServiceResponse>)
}

class MarvelService: HeroesRepositoryProtocol {
    
    let requester: Requester
    
    init(requester: Requester = Requester()) {
        self.requester = requester
    }
    
    func fetchHeroesList(lastIndex index: Int, completion: @escaping RequesterCompletion<MarvelServiceResponse>) {
        requester.request(model: MarvelServiceResponse.self, HeroesEndpoints.list(lastIndex: index).request, completion: completion)
    }
    
    func fetchHeroesDetail(heroID id: Int, completion: @escaping RequesterCompletion<MarvelServiceResponse>) {
        requester.request(model: MarvelServiceResponse.self, HeroesEndpoints.heroDetail(heroId: id).request, completion: completion)
    }
    
}
