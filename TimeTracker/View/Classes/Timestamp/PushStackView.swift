//
//  TimestampView.swift
//  TimeTracker
//
//  Created by Louis Menacho on 2/4/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

class PushStackView: UIStackView {
    
    @IBOutlet weak var setTimeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func showTime() {
        setTimeButton.pushFadeOut(duration: 0.25, direction: .fromBottom, completion: {
            self.setTimeButton.isHidden = true
            self.dateLabel.pushFadeIn(duration: 0.25, direction: .fromTop)
            self.timeLabel.pushFadeIn(duration: 0.25, delay: 0.10, direction: .fromTop)
        })
    }
    
    func hideTime() {
        timeLabel.pushFadeOut(duration: 0.25, direction: .fromBottom)
        dateLabel.pushFadeOut(duration: 0.25, delay: 0.10, direction: .fromBottom, completion: {
            self.setTimeButton.isHidden = false
            self.setTimeButton.pushFadeIn(duration: 0.25, direction: .fromTop)
        })
    }
}
