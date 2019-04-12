//
//  TimerClock.swift
//  EmployeeTracker
//
//  Created by Louis Menacho on 12/19/18.
//  Copyright © 2018 Louis Menacho. All rights reserved.
//

import Foundation

protocol TimerDelegate: class {
    func timerDidStart(_ timer: Timer)
    func timerDidStop(_ timer: Timer)
    func timerDidFire(_ timer: Timer)
}

class Timer {
    
    weak var delegate: TimerDelegate?
    
    private weak var timer: Foundation.Timer?
    
    func start() {
        timer = Foundation.Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: fire)
        if let delegate = delegate {
            delegate.timerDidStart(self)
        }
    }
    
    func stop() {
        timer?.invalidate()
        if let delegate = delegate {
            delegate.timerDidStop(self)
        }
    }
    
    private func fire(timer: Foundation.Timer) {
        if let delegate = delegate {
            delegate.timerDidFire(self)
        }
    }
}
