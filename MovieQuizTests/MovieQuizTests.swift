//
//  MovieQuizTests.swift
//  MovieQuizTests
//
//  Created by Renan Greca on 11/05/2020.
//  Copyright © 2020 renangreca. All rights reserved.
//

import XCTest
@testable import MovieQuiz

class MovieQuizTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRandomElements() {
        
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let random = array.getRandomElements(count: 3, avoiding: 3)
        
        XCTAssertEqual(random.count, 3)
        XCTAssert(!random.contains(3))
        
    }

}
