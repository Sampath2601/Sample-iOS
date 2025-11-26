//
//  HomeView.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//


import SwiftUI

struct HomeView: View {

    let token: String
    let onLogout: () -> Void

    var body: some View {
        VStack(spacing: 20) {

            Text("Welcome!")
                .font(.largeTitle)
                .bold()

            Text("Authenticated Token:")
                .font(.headline)

            Text(token)
                .font(.caption)
                .padding()

            Button("Logout") {
                onLogout()
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .accessibilityIdentifier("Logout_Btn")
        }
        .padding()
    }
}

#Preview {
    HomeView(token: "demo_token", onLogout: {})
}
