//
//  HeroAppearance.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

class HeroAppearance : Codable {
    
	var id : Int?
	var title : String?
	var description : String?
    var resourceURI: String?
    
    init() {
        id = .init()
        title = .init()
        description = .init()
        resourceURI = .init()
    }
    
}
