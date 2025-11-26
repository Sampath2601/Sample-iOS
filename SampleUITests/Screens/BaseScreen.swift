//
//  BaseScreen.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//

import XCTest

/// Base class for all screens
class BaseScreen {

    let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    /// Generic wait for element
    @discardableResult
    func waitForElement(_ element: XCUIElement, timeout: TimeInterval = 2) -> Bool {
        return element.waitForExistence(timeout: timeout)
    }
}
