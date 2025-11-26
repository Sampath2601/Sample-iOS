//
//  MockTokenStorage.swift
//  Sample
//
//  Created by Sampath Masapogu on 26/11/25.
//

import Foundation

class MockTokenStorage: TokenStorageProtocol {

    private var storedToken: String?

    var wasSaveCalled = false
    var wasClearCalled = false

    func save(token: String) {
        storedToken = token
        wasSaveCalled = true
    }

    func load() -> String? {
        storedToken
    }

    func clear() {
        storedToken = nil
        wasClearCalled = true
    }
}
