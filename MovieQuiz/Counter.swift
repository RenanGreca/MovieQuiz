//
//  Counter.swift
//  swiftapp
//
//  Created by Renan Greca on 5/6/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation

class Counter {
    var 👍 = 0 // right answers
    var 👎 = 0 // wrong answers
    
    struct Static {
        static let instance = Counter()
    }
    
    func reset() {
        👍 = 0
        👎 = 0
    }
    
    func right() {
        👍 += 1
    }
    
    func wrong() {
        👎 -= 1
    }
    
    func total() -> Int {
        return 👍+👎
    }
}
