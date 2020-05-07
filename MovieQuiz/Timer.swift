//
//  Timer.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/25/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation
import UIKit

fileprivate var timer = Timer()
fileprivate var startTime = TimeInterval()

class TimerManager {
//    struct Static {
//        static let instance = Timer()
//    }
    
    static var timeElapsed = TimeInterval()
    static var label = UILabel()
    
    class func start(label: UILabel) {
        if (!timer.isValid) {
            self.label = label
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
            startTime = Date.timeIntervalSinceReferenceDate
        }
    }
    
    class func pause() {
        let currentTime = Date.timeIntervalSinceReferenceDate
        timeElapsed += currentTime - startTime
        timer.invalidate()
    }
    
    class func add(seconds:Int) {
        timeElapsed += TimeInterval(seconds)
    }
    
    class func reset() {
        timeElapsed = TimeInterval()
    }
    
    @objc
    class func updateTime() {
        let currentTime = Date.timeIntervalSinceReferenceDate
        
        //Find the difference between current time and start time.
        var elapsedTime: TimeInterval = currentTime - startTime + timeElapsed
        
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
