//
//  MockAuthService.swift
//  Sample
//
//  Created by Sampath Masapogu on 26/11/25.
//

import Foundation

class MockAuthService: AuthServiceProtocol {
    var loginResult: Result<String, Error> = .failure(NSError(domain: "", code: -1))
    var wasLoginCalled = false

    func login(username: String, password: String) async throws -> String {
        wasLoginCalled = true
        return try loginResult.get()
    }
}
