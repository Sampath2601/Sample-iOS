//
//  LoginView.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//

import SwiftUI

/// Main login screen that binds directly to LoginViewModel
struct LoginView: View {

    @ObservedObject var vm: LoginViewModel

    var body: some View {
        // MARK: - Header
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            // MARK: - Username
            VStack(alignment: .leading, spacing: 4) {
                
                TextField("Username", text: $vm.username)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .accessibilityIdentifier("Username")
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(
                                vm.usernameError != nil ? .red : .gray,
                                lineWidth: 1)
                    )
                
                if let error = vm.usernameError {
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            // MARK: - Password
            VStack(alignment: .leading, spacing: 4) {
                
                SecureField("Password", text: $vm.password)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("Password")
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(
                                vm.passwordError != nil ? .red : .gray,
                                lineWidth: 1)
                    )
                
                if let error = vm.passwordError {
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            // MARK: - Remember Toggle
            Toggle("Remember Me", isOn: $vm.rememberMe)
                .accessibilityIdentifier("Remember Toggle")
            
            // MARK: - Login Button
            Button("Login") {
                Task { await vm.login() }
            }
            .disabled(!vm.isLoginButtonEnabled)
            .buttonStyle(.borderedProminent)
            .accessibilityIdentifier("Login_Btn")
            
            // MARK: - Status Feedback
            stateMessage
        }
        .padding()
    }

    // MARK: - State Message
    @ViewBuilder
    private var stateMessage: some View {
        switch vm.state {
        case .loading:
            ProgressView()
        case .error(let msg):
            Text(msg).foregroundColor(.red)
        case .offline:
            Text("No Internet Connection").foregroundColor(.orange)
        case .lockedOut:
            Text("Locked out after 3 failed attempts").foregroundColor(.red)
        default:
            EmptyView()
        }
    }
}

#Preview {
    ContentView()
}
