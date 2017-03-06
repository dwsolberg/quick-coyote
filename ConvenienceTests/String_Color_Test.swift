//
//  String_Color_Test.swift
//  Convenience
//
//  Created by David Solberg on 2/20/17.
//  Copyright © 2017 David Solberg. All rights reserved.
//

import Foundation

import XCTest
@testable import Convenience

class String_Color_Test: XCTestCase {

    let uiRed = UIColor(colorLiteralRed: 1.0, green: 0, blue: 0, alpha: 1)
    let uiBlue = UIColor(colorLiteralRed: 0, green: 0, blue: 1.0, alpha: 1)
    let uiGreen = UIColor(colorLiteralRed: 0, green: 1.0, blue: 0, alpha: 1)

    let uiRedClear = UIColor(colorLiteralRed: 1.0, green: 0, blue: 0, alpha: 0)
    let uiBlueClear = UIColor(colorLiteralRed: 0, green: 0, blue: 1.0, alpha: 0)
    let uiGreenClear = UIColor(colorLiteralRed: 0, green: 1.0, blue: 0, alpha: 0)

    func testHexWithPrefixDefaultOpacity() {
        XCTAssert("0xFF0000".asColor() == uiRed, "Red color failed")
        XCTAssert("0x0000FF".asColor() == uiBlue, "Blue color failed")
        XCTAssert("0x00FF00".asColor() == uiGreen, "Green color failed")
    }

    func testHexWithPrefixClearOpacity() {
        XCTAssert("0xFF000000".asColor() == uiRedClear, "Red clear color failed")
        XCTAssert("0x0000FF00".asColor() == uiBlueClear, "Blue clear color failed")
        XCTAssert("0x00FF0000".asColor() == uiGreenClear, "Green clear color failed")
    }

    func testHexWithPoundPrefixDefaultOpacity() {
        XCTAssert("#FF0000".asColor() == uiRed, "Red color failed")
        XCTAssert("#0000FF".asColor() == uiBlue, "Blue color failed")
        XCTAssert("#00FF00".asColor() == uiGreen, "Green color failed")
    }

    func testHexWithPoundPrefixClearOpacity() {
        XCTAssert("#FF000000".asColor() == uiRedClear, "Red clear color failed")
        XCTAssert("#0000FF00".asColor() == uiBlueClear, "Blue clear color failed")
        XCTAssert("#00FF0000".asColor() == uiGreenClear, "Green clear color failed")
    }

    func testHexDefaultOpacity() {
        XCTAssert("FF0000".asColor() == uiRed, "Red color failed")
        XCTAssert("0000FF".asColor() == uiBlue, "Blue color failed")
        XCTAssert("00FF00".asColor() == uiGreen, "Green color failed")
    }

    func testHexClearOpacity() {
        XCTAssert("FF000000".asColor() == uiRedClear, "Red clear color failed")
        XCTAssert("0000FF00".asColor() == uiBlueClear, "Blue clear color failed")
        XCTAssert("00FF0000".asColor() == uiGreenClear, "Green clear color failed")
    }

    func testHexFullOpacity() {
        XCTAssert("FF0000FF".asColor() == uiRed, "Red clear color failed")
        XCTAssert("0000FFFF".asColor() == uiBlue, "Blue clear color failed")
        XCTAssert("00FF00FF".asColor() == uiGreen, "Green clear color failed")
    }

    func testLowercase() {
        XCTAssert("ff0000".asColor() == uiRed, "Red color failed")
        XCTAssert("0000ff".asColor() == uiBlue, "Blue color failed")
        XCTAssert("00ff00".asColor() == uiGreen, "Green color failed")
    }
}
