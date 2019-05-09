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
    @IBOutlet weak var datePickerView: DatePickerView!
    
    
    override func viewDidLoad() {
        timer.delegate = self
        datePickerView.delegate = self
        footerLabel.pushFadeOut(duration: 0.0, direction: .fromBottom)
    }
    
    @IBAction func setTimeInButtonPressed(_ sender: UIButton) {
        datePickerView.show()
        datePickerView.selectSegment(.startClockAt)
    }
    
    @IBAction func setTimeOutButtonPressed(_ sender: UIButton) {
        datePickerView.show()
        datePickerView.selectSegment(.stopClockAt)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        datePickerView.hide()
        datePickerView.selectDate()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        datePickerView.hide()
    }
    
    @IBAction func timerButtonPressed(_ sender: TimerButton) {
        timerButton.throttle(limit: 0.4)
    
        switch timer.state {
        case .reset:
            timer.start()
        
        case .running:
            timer.stop()
        
        case .stopped:
            timer.reset()
        
        case .paused:
            timer.resume()
            
        case .scheduledStop:
            do {
                try timer.scheduleStart(on: Date())
            } catch {
                displayErrorMessage(error as! Timer.InputError)
            }
        }
    }
    
    @IBAction func timerButtonLongPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began && timer.state == .running {
            timer.pause()
        }
    }
    
    private func displayErrorMessage(_ error: LocalizedError) {
        let alert = UIAlertController(title: error.errorDescription, message: error.failureReason, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension TimerViewController: TimerDelegate {
    
    func timerDidStart(_ timer: Timer, startDate: Date) {
        timestampView.clockIn(date: startDate)
        timerButton.setText(.stop)
        footerLabel.pushFadeIn(duration: 0.3, direction: .fromTop)
    }
    
    func timerDidStop(_ timer: Timer, stopDate: Date) {
        timestampView.clockOut(date: stopDate)
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
    
    func timerDidSchedule(_ timer: Timer, startDate: Date) {
        timestampView.clockIn(date: startDate)
    }
    
    func timerDidSchedule(_ timer: Timer, stopDate: Date) {
        timestampView.clockOut(date: stopDate)
    }
    
    func timerDidUpdate(_ timer: Timer, with elapsedTime: Seconds) {
        timerView.update(time: elapsedTime)
    }
}

extension TimerViewController: DatePickerViewDelegate {
    
    func datePickerView(_ datePickerView: DatePickerView, didSelect date: Date, with selectedSegment: DatePickerView.Segment) {
        switch selectedSegment {
        case .startClockAt:
            do {
                try timer.scheduleStart(on: date)
            } catch {
                displayErrorMessage(error as! Timer.InputError)
                datePickerView.show()
            }

        case .stopClockAt:
            do {
                try timer.scheduleStop(on: date)
            } catch {
                displayErrorMessage(error as! Timer.InputError)
                datePickerView.show()
            }
        }
    }
}
