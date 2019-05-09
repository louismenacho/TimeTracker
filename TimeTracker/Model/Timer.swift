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
    func timerDidStart(_ timer: Timer, startDate: Date)
    func timerDidStop(_ timer: Timer,  stopDate: Date)
    func timerDidReset(_ timer: Timer)
    func timerDidPause(_ timer: Timer)
    func timerDidResume(_ timer: Timer)
    func timerDidSchedule(_ timer: Timer, startDate: Date)
    func timerDidSchedule(_ timer: Timer,  stopDate: Date)
    func timerDidUpdate(_ timer: Timer, with elapsedTime: Seconds)
}

extension Timer {
    enum State {
        case reset, running, stopped, paused, scheduledStop
    }
    
    enum InputError: LocalizedError {
        case invalidDate
        
        var errorDescription: String? {
            switch self {
            case .invalidDate:
                return "Invalid Date"
            }
        }
        
        var failureReason: String? {
            switch self {
            case .invalidDate:
                return "Clock in date must be before clock out date."
            }
        }
    }
}

class Timer {
    
    var state: State = .reset
    
    weak var delegate: TimerDelegate?
    
    private weak var timer: Foundation.Timer? {
        didSet {
            RunLoop.main.add(timer!, forMode: .common)
        }
    }
    
    private var startDate: Date?
    private var stopDate: Date?
    private var pauseDate: Date?
    private var totalPauseTime: TimeInterval = 0
    
    private var elapsedTime: TimeInterval = 0 {
        didSet {
            guard let delegate = delegate else { return }
            delegate.timerDidUpdate(self, with: Seconds(elapsedTime))
        }
    }
    
    func start() {
        state = .running
        startDate = Date()
        timer = timer ?? Foundation.Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: fire)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        guard let delegate = delegate else { return }
        delegate.timerDidStart(self, startDate: startDate!)
    }
    
    func stop() {
        state = .stopped
        stopDate = stopDate ?? Date()
        timer?.invalidate()
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        guard let delegate = delegate else { return }
        delegate.timerDidStop(self, stopDate: stopDate!)
    }
    
    func reset() {
        state = .reset
        startDate = nil
        pauseDate = nil
        stopDate = nil
        elapsedTime = 0
        totalPauseTime = 0
        
        guard let delegate = delegate else { return }
        delegate.timerDidReset(self)
    }
    
    func pause() {
        state = .paused
        pauseDate = Date()
        timer?.invalidate()
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        guard let delegate = delegate else { return }
        delegate.timerDidPause(self)
    }
    
    func resume() {
        state = .running
        totalPauseTime += Date().timeIntervalSince(pauseDate!)
        pauseDate = nil
        timer = timer ?? Foundation.Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: fire)
        
        guard let delegate = delegate else { return }
        delegate.timerDidResume(self)
    }
    
    func scheduleStart(on date: Date) throws {
        if let stopDate = stopDate {
            guard date < stopDate else { throw InputError.invalidDate }
            elapsedTime = stopDate.timeIntervalSince(date).rounded(.up)
            stop()
        } else {
            startDate = date
            timer = timer ?? Foundation.Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: fire)
        }
        
        guard let delegate = delegate else { return }
        delegate.timerDidSchedule(self, startDate: date)
    }
    
    func scheduleStop(on date: Date) throws {
        if let startDate = startDate {
            guard startDate < date else { throw InputError.invalidDate }
            elapsedTime = date.timeIntervalSince(startDate).rounded(.up)
            stop()
        } else {
            stopDate = date
            state = .scheduledStop
        }
        
        guard let delegate = delegate else { return }
        delegate.timerDidSchedule(self, stopDate: date)
    }
    
    private func fire(timer: Foundation.Timer) {
        elapsedTime = Date().timeIntervalSince(startDate!) - totalPauseTime
        if elapsedTime >= 0 && state == .reset { start() }
    }
}
