//
//  Counter.swift
//  swiftapp
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation

class Counter {
    static var rightAnswers = 0 // right answers
    static var wrongAnswers = 0 // wrong answers
    
    class func reset() {
        rightAnswers = 0
        wrongAnswers = 0
    }
    
    class func right() {
        rightAnswers += 1
    }
    
    class func wrong() {
        wrongAnswers -= 1
    }
    
    class func total() -> Int {
        return rightAnswers+wrongAnswers
    }
}
