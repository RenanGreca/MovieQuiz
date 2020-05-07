//
//  Timer.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/25/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation
import UIKit

class Timer {
    var timer = Timer()
    var startTime = TimeInterval()
    var label = UILabel()
    var timeElapsed = TimeInterval()
    
    struct Static {
        static let instance = Timer()
    }
    
    func start(label: UILabel) {
//        if (!timer.valid) {
//            self.label = label
//            let aSelector : Selector = #selector(self.updateTime)
//            timer = Timer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
//            startTime = Date.timeIntervalSinceReferenceDate
//        }
    }
    
    func pause() {
        let currentTime = Date.timeIntervalSinceReferenceDate
        self.timeElapsed += currentTime - startTime
//        self.timer.invalidate()
    }
    
    func add(seconds:Int) {
        self.timeElapsed += TimeInterval(seconds)
    }
    
    func reset() {
        self.timeElapsed = TimeInterval()
    }
    
    @objc func updateTime() {
        let currentTime = Date.timeIntervalSinceReferenceDate
        
        //Find the difference between current time and start time.
        var elapsedTime: TimeInterval = currentTime - startTime + self.timeElapsed
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
        let _ = fraction > 9 ? String(fraction):"0" + String(fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        self.label.text = "\(strMinutes):\(strSeconds)"
    }
}
