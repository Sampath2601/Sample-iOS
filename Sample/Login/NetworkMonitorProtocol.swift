//
//  NetworkMonitorProtocol.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//


import Foundation

/// Protocol defining the network status of user
protocol NetworkMonitorProtocol {
    var isConnected: Bool { get }
}


/// Network monitor with support for forced offline mode in UI tests
final class NetworkMonitor: NetworkMonitorProtocol {
    
    var isConnected: Bool

        init() {
            // Check UI test environment variable
            if ProcessInfo.processInfo.environment["OFFLINE_MODE"] == "1" {
                isConnected = false
            } else {
                isConnected = true
            }
        }
}
