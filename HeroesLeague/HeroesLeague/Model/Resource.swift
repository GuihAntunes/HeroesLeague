//
//  Resource.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 21/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

struct Resource : Codable {
    
    let available : Int?
    let collectionURI : String?
    let items : [Items]?
    let returned : Int?

}
