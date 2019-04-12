//
//  Animations.swift
//  TimeTracker
//
//  Created by Louis Menacho on 2/7/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

extension UIView {
    
    func pushFadeIn(duration: CFTimeInterval, delay: CFTimeInterval = 0,  direction: CATransitionSubtype, completion: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let transition = CATransition()
            
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            
            transition.type = .push
            transition.subtype = direction
            transition.duration = duration
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            self.layer.opacity = 1
            self.layer.add(transition, forKey: "pushFadeIn")
            
            CATransaction.commit()
        }
    }
    
    func pushFadeOut(duration: CFTimeInterval, delay: CFTimeInterval = 0, direction: CATransitionSubtype, completion: (() -> Void)? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let transition = CATransition()
            
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            
            transition.type = .push
            transition.subtype = direction
            transition.duration = duration
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            self.layer.opacity = 0
            self.layer.add(transition, forKey: "pushFadeOut")
            
            CATransaction.commit()
        }
    }
}

