//
//  CoreDataService.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import CoreData
import Foundation

class CoreDataService: HeroesRepositoryProtocol {
    
    func fetchHeroDetails(forHero heroId: Int, completion: @escaping RequesterCompletion<[MarvelCharacterDetailsResponse?]>) {
        
    }
    
    
    func fetchHeroesList(lastIndex index: Int, completion: @escaping RequesterCompletion<MarvelCharacterListResponse>) {
        
    }
    
}
