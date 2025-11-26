//
//  LoginViewModelTests.swift
//  Sample
//
//  Created by Sampath Masapogu on 26/11/25.
//

import XCTest
import Combine
@testable import Sample

@MainActor
final class LoginViewModelTests: XCTestCase {

    var viewModel: LoginViewModel!
    var authService: MockAuthService!
    var networkMonitor: MockNetworkMonitor!
    var tokenStorage: MockTokenStorage!

    override func setUp() {
        super.setUp()

        authService = MockAuthService()
        networkMonitor = MockNetworkMonitor()
        tokenStorage = MockTokenStorage()

        networkMonitor.isConnected = true

        viewModel = LoginViewModel(
            authService: authService,
            networkMonitor: networkMonitor,
            tokenStorage: tokenStorage
        )
    }

    override func tearDown() {
        viewModel = nil
        authService = nil
        networkMonitor = nil
        tokenStorage = nil
        super.tearDown()
    }

    // MARK: - Login Success
    func test_loginSuccess_withRememberMe_savesToken() async {
        authService.loginResult = .success("jwt-123")
        viewModel.username = "john"
        viewModel.password = "secret"
        viewModel.rememberMe = true

        await viewModel.login()

        XCTAssertEqual(viewModel.state, .success(token: "jwt-123"))
        XCTAssertEqual(tokenStorage.load(), "jwt-123")
        XCTAssertTrue(tokenStorage.wasSaveCalled)
    }

    func test_loginSuccess_withoutRememberMe_doesNotSaveToken() async {
        authService.loginResult = .success("token")
        viewModel.username = "a"
        viewModel.password = "b"
        viewModel.rememberMe = false

        await viewModel.login()

        XCTAssertEqual(viewModel.state, .success(token: "token"))
        XCTAssertNil(tokenStorage.load()) // nothing saved
        XCTAssertFalse(tokenStorage.wasSaveCalled)
    }

    // MARK: - Logout
    func test_logout_clearsToken_andResetsForm() async {

        authService.loginResult = .success("saved-token")
        viewModel.username = "user"
        viewModel.password = "pass"
        viewModel.rememberMe = true
        await viewModel.login()

    
        viewModel.logout()

        XCTAssertEqual(viewModel.state, .idle)
        XCTAssertTrue(viewModel.username.isEmpty)
        XCTAssertTrue(viewModel.password.isEmpty)
        XCTAssertFalse(viewModel.rememberMe)
        XCTAssertNil(tokenStorage.load()) // token cleared
        XCTAssertTrue(tokenStorage.wasClearCalled)
    }

    // MARK: - LockedOut
    func test_threeFailedLogins_locksUserOut() async {
        
        authService.loginResult = .failure(NSError(domain: "", code: 1))

        viewModel.username = "wrong"
        viewModel.password = "wrong"

        for _ in 1...3 {
            await viewModel.login()
        }

        XCTAssertEqual(viewModel.state, .lockedOut)
    }
    
    // MARK: - Offline
    func test_offline_showsOfflineState_andDoesNotCallAuthService() async {
        
        networkMonitor.isConnected = false

        await viewModel.login()

        XCTAssertEqual(viewModel.state, .offline)
        XCTAssertFalse(authService.wasLoginCalled)
    }
}
