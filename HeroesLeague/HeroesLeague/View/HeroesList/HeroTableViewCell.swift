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
    weak var favoriteDelegate: FavoriteHeroDelegate?
    private(set) var hero: Hero? {
        didSet {
            setupDelegate()
        }
    }
    
    // MARK: - Actions
    @objc func setFavorite() {
        guard let hero = hero else { return }
        hero.isFavorite.toggle()
        favoriteDelegate?.toggleFavorite(shouldSave:hero.isFavorite ,hero, nil, withThumbnail: heroThumbnail.image)
        setupFavoriteButton()
    }
    
    // MARK: - Setup Methods
    func setupFavoriteButton() {
        guard let hero = hero else { return }
        favoriteButton.setTitle(hero.isFavorite ? "❤️" : "◎" , for: UIControl.State.normal)
        // I've disabled this because may cause inconsistency on favorites if used on list view. e.g.: the app will not be able save the hero details if the hero details screen hasn't been opened yet. Also, requirement number 4 is only mentioning about glacing and not effectively save the favorite
        favoriteButton.isUserInteractionEnabled = false
    }
    
    func setupCell(withHero hero: Hero) {
        self.hero = hero
        heroNameLabel.text = hero.name
        favoriteButton.addTarget(self, action: #selector(setFavorite), for: .touchUpInside)
        setupFavoriteButton()
        
        if let imageData = hero.imageData, !Reachability().isConnected {
            heroThumbnail.image = UIImage(data: imageData)
            return
        }
        
        DispatchQueue.global().async {
            if let thumbnailPath = hero.thumbnail?.path, let thumbnailExtension = hero.thumbnail?.thumbnailExtension, let thumbnailUrl = URL(string: thumbnailPath + "." + thumbnailExtension), let imageData = try? Data(contentsOf: thumbnailUrl) {
                DispatchQueue.main.async {
                    self.hero?.imageData = imageData
                    self.heroThumbnail.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    private func setupDelegate() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let injector = appDelegate.coordinator?.injector else { return }
        favoriteDelegate = injector.heroesListViewModel
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        DispatchQueue.main.async {
            self.heroThumbnail.image = nil
        }
    }
    
}
