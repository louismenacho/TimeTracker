//
//  RingButton.swift
//  TimeTracker
//
//  Created by Louis Menacho on 2/28/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

@IBDesignable
class RingButton: UIButton {
    
    @IBInspectable
    var ringThickness: CGFloat = 2 {
        didSet {
            innerRingLayer.lineWidth = ringThickness
            outerRingLayer.lineWidth = ringThickness
        }
    }
    
    @IBInspectable
    var ringDistance: CGFloat = 50 {
        didSet {
            let distance = ringDistance/184 * bounds.height
            innerRingLayer.size = CGSize(width: bounds.width+distance, height: bounds.height+distance)
            outerRingLayer.size = CGSize(width: bounds.width+distance*2, height: bounds.height+distance*2)
        }
    }
    
    @IBInspectable
    var color: UIColor = .black {
        didSet {
            UIView.animate(withDuration: 0.40) {
                self.layer.backgroundColor = self.color.cgColor
                self.innerRingLayer.strokeColor = self.color.cgColor
                self.outerRingLayer.strokeColor = self.color.cgColor
            }
        }
    }
    
    private var innerRingLayer = RingLayer()
    private var outerRingLayer = RingLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        prepareView()
    }
    
    private func prepareView() {
        layer.cornerRadius = bounds.width/2
        layer.addSublayer(innerRingLayer)
        layer.addSublayer(outerRingLayer)
        configureRings()
    }
    
    private func configureRings() {
        color = #colorLiteral(red: 0.2606219947, green: 0.8743250966, blue: 0.8997631669, alpha: 1)
        
        innerRingLayer.lineWidth = ringThickness
        outerRingLayer.lineWidth = ringThickness
        
        innerRingLayer.size = CGSize(width: bounds.width+ringDistance, height: bounds.height+ringDistance)
        outerRingLayer.size = CGSize(width: bounds.width+ringDistance*2, height: bounds.height+ringDistance*2)
        
        innerRingLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        outerRingLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    func startSpinning() {
        innerRingLayer.pulseAndRotate(rotateDirection: .counterclockwise)
        outerRingLayer.pulseAndRotate(rotateDirection: .clockwise)
    }
    
    func stopSpinning() {
        innerRingLayer.stopAndPulse()
        outerRingLayer.stopAndPulse()
    }
}
