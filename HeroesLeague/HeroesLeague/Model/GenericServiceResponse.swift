//
//  GenericServiceResponse.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

struct MarvelCharacterListResponse: Codable {
    
    let code: Int?
    let status: String?
    let copyright: String?
    let data: HeroList?
    
}

struct HeroList: Codable {
    
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Hero]?
    
}

struct MarvelCharacterDetailsResponse: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [HeroAppearance]?
}
