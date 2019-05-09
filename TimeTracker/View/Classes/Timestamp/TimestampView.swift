//
//  TimestampView.swift
//  TimeTracker
//
//  Created by Louis Menacho on 2/11/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

@IBDesignable
class TimestampView: ContainerView {

    @IBOutlet weak var inTimeStackView: PushStackView!
    @IBOutlet weak var outTimeStackView: PushStackView!
    
    private var dateFormat = "MMM dd, yyyy"
    private var timeFormat = "hh:mm a"
    
    private var dateformatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }
    
    private var timeformatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormat
        return formatter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        prepareView()
    }
    
    private func prepareView() {
        let borderLayer = CAShapeLayer()
        let borderPath = CGMutablePath()
        
        //top border
        borderPath.move(to: bounds.origin)
        borderPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        
        //bottom border
        borderPath.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        borderPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        
        borderLayer.path = borderPath
        borderLayer.lineWidth = 2
        borderLayer.strokeColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        layer.addSublayer(borderLayer)
    }
    
    private func setInDate(_ date: Date) {
        inTimeStackView.dateLabel.text = dateformatter.string(from: date)
        inTimeStackView.timeLabel.text = timeformatter.string(from: date)
    }
    
    private func setOutDate(_ date: Date) {
        outTimeStackView.dateLabel.text = dateformatter.string(from: date)
        outTimeStackView.timeLabel.text = timeformatter.string(from: date)
    }
    
    func clockIn(date: Date) {
        setInDate(date)
        inTimeStackView.showTime()
    }
    
    func clockOut(date: Date) {
        setOutDate(date)
        outTimeStackView.showTime()
    }
    
    func resetInTime() {
        inTimeStackView.hideTime()
    }
    
    func resetOutTime() {
        outTimeStackView.hideTime()
    }
    
    func reset() {
        inTimeStackView.hideTime()
        outTimeStackView.hideTime()
    }
}
