//
//  LoginScreen.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//
import XCTest

final class LoginScreen: BaseScreen {

    // MARK: - Static elements (lazy stored)
    lazy var usernameField = app.textFields["Username"]
    lazy var passwordField = app.secureTextFields["Password"]
    lazy var loginButton = app.buttons["Login"]

    // MARK: - Dynamic elements (computed)
    lazy var usernameError = app.staticTexts["Invalid Username"]
    lazy var passwordError = app.staticTexts["Invalid Password"]
    lazy var offlineMessage = app.staticTexts["No Internet Connection"]
    lazy var lockedError = app.staticTexts["Locked out after 3 failed attempts"]

    // MARK: - Actions
    @discardableResult
    func enterUsername(username: String) -> Self {
        usernameField.clearAndTypeText(username)
        return self
    }
    
    @discardableResult
    func enterPassword(password: String) -> Self {
        passwordField.clearAndTypeText(password)
        return self
    }
    
    @discardableResult
    func tapLogin() -> Self {
        loginButton.tap()
        return self
    }
    
    @discardableResult
    func tapLoginTillLockedOut(times: Int) -> Self {
        for attempt in 1...times {
            tapLogin()
        }
        return self
    }
}


