//
//  BaseTest.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//

import XCTest

/// Base class for all UI tests
class BaseTest: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        configureLaunchArguments()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }

    func configureLaunchArguments() {
        app.launchArguments = ["UITest"]
    }
}
