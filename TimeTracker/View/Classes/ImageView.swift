//
//  ImageView.swift
//  TimeTracker
//
//  Created by Louis Menacho on 4/12/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

@IBDesignable
class ImageView: UIImageView {

    override func awakeFromNib() {
        layer.cornerRadius = frame.height/2
    }
    
    override func prepareForInterfaceBuilder() {
        layer.cornerRadius = frame.height/2
    }
}
