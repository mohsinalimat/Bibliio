//
//  HorizontalSlideAnimationController.swift
//  Biblio
//
//  Created by Adam on 11/4/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

class HorizontalSlideAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    public var isPushing = true
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        let containerView = transitionContext.containerView
        
        if isPushing == true {
            toView.frame = containerView.bounds.offsetBy(dx: containerView.bounds.width, dy: 0.0);
            containerView.addSubview(toView)
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                toView.frame = containerView.bounds
                fromView.frame = containerView.bounds.offsetBy(dx: -containerView.bounds.width, dy: 0.0)
            }, completion: { (didComplete) in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(didComplete)
            })
        } else {
            toView.frame = containerView.bounds.offsetBy(dx: -containerView.bounds.width, dy: 0.0);
            containerView.addSubview(toView)
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                toView.frame = containerView.bounds
                fromView.frame = containerView.bounds.offsetBy(dx: containerView.bounds.width, dy: 0.0)
            }, completion: { (didComplete) in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(didComplete)
            })
        }
    }
}
