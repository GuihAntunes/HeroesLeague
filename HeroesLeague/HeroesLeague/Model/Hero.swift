//
//  Hero.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 19/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation

class Hero: Codable {
    
    var id : Int?
    var name : String?
    var description : String?
    var modified : String?
    var thumbnail : Thumbnail?
    var resourceURI : String?
    var comics : Resource?
    var series : Resource?
    var stories : Resource?
    var events : Resource?
    var isFavorite: Bool = false
    var imageData: Data? = nil
    
    init() {
        id = .init()
        name = .init()
        description = .init()
        modified = .init()
        thumbnail = nil
        resourceURI = .init()
        comics = nil
        series = nil
        stories = nil
        events = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, modified, thumbnail, resourceURI, comics, series, stories, events
    }
}
