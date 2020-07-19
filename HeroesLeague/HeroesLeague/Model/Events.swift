//
//  Events.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

struct Events : Codable {
    
	let available : Int?
	let collectionURI : String?
	let items : [Items]?
	let returned : Int?

}
