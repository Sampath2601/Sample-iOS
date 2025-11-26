//
//  LoginViewModel.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//

import Foundation
import Combine

/// ViewModel responsible for login form logic, validation, and authentication flow
@MainActor
final class LoginViewModel: ObservableObject {

    
    @Published var username = ""
    @Published var password = ""
    @Published var rememberMe = false

    @Published var isLoginButtonEnabled = false
    @Published var state: LoginState = .idle
    
    @Published var usernameError: String? = nil
    @Published var passwordError: String? = nil
    @Published var isUsernameValid = false
    @Published var isPasswordValid = false


    private var failureCount = 0
    private let maxFailures = 3

    private let authService: AuthServiceProtocol
    private let networkMonitor: NetworkMonitorProtocol
    internal let tokenStorage: TokenStorageProtocol
    
    private var cancellables = Set<AnyCancellable>()


    init(
        authService: AuthServiceProtocol,
        networkMonitor: NetworkMonitorProtocol,
        tokenStorage: TokenStorageProtocol
    ) {
        self.authService = authService
        self.networkMonitor = networkMonitor
        self.tokenStorage = tokenStorage
        
        // Validate username
        $username
            .sink { [weak self] text in
                guard let self = self else { return }
                if text.isEmpty {
                    self.usernameError = nil
                    self.isUsernameValid = false
                } else if text.count > 10 {
                    self.usernameError = "Invalid Username"
                    self.isUsernameValid = false
                } else {
                    self.usernameError = nil
                    self.isUsernameValid = true
                }
            }
            .store(in: &cancellables)
        
        // Validate username
        $password
            .sink { [weak self] text in
                guard let self = self else { return }
                if text.isEmpty {
                    self.passwordError = nil
                    self.isPasswordValid = false
                } else if text.count >= 10 {
                    self.passwordError = "Invalid Password"
                    self.isPasswordValid = false
                } else {
                    self.passwordError = nil
                    self.isPasswordValid = true
                }
            }
            .store(in: &cancellables)
        
        // Enable login button only when both fields are valid
        $isUsernameValid.combineLatest($isPasswordValid)
            .map { $0 && $1 }
            .assign(to: &$isLoginButtonEnabled)
    }
    
    /// Attempts login. Skips if already locked out.
    func login() async {
        guard state != .lockedOut else { return }
        
        // Offline Checking
        if !networkMonitor.isConnected {
            state = .offline
            return
        }

        state = .loading

        do {
            let token = try await authService.login(
                username: username,
                password: password
            )

            if rememberMe {
                tokenStorage.save(token: token)
            }

            failureCount = 0
            state = .success(token: token)

        } catch {
            failureCount += 1
            state = failureCount >= maxFailures
                ? .lockedOut
                : .error(message: "Invalid Credentials (\(failureCount)/3)")
        }
    }
    
    /// Clears session and resets form
    func logout() {
        tokenStorage.clear()
        state = .idle
        username = ""
        password = ""
        rememberMe = false
    }
}
