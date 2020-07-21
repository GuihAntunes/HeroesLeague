//
//  UINavigationController+CustomTransition.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 21/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

// This piece right here I got from this medium article, because my custom animation wasn't working from navigation controllers transitions, so I had to do some research to make my custom work on navigations too. Reference: https://medium.com/better-programming/simple-custom-uinavigationcontroller-transitions-fdb56a217dd8
extension UINavigationController {
    
    static private var coordinatorHelperKey = "UINavigationController.TransitionCoordinatorHelper"

    var transitionCoordinatorHelper: CustomNavigationTransition? {
        return objc_getAssociatedObject(self, &UINavigationController.coordinatorHelperKey) as? CustomNavigationTransition
    }

    func addCustomTransitioning() {

        var object = objc_getAssociatedObject(self, &UINavigationController.coordinatorHelperKey)

        guard object == nil else {
            return
        }

        object = CustomNavigationTransition()
        let nonatomic = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
        objc_setAssociatedObject(self, &UINavigationController.coordinatorHelperKey, object, nonatomic)

        delegate = object as? CustomNavigationTransition


        let edgeSwipeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        edgeSwipeGestureRecognizer.edges = .left
        view.addGestureRecognizer(edgeSwipeGestureRecognizer)
    }

    @objc func handleSwipe(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        guard let gestureRecognizerView = gestureRecognizer.view else {
            transitionCoordinatorHelper?.interactionController = nil
            return
        }

        let percent = gestureRecognizer.translation(in: gestureRecognizerView).x / gestureRecognizerView.bounds.size.width

        if gestureRecognizer.state == .began {
            transitionCoordinatorHelper?.interactionController = UIPercentDrivenInteractiveTransition()
            popViewController(animated: true)
        } else if gestureRecognizer.state == .changed {
            transitionCoordinatorHelper?.interactionController?.update(percent)
        } else if gestureRecognizer.state == .ended {
            if percent > 0.5 && gestureRecognizer.state != .cancelled {
                transitionCoordinatorHelper?.interactionController?.finish()
            } else {
                transitionCoordinatorHelper?.interactionController?.cancel()
            }
            transitionCoordinatorHelper?.interactionController = nil
        }
    }
}
