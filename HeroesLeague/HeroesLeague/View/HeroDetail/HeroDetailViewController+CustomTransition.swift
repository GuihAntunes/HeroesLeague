//
//  HeroDetailViewController+CustomTransition.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 21/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

extension HeroDetailViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimationController(presentationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimationController(presentationType: .dismiss)
    }
    
}
