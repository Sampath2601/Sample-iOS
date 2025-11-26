//
//  TokenStorageProtocol.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//


import Foundation

protocol TokenStorageProtocol {
    func save(token: String)
    func load() -> String?
    func clear()
}

final class TokenStorage: TokenStorageProtocol {

    private let key = "auth_token"

    func save(token: String) {
        UserDefaults.standard.set(token, forKey: key)
    }

    func load() -> String? {
        UserDefaults.standard.string(forKey: key)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
