//
//  ConvenienceUITests.swift
//  ConvenienceUITests
//
//  Created by David Solberg on 2/19/17.
//  Copyright © 2017 David Solberg. All rights reserved.
//

import XCTest

@testable import Convenience

class ConvenienceUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    let title = "Test Title"
    let dismissTitle = "Dismiss Title"
    let cancelTitle = "Nope"
    let acceptTitle = "Yup"

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()

//        let label = app.staticTexts["Result"]
//        XCTAssertEqual(label.title, "Result", "Could not find result label.")

        let alertTitleTextField = app.textFields["Alert Title"]
        alertTitleTextField.tap()
        alertTitleTextField.typeText(title)

        app.buttons["Make Alert"].tap()
        app.alerts[title].buttons["Dismiss"].tap()

//        XCTAssertEqual(label.title, "Used default dismiss", "Default dismiss message not used.")

        let dismissTitleTextField = app.textFields["Dismiss Title"]
        dismissTitleTextField.tap()
        dismissTitleTextField.typeText(dismissTitle)

        app.buttons["Make Alert"].tap()
        app.alerts[title].buttons[dismissTitle].tap()
//        XCTAssertEqual(label.title, dismissTitle, "Custom dismiss message not used.")

        // Action Alerts
        let acceptTitleTextField = app.textFields["Accept Title"]
        acceptTitleTextField.tap()
        acceptTitleTextField.typeText(acceptTitle)

        let cancelTitleTextField = app.textFields["Cancel Title"]
        cancelTitleTextField.tap()
        cancelTitleTextField.typeText(cancelTitle)

        app.buttons["Make Action Alert"].tap()
        app.alerts[title].buttons[cancelTitle].tap()
//        XCTAssertEqual(label.title, cancelTitle, "Cancel action not used.")

        app.buttons["Make Action Alert"].tap()
        app.alerts[title].buttons[acceptTitle].tap()
//        XCTAssertEqual(label.title, acceptTitle, "Accept action not used.")

    }
    
}
