//
//  Functions.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/8/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation

extension String{
    func exclude(find:String) -> String {
        return self.replacingOccurrences(of: find, with: "")
    }
    func replaceAll(find:String, with:String) -> String {
        return self.replacingOccurrences(of: find, with: with)
    }
}

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
}
