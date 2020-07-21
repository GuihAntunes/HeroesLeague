//
//  UIViewController+ReusableElements.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

// MARK: - Quick Instances
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

// MARK: - Alert

extension UIViewController {
    
    func alert(title: String = "", message: String, completion: (() -> Void)? = nil, okActionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: okActionHandler)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: completion)
    }
    
}

// MARK: - Back Button override
extension UIViewController {
    
    func setBackButton(_ backFunction: Selector) {
        navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named: "back_arrow"), style: .plain, target: self, action: backFunction)
        newBackButton.title = "Back"
        navigationItem.leftBarButtonItem = newBackButton
    }
    
}

// MARK: - Loading Indicator

extension UIViewController {
    
    func addBlurLoading() {
        let showActivity = UIActivityIndicatorView()
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        showActivity.center = view.center
        showActivity.color = UIColor.white
        blurEffectView.contentView.addSubview(showActivity)
        blurEffectView.contentView.bringSubviewToFront(showActivity)
        showActivity.startAnimating()
    }
    
    func removeBlurLoading() {
        view.subviews.forEach({ (view) in
            if view is UIVisualEffectView {
                view.removeFromSuperview()
            }
        })
    }
    
}
