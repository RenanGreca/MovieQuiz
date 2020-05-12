//
//  Functions.swift
//  MovieQuiz
//
//  Created by Renan Greca on 5/8/15.
//  Copyright (c) 2015 renangreca. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element: Equatable {
    
    /// Get `count` random elements from the array, while avoiding a specific element.
    /// - Parameters:
    ///   - count: The number of elements we want.
    ///   - avoiding: The element to avoid returning.
    /// - Returns: An array with `count` random elements.
    func getRandomElements(count: Int, avoiding: Element) -> [Element] {
        guard count < self.count else {
            return self
        }
        
        // Alternative implementation, but slower.
//        var result: [Element] = self.shuffled()
//        result.removeAll(where: {$0 == avoiding})
//        return Array(result.prefix(count))
        
        var result: [Element] = []
        repeat {
            // Find a random element that is not yet in the result list.
            if let element = self.randomElement(),
               !result.contains(element) {
                result.append(element)
            }
            // Get random elements while the result list is smaller than both the desired count and the total number of elements available.
        } while ((result.count < count) && (result.count < self.count))
        
        return result
    }
}

extension UINavigationController {

    func setStatusBar(foregroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
//        statusBarView.style
        statusBarView.tintColor = foregroundColor
//        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }

}
