//
//  XCUIElement+Extension.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//

import XCTest

extension XCUIElement {

    /// Clear existing text and type new text
    func clearAndTypeText(_ text: String) {
        guard let stringValue = self.value as? String else {
            self.tap()
            self.typeText(text)
            return
        }

        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
        self.typeText(text)
    }

    /// Tap and wait for another element
    func tapAndWait(for element: XCUIElement, timeout: TimeInterval = 2) {
        self.tap()
        XCTAssertTrue(element.waitForExistence(timeout: timeout))
    }

    /// Check if element is visible
    var isVisible: Bool {
        return self.exists && self.isHittable
    }
}
