//
//  CGFloat+Radians.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 21/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

extension CGFloat {
    
    func toRadians() -> CGFloat {
        return self * .pi / 180
    }
    
}
