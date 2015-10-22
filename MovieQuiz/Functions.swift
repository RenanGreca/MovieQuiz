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
        return stringByReplacingOccurrencesOfString(find, withString: "", options: .LiteralSearch, range: nil)
    }
    func replaceAll(find:String, with:String) -> String {
        return stringByReplacingOccurrencesOfString(find, withString: with, options: .CaseInsensitiveSearch, range: nil)
    }
}

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
}