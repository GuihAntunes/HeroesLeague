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
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    private(set) var hero: Hero?
    
    // MARK: - Actions
    @objc func setFavorite() {
        hero?.isFavorite.toggle()
        setupFavoriteButton()
    }
    
    // MARK: - Setup Methods
    func setupFavoriteButton() {
        guard let hero = hero else { return }
        favoriteButton.setTitle(hero.isFavorite ? "❤️" : "◎" , for: UIControl.State.normal)
    }
    
    func setupCell(withHero hero: Hero) {
        self.hero = hero
        heroNameLabel.text = hero.name
        favoriteButton.addTarget(self, action: #selector(setFavorite), for: .touchUpInside)
        setupFavoriteButton()
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
