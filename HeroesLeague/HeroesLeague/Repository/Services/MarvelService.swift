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
    func fetchHeroDetails(forHero heroId: Int, completion: @escaping RequesterCompletion<[MarvelCharacterDetailsResponse?]>)
    func searchHero(withName name: String, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>)
}

class MarvelService: HeroesRepositoryProtocol {
    
    let requester: Requester
    
    init(requester: Requester = Requester()) {
        self.requester = requester
    }
    
    func fetchHeroesList(lastIndex index: Int, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>) {
        requester.request(model: MarvelCharacterListResponse.self, HeroesEndpoints.list(lastIndex: index).request, completion: completion)
    }
    
    func fetchHeroDetails(forHero heroId: Int, completion: @escaping RequesterCompletion<[MarvelCharacterDetailsResponse?]>) {
        let group: DispatchGroup = .init()
        let detailsEndpoints = [HeroesEndpoints.comics(heroId: heroId).request, HeroesEndpoints.events(heroId: heroId).request, HeroesEndpoints.stories(heroId: heroId).request, HeroesEndpoints.series(heroId: heroId).request]
        var completions: [MarvelCharacterDetailsResponse?] = .init()
        var lastError: Error?
        detailsEndpoints.forEach {
            group.enter()
            self.requester.request(model: MarvelCharacterDetailsResponse.self, $0) { (codable, error) in
                completions.append(codable)
                lastError = error
                group.leave()
            }
        }
        
        group.notify(queue: .global()) {
            completion(completions, lastError)
        }
    }
    
    func searchHero(withName name: String, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>) {
        requester.request(model: MarvelCharacterListResponse.self, HeroesEndpoints.searchHero(name: name).request, completion: completion)
    }
    
}
