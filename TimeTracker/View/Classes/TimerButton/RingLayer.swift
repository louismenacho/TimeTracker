//
//  RingLayer.swift
//  TimeTracker
//
//  Created by Louis Menacho on 3/1/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

enum Rotation: CGFloat {
    case clockwise = 1
    case counterclockwise = -1
}

class RingLayer: CAShapeLayer {
    
    var size: CGSize = .zero {
        didSet {
            frame.size = size
            path = UIBezierPath(ovalIn: bounds).cgPath
        }
    }
    
    override init() {
        super.init()
        lineWidth = 2
        fillColor = UIColor.clear.cgColor
        lineDashPattern = [9,8.1]
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate(duration: CFTimeInterval, delay: CFTimeInterval = 0, direction: Rotation) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.duration = duration
        rotateAnimation.beginTime = CACurrentMediaTime() + delay
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = 2 * CGFloat.pi * direction.rawValue
        rotateAnimation.repeatDuration = .infinity
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        add(rotateAnimation, forKey: "rotate")
    }
    
    func pulse(duration: CFTimeInterval, delay: CFTimeInterval = 0, scale: CGFloat) {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = duration
        pulseAnimation.beginTime = CACurrentMediaTime() + delay
        pulseAnimation.fromValue = 1
        pulseAnimation.toValue = scale
        pulseAnimation.autoreverses = true
        pulseAnimation.isRemovedOnCompletion = false
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        add(pulseAnimation, forKey: "pulse")
    }
    
    func pulseAndRotate(rotateDirection: Rotation) {
        pulse(duration: 0.20, scale: 0.85)
        rotate(duration: 6, delay: 0.40, direction: rotateDirection)
    }
    
    func stopAndPulse() {
        removeAnimation(forKey: "rotate")
        pulse(duration: 0.20, scale: 0.85)
    }
}
