//
//  LoginTests.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//

import XCTest

class LoginTests: BaseTest {
    
    // MARK: - Screens Initialization
    lazy var loginScreen = LoginScreen(app: app)
    lazy var homeScreen = HomeScreen(app: app)

    // MARK: - Tests

    func testLoginButtonEnabledOnlyWhenValid() {
        loginScreen.enterUsername(username: Credentials.validUserName)
            .enterPassword(password: Credentials.validPassword)
        
        XCTAssertTrue(loginScreen.loginButton.isEnabled)

        loginScreen.enterUsername(username: "verylongusername") // >10 chars
        XCTAssertFalse(loginScreen.loginButton.isEnabled)
    }

    func testSuccessfulLoginAndLogoutFlow() {
        loginScreen.enterUsername(username: Credentials.validUserName)
            .enterPassword(password: Credentials.validPassword)
            .tapLogin()
        
        XCTAssertTrue(homeScreen.welcomeText.waitForExistence(timeout: 2))

        homeScreen.tapLogout()
        XCTAssertTrue(loginScreen.usernameField.waitForExistence(timeout: 2))
    }

    func testOfflineLogin() {
        app.terminate()
        app.launchEnvironment["OFFLINE_MODE"] = "1"
        app.launch()

        loginScreen.enterUsername(username: Credentials.validUserName)
            .enterPassword(password: Credentials.validPassword)
            .tapLogin()
        XCTAssertTrue(loginScreen.offlineMessage.waitForExistence(timeout: 2))
    }

    func testInlineValidationErrors() {
        loginScreen.enterUsername(username: "verylongusername") // >10 chars
        XCTAssertTrue(loginScreen.usernameError.waitForExistence(timeout: 1))

        loginScreen.enterPassword(password: "longpassword") // >=10 chars
        XCTAssertTrue(loginScreen.passwordError.waitForExistence(timeout: 1))
    }
    
    func testLockedOut() {
        loginScreen.enterUsername(username: Credentials.validUserName)
            .enterPassword(password: Credentials.invalidPassword)
            .tapLoginTillLockedOut(times: 3)
        XCTAssertTrue(loginScreen.lockedError.waitForExistence(timeout: 1))
    }
}
