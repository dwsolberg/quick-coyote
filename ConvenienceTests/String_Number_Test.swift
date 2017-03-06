//
//  String_Number_Test.swift
//  Convenience
//
//  Created by David Solberg on 2/23/17.
//  Copyright © 2017 David Solberg. All rights reserved.
//

import Foundation

import XCTest
@testable import Convenience

class String_Number_Test: XCTestCase {

    let decimalString = "123.58"
    let numberString = "313"
    let numbersPlusComma = "1,138.13"
    let numbersPlusDashes = "13-14"
    let numberPlusJunk = "3189AB-=31,0.13"

    func testNormal() {
        XCTAssert(numberString.intValueRounded == 313, "Int test")
    }

    func testDecimal() {
        XCTAssert(decimalString.doubleValue == 123.58, "Double test")
    }

    func testCommasInNumber() {
        XCTAssert(numbersPlusComma.doubleValue == 1138.13, "Comma test")
    }

    func testDashesInNumber() {
        XCTAssert(numbersPlusDashes.intValueRounded == 1314, "Dashes test")
    }

    func testDecimalsToInt() {
        XCTAssert(decimalString.intValueRounded == 124, "123.58 to int test. Got \(decimalString.intValueRounded)")
        XCTAssert(numbersPlusComma.intValueRounded == 1138, "1,138.13 to int test. Got \(numbersPlusComma.intValueRounded)")
        XCTAssert(numberPlusJunk.intValueRounded == 3189310, "33189AB-=31,0.13 to int test. Got \(numberPlusJunk.intValueRounded)")
    }

    func testRemoveNonNumbers() {
        XCTAssert(numberString.numbersOnly == "313", "313 numbers only test")
        XCTAssert(decimalString.numbersOnly == "12358", "12358 numbers only test")
        XCTAssert(numbersPlusComma.numbersOnly == "113813", "113813 numbers only test")
        XCTAssert(numbersPlusDashes.numbersOnly == "1314", "1314 numbers only test")
        XCTAssert(numberPlusJunk.numbersOnly == "318931013", "318931013 numbers only test")
    }

    func testRemoveNonDecimalNumbers() {
        XCTAssert(numberString.numbersAndDecimalOnly == "313", "313 numbers decimal test")
        XCTAssert(decimalString.numbersAndDecimalOnly == "123.58", "123.58 numbers decimal test")
        XCTAssert(numbersPlusComma.numbersAndDecimalOnly == "1138.13", "1138.13 numbers decimal test")
        XCTAssert(numbersPlusDashes.numbersAndDecimalOnly == "1314", "1314 numbers decimal test")
        XCTAssert(numberPlusJunk.numbersAndDecimalOnly == "3189310.13", "3189310.13 numbers decimal test")
    }
}
