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
    
    private let formatter = DateComponentsFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        hoursLabel.font = UIFont.monospacedDigitSystemFont(ofSize: hoursLabel.font.pointSize, weight: .semibold)
        minutesLabel.font = UIFont.monospacedDigitSystemFont(ofSize: minutesLabel.font.pointSize, weight: .semibold)
        secondsLabel.font = UIFont.monospacedDigitSystemFont(ofSize: secondsLabel.font.pointSize, weight: .semibold)
    }
        
    func reset() {
        hoursLabel.text = "00"
        minutesLabel.text = "00"
        secondsLabel.text = "00"
    }
    
    func setElapsedTime(from start: Date, to end: Date) {
        guard let elapsedTime = formatter.string(from: start, to: end) else {
            fatalError("TimerView.setElapsedTime: Invalid date")
        }
        let firstColonIndex  = elapsedTime.firstIndex(of: ":")!
        let hoursString = String(elapsedTime[..<firstColonIndex])
        hoursLabel.text = String(format: "%02d", Int(hoursString)!)
        
        let indexAfterFirstColon  = elapsedTime.index(after: firstColonIndex)
        let secondColonIndex = elapsedTime.lastIndex(of: ":")!
        minutesLabel.text = String(elapsedTime[indexAfterFirstColon..<secondColonIndex])
        
        let indexAfterSecondColon = elapsedTime.index(after: secondColonIndex)
        secondsLabel.text = String(elapsedTime[indexAfterSecondColon...])
    }
}
