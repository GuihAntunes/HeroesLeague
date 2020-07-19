//
//  Hero.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

class Hero: Codable {
    
    let id : Int?
    let name : String?
    let description : String?
    let modified : String?
    let thumbnail : Thumbnail?
    let resourceURI : String?
    let comics : Comics?
    let series : Series?
    let stories : Stories?
    let events : Events?
    
}
