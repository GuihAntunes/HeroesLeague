//
//  HeroTableViewCell.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var heroThumbnail: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    // MARK: - Properties
    private(set) var hero: Hero?
    
    // MARK: - Setup Methods
    
    func setupCell(withHero hero: Hero) {
        self.hero = hero
        heroNameLabel.text = hero.name
        DispatchQueue.global().async {
            if let thumbnailPath = hero.thumbnail?.path, let thumbnailExtension = hero.thumbnail?.thumbnailExtension, let thumbnailUrl = URL(string: thumbnailPath + "." + thumbnailExtension), let imageData = try? Data(contentsOf: thumbnailUrl) {
                DispatchQueue.main.async {
                    self.heroThumbnail.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        DispatchQueue.main.async {
            self.heroThumbnail.image = nil
        }
    }
    
}
