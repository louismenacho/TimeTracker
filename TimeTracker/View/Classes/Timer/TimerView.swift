//
//  TimerView.swift
//  TimeTracker
//
//  Created by Louis Menacho on 2/12/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

@IBDesignable
class TimerView: UIStackView {

    @IBOutlet weak private var hoursLabel: UILabel!
    @IBOutlet weak private var minutesLabel: UILabel!
    @IBOutlet weak private var secondsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hoursLabel.font = UIFont.monospacedDigitSystemFont(ofSize: hoursLabel.font.pointSize, weight: .semibold)
        minutesLabel.font = UIFont.monospacedDigitSystemFont(ofSize: minutesLabel.font.pointSize, weight: .semibold)
        secondsLabel.font = UIFont.monospacedDigitSystemFont(ofSize: secondsLabel.font.pointSize, weight: .semibold)
    }
        
    func reset() {
        hoursLabel.text = "00"
        minutesLabel.text = "00"
        secondsLabel.text = "00"
    }
    
    func update(time: Seconds) {
        let hours = time / 3600
        let minutes = (time / 60) % 60
        let seconds = time % 60
        hoursLabel.text = String(format: "%02d", abs(hours))
        minutesLabel.text = String(format: "%02d", abs(minutes))
        secondsLabel.text = String(format: "%02d", abs(seconds))
    }
}
