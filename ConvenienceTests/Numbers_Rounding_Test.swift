//
//  Numbers_Rounded_Test.swift
//  Convenience
//
//  Created by David Solberg on 2/19/17.
//  Copyright © 2017 David Solberg. All rights reserved.
//

import Foundation

import XCTest
@testable import Convenience

class Numbers_Rounded_Test: XCTestCase {

    let example = 13568.6358

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBackwardsThree() {
        let rounded = example.rounded(toDecimal: -3)
        XCTAssert(rounded == 14000, "Shoud round to the nearest thousand")
    }

    func testBackwardsTwo() {
        let rounded = example.rounded(toDecimal: -2)
        XCTAssert(rounded == 13600, "Shoud round to the nearest hundred")
    }

    func testBackwardsOne() {
        let rounded = example.rounded(toDecimal: -1)
        XCTAssert(rounded == 13570, "Shoud round to the nearest ten")
    }

    func testZero() {
        let rounded = example.rounded(toDecimal: 0)
        XCTAssert(rounded == 13569, "Shoud round to the nearest zero")
    }

    func testForwardOne() {
        let rounded = example.rounded(toDecimal: 1)
        XCTAssert(rounded == 13568.6, "Shoud round to the nearest tenth")
    }

    func testForwardTwo() {
        let rounded = example.rounded(toDecimal: 2)
        XCTAssert(rounded == 13568.64, "Shoud round to the nearest hundredth")
    }

    func testForwardThree() {
        let rounded = example.rounded(toDecimal: 3)
        XCTAssert(rounded == 13568.636, "Shoud round to the nearest thousandth")
    }

    func testForwardFour() {
        let rounded = example.rounded(toDecimal: 4)
        XCTAssert(rounded == 13568.6358, "Shoud round to the nearest ten-thousandth")
    }

}
