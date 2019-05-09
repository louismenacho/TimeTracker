//
//  DatePicker.swift
//  TimeTracker
//
//  Created by Louis Menacho on 5/1/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate: class {
    func datePickerView(_ datePickerView: DatePickerView, didSelect date: Date, with selectedSegment: DatePickerView.Segment)
}

class DatePickerView: UIView {
    
    enum Segment: Int {
        case startClockAt, stopClockAt
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    weak var delegate: DatePickerViewDelegate?
    
    private var textColor: UIColor = #colorLiteral(red: 0.3254901961, green: 0.3529411765, blue: 0.431372549, alpha: 1)
    private var bottomConstraint: NSLayoutConstraint? {
        return superview?.constraints.filter({$0.firstAttribute == .bottom}).first
    }
    
    override func awakeFromNib() {
        prepareView()
    }
    
    func prepareView() {
        datePicker.setValue(textColor, forKeyPath: "textColor")
    }
    
    func show() {
        if let bottomConstraint = bottomConstraint, let superview = superview {
            UIView.animate(withDuration: 0.4) {
                bottomConstraint.constant = 0
                superview.layoutIfNeeded()
            }
        }
    }
    
    func hide() {
        if let bottomConstraint = bottomConstraint, let superview = superview {
            UIView.animate(withDuration: 0.4) {
                bottomConstraint.constant = -self.frame.height
                superview.layoutIfNeeded()
            }
        }
    }
    
    func selectSegment(_ segment: Segment) {
        segmentedControl.selectedSegmentIndex = segment.rawValue
    }
    
    func selectDate() {
        let seconds = Calendar.current.dateComponents(in: .current, from: datePicker.date).second!
        let selectedDate = Calendar.current.date(byAdding: .second, value: -seconds, to: datePicker.date)!
        let selectedSegment = Segment(rawValue: segmentedControl.selectedSegmentIndex)!
        if let delegate = delegate {
            delegate.datePickerView(self, didSelect: selectedDate, with: selectedSegment)
        }
    }
}
