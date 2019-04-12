//
//  ContainerView.swift
//  TimeTracker
//
//  Created by Louis Menacho on 4/4/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

@IBDesignable
class ContainerView: UIView {
    
    @IBInspectable
    var intrinsicWidth: CGFloat = 100
    
    @IBInspectable
    var intrinsicHeight: CGFloat = 100
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: intrinsicWidth, height: intrinsicHeight)
    }
}
