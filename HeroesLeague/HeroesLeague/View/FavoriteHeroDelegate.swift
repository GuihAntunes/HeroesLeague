//
//  FavoriteHeroDelegate.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 21/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

protocol FavoriteHeroDelegate: class {
    func toggleFavorite(shouldSave: Bool, _ hero: Hero, _ heroDetails: [HeroAppearance]?, withThumbnail thumbnail: UIImage?)
}
