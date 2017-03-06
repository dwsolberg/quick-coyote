//
//  String+Substrings_Test.swift
//
//  Copyright © 2017 David Solberg. All rights reserved.
//

import XCTest
@testable import Convenience

class String_Substrings_Test: XCTestCase {

    func testStartAtIndex9() {
        //          0123456789
        let base = "Starting_Word_Removed"
        let result = base.substring(from: 9)
        XCTAssertTrue(result == "Word_Removed", "The string should start at index 9.")
    }

    func testStringUpToIndex8() {
        //          0123456789
        let base = "Starting_Word_Only"
        let result = base.substring(to: 8)
        XCTAssertTrue(result == "Starting", "The string should end immediately before index 8.")
    }

    func testStringMiddle() {
        //          012345678901234
        let base = "Middle_Word_Only"
        let result = base.substring(from: 7, to: 11)
        XCTAssertTrue(result == "Word", "The string start at index 7 and end immediately before index 11.")
    }

    func testStartIndexAtEndOfString() {
        //          0123456789
        let base = "Starting"
        let result = base.substring(from: 8)
        XCTAssertTrue(result == "", "Starting at the end index should return an empty string")
    }

    func testInvalidIndexAtStartOfString() {
        //          0123456789
        let base = "Starting"
        let result = base.substring(from: 9)
        XCTAssertNil(result, "Starting at the end index should return nil.")
    }

    func testInvalidRange() {
        //          0123456789
        let base = "Starting"
        let result = base.substring(from: 5, to: 9)
        XCTAssertNil(result, "Going over the end index should return nil.")
    }

    func testUnicodeSingleCharacter() {
        //          0123-------4567
        let base = "Pok\u{00E9}mon"
        let result = base.substring(from: 0, to: 5)
        XCTAssertTrue(result == "Pokém", "Should correctly treat unicode characters.")
    }

    func testUnicodeComboCharacter() {
        //          0123---------------4567
        let base = "Pok\u{0065}\u{0301}mon"
        let result = base.substring(from: 0, to: 5)
        XCTAssertTrue(result == "Pokém", "Should correctly treat unicode characters.")
    }

    func testInvalidEndString() {
        //          0123456789
        let base = "Starting"
        let result = base.substring(to: 9)
        XCTAssertNil(result, "Going over the end index should return nil.")
    }

    func testComboString() {
        //          012345678901234
        let base = "Resumé has an combo character"
        let result = base.substring(to: 6)
        XCTAssertTrue(result == "Resumé", "The string should end immediately before index 6.")
    }

    func testRegularEmoji() {
        //          0  1 2 3
        let base = "⛄️🚦🎁🐝"
        let result = base.substring(from: 1, to: 3)
        XCTAssertTrue(result == "🚦🎁", "The string start at emoji at index 1 and end immediately before 3.")
    }
}
