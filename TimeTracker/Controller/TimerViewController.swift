//
//  TimerViewController.swift
//  TimeTracker
//
//  Created by Louis Menacho on 1/30/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    let timer = Timer()
    
    @IBOutlet weak var timestampView: TimestampView!
    @IBOutlet weak var timerView: TimerView!
    @IBOutlet weak var timerButton: TimerButton!
    @IBOutlet weak var footerLabel: UILabel!
    
    override func viewDidLoad() {
        timer.delegate = self
        timestampView.reset()
        footerLabel.pushFadeOut(duration: 0.0, direction: .fromBottom)
    }
    
    @IBAction func timerButtonPressed(_ sender: TimerButton) {
        timerButton.throttle(limit: 0.4)
    
        switch timer.state {
            case .willStart:
                timer.start()
            
            case .willStop:
                timer.stop()
            
            case .willReset:
                timer.reset()
            
            case .willResume:
                timer.resume()
        }
    }
    
    @IBAction func timerButtonLongPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began && timer.state == .willStop {
            timer.pause()
        }
    }
}

extension TimerViewController: TimerDelegate {
    
    func timerDidStart(_ timer: Timer) {
        timestampView.clockIn()
        timerButton.setText(.stop)
        footerLabel.pushFadeIn(duration: 0.3, direction: .fromTop)
    }
    
    func timerDidStop(_ timer: Timer) {
        timestampView.clockOut()
        timerButton.setText(.reset)
        footerLabel.pushFadeOut(duration: 0.3, direction: .fromBottom)
    }
    
    func timerDidReset(_ timer: Timer) {
        timestampView.reset()
        timerView.reset()
        timerButton.setText(.start)
    }
    
    func timerDidPause(_ timer: Timer) {
        timerButton.setText(.resume)
        footerLabel.pushFadeOut(duration: 0.3, direction: .fromTop)
    }
    
    func timerDidResume(_ timer: Timer) {
        timerButton.setText(.stop)
        footerLabel.pushFadeIn(duration: 0.3, direction: .fromBottom)
    }
    
    func timerDidFire(_ timer: Timer, with elapsedTime: Seconds) {
        timerView.update(time: elapsedTime)
    }
}
