//
//  AddBookAnimator.swift
//  Bibliio
//
//  Created by Adam on 11/1/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

final class VerticalSlideAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    
    private var blurView = UIVisualEffectView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.40
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let toVCFinalFrame = transitionContext.finalFrame(for: toViewController)
        let fromVCFinalFrame = transitionContext.finalFrame(for: fromViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        if isPresenting {
            blurView.frame = fromViewController.view.bounds
            blurView.effect = UIBlurEffect(style: .light)
            blurView.alpha = 0
            containerView.addSubview(blurView)
            toViewController.view.frame = toVCFinalFrame.offsetBy(dx: 0, dy: bounds.size.height)
            containerView.addSubview(toViewController.view)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.83, initialSpringVelocity: 0.0, options: [], animations: {
                self.blurView.alpha = 1
                toViewController.view.frame = toVCFinalFrame
            }, completion: {
                finished in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.83, initialSpringVelocity: 0.0, options: [], animations: {
                self.blurView.alpha = 0.0
                fromViewController.view.frame = fromVCFinalFrame.offsetBy(dx: 0, dy: (bounds.size.height))
            }, completion: {
                finished in
                self.blurView.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }
    }
    
}
