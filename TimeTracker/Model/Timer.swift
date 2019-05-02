//
//  TimerClock.swift
//  EmployeeTracker
//
//  Created by Louis Menacho on 12/19/18.
//  Copyright © 2018 Louis Menacho. All rights reserved.
//

import UIKit

typealias Seconds = Int

protocol TimerDelegate: class {
    func timerDidStart(_ timer: Timer)
    func timerDidStop(_ timer: Timer)
    func timerDidReset(_ timer: Timer)
    func timerDidPause(_ timer: Timer)
    func timerDidResume(_ timer: Timer)
    func timerDidFire(_ timer: Timer, with elapsedTime: Seconds)
}

class Timer {
    
    enum State {
        case willStart, willStop, willReset, willResume
    }
    
    var state: State = .willStart
    
    weak var delegate: TimerDelegate?
    
    private weak var timer: Foundation.Timer?
    private var startTime: Date?
    private var pauseTime: Date?
    private var elapsedTime: TimeInterval = 0
    private var totalPauseTime: TimeInterval = 0
    
    func start() {
        state = .willStop
        startTime = Date()
        timer = Foundation.Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: fire)
        
        if let delegate = delegate {
            delegate.timerDidStart(self)
        }
    }
    
    func stop() {
        state = .willReset
        timer?.invalidate()
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        if let delegate = delegate {
            delegate.timerDidStop(self)
        }
    }
    
    func reset() {
        state = .willStart
        startTime = nil
        pauseTime = nil
        elapsedTime = 0
        totalPauseTime = 0
        
        if let delegate = delegate {
            delegate.timerDidReset(self)
        }
    }
    
    func pause() {
        state = .willResume
        pauseTime = Date()
        timer?.invalidate()
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        if let delegate = delegate {
            delegate.timerDidPause(self)
        }
    }
    
    func resume() {
        state = .willStop
        totalPauseTime += Date().timeIntervalSince(pauseTime!)
        pauseTime = nil
        timer = Foundation.Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: fire)
        
        if let delegate = delegate {
            delegate.timerDidResume(self)
        }
    }
    
    private func fire(timer: Foundation.Timer) {
        elapsedTime = Date().timeIntervalSince(startTime!) - totalPauseTime
        
        if let delegate = delegate {
            delegate.timerDidFire(self, with: Seconds(elapsedTime))
        }
    }
}
