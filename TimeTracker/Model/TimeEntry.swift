//
//  TimeEntry.swift
//  TimeTracker
//
//  Created by Louis Menacho on 1/30/19.
//  Copyright © 2019 Louis Menacho. All rights reserved.
//

import Foundation

class TimeEntry {
    
    typealias Seconds = Int
    
    var timeIn: Date?
    var timeOut: Date?
    var duration: Seconds = 0
    var breakDuration: Seconds = 0
}
