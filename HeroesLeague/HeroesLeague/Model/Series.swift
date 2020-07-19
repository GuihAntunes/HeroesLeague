//
//  Series.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

struct Series : Codable {
    
	let available : Int?
	let collectionURI : String?
	let items : [Items]?
	let returned : Int?
    
}
