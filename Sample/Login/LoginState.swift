//
//  LoginState.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//


import Foundation

/// Used for all states of the login flow
enum LoginState: Equatable {
    case idle
    case loading
    case success(token: String)
    case error(message: String)
    case lockedOut
    case offline
    case authToken
    case navigateHome
}
