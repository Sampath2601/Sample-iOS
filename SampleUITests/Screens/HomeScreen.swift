//
//  HomeScreen.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//

import XCTest

final class HomeScreen: BaseScreen {

    // Static element (lazy)
    lazy var logoutButton = app.buttons["Logout"]

    lazy var welcomeText = app.staticTexts["Welcome!"]

    // MARK: - Actions
    func tapLogout() {
        logoutButton.tap()
    }
}
