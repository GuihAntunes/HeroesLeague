//
//  UIViewController+ReusableElements.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiate<T: UIViewController>() -> T {
        guard let controller = UIStoryboard(name: T.storyboardIdentifier.replacingOccurrences(of: "Controller", with: "").replacingOccurrences(of: "View", with: ""), bundle: T.bundle).instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("failed to create storyboard")}
        return controller
    }
    
    static func instantiateFromXIB<T: UIViewController>() -> T {
        return T(nibName: T.xibIdentifier.replacingOccurrences(of: "Controller", with: "").replacingOccurrences(of: "View", with: ""), bundle: .main)
    }
    
    static var bundle: Bundle {
        return Bundle(for: self)
    }
}

extension UIViewController {
    
    func setBackButton(_ backFunction: Selector) {
        navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named: "back_arrow"), style: .plain, target: self, action: backFunction)
        newBackButton.title = "Voltar"
        navigationItem.leftBarButtonItem = newBackButton
    }
    
}
