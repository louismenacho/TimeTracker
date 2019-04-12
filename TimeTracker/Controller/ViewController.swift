//
//  ViewController.swift
//  TimeTracker
//
//  Created by Louis Menacho on 1/30/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let timer = Timer()
    let timeLog = TimeLog()
    
    var entry = TimeEntry()
    
    @IBOutlet weak var timestampView: TimestampView!
    @IBOutlet weak var timerView: TimerView!
    @IBOutlet weak var timerButton: TimerButton!
    
    override func viewDidLoad() {
        timer.delegate = self
        timestampView.reset()
    }
    
    @IBAction func timerButtonPressed(_ sender: TimerButton) {
        timerButton.throttle(limit: 0.4)
    
        switch timerButton.currentLabel {
        case .start:
            timestampView.clockIn()
            timer.start()
            timerButton.startSpinning()
            
        case .stop:
            timestampView.clockOut()
            timer.stop()
            timerButton.stopSpinning()
            
        case .save:
            timestampView.reset()
            timerView.reset()
        }
        
        timerButton.setNextLabel()
    }
}

extension ViewController: TimerDelegate {
    
    func timerDidStart(_ timer: Timer) {
        entry = TimeEntry()
        entry.timeIn = Date()
    }
    
    func timerDidStop(_ timer: Timer) {
        entry.timeOut = Date()
        timeLog.entries.append(entry)
    }
    
    func timerDidFire(_ timer: Timer) {
        timerView.setElapsedTime(from: entry.timeIn!, to: Date())
    }
}
