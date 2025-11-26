//
//  AuthServiceProtocol.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//


import Foundation

/// Protocol defining the authentication of user
protocol AuthServiceProtocol {
    func login(username: String, password: String) async throws -> String
}

/// Simulates network delay and validates credentials
final class AuthService: AuthServiceProtocol {

    func login(username: String, password: String) async throws -> String {
        try await Task.sleep(nanoseconds: 500_000_000)

        if username == "test" && password == "password" {
            return "fake_token_123"
        }
        
        throw NSError(domain: "AuthError", code: 401)
    }
}
