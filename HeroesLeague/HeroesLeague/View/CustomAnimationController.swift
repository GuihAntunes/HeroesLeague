//
//  CustomAnimationController.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 21/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

class CustomAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let presentationType: PresentationType
    
    enum PresentationType {
        case present, dismiss
    }
    
    init(presentationType: PresentationType) {
        self.presentationType = presentationType
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: 1.5) ?? .init()
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let targetController = transitionContext.viewController(forKey: .to), let originController = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        switch presentationType {
        case .present:
            transitionContext.containerView.addSubview(targetController.view)
            animateTransition(withContext: transitionContext, andView: targetController.view)
        case .dismiss:
            transitionContext.containerView.addSubview(targetController.view)
            transitionContext.containerView.addSubview(originController.view)
            animateDismissTransition(withContext: transitionContext, andView: originController.view)
        }
        
    }
    
    func animateTransition(withContext context: UIViewControllerContextTransitioning, andView view: UIView) {
        view.clipsToBounds = true
        view.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { _ in
            view.transform = .identity
            context.completeTransition(true)
        }
    }
    
    func animateDismissTransition(withContext context: UIViewControllerContextTransitioning, andView view: UIView) {
        let animationDuration = transitionDuration(using: context)
        let minScale = CGAffineTransform(scaleX: 0.2, y: 0.2)
        let dismiss = CGAffineTransform(translationX: -view.frame.width, y: 0)
        let rotate = CGAffineTransform(rotationAngle: CGFloat(180).toRadians())
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                view.transform = minScale
            }
            
            UIView.addKeyframe(withRelativeStartTime: 1/animationDuration, relativeDuration: 1) {
                view.transform = minScale.concatenating(rotate).concatenating(dismiss)
            }
            
        }) { _ in
            view.transform = .identity
            context.completeTransition(true)
        }
        
    }
}
