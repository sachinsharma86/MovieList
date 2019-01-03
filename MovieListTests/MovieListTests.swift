//
//  MovieListTests.swift
//  MovieListTests
//
//  Created by Sachin on 12/17/18.
//

import XCTest
@testable import MovieList

class MovieListTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserFriendlyDate() {
        
        let date = "2000-09-15"
        let userFriendlyDate = Date.userFriendlyDateString(dateString: date)
        XCTAssertEqual(userFriendlyDate, "Sep 15, 2000")
    }

}
