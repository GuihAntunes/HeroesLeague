//
//  HeroDetailTableViewCell.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

class HeroDetailTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    // MARK: - Setup Methods
    func setup(withDetails details: (title: String, description: String)) {
        detailTitleLabel.text = details.title
        detailDescriptionLabel.text = details.description
    }
}
