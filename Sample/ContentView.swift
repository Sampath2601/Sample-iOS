//
//  ContentView.swift
//  Sample
//
//  Created by Sampath Masapogu on 24/11/25.
//

import SwiftUI

/// Root coordinator view that manages authentication flow and navigation
struct ContentView: View {
    
    // MARK: - ViewModel & Dependencies
    @StateObject private var vm = LoginViewModel(
        authService: AuthService(),
        networkMonitor: NetworkMonitor(),
        tokenStorage: TokenStorage()
    )
    
    // MARK: - Navigation State
    @State private var navPath = NavigationPath()
    
    
    var body: some View {
        NavigationStack(path: $navPath) {
            
            // MARK: - Navigate to Home on successful login
            LoginView(vm: vm)
                .navigationDestination(for: HomeViewNavData.self) { data in
                    HomeView(
                        token: data.token,
                        onLogout: {
                            vm.logout()
                            navPath = NavigationPath()  // Go back to login
                        }
                    )
                }
            // MARK: - Auto-login: Check for existing token on launch
                .onAppear {
                    // If token exists in storage, navigate to HomeView immediately
                    if let token = vm.tokenStorage.load() {
                        navPath.append(HomeViewNavData(token: token))
                    }
                }
            // MARK: - React to successful login from ViewModel
                .onChange(of: vm.state) { newState in
                    if case .success(let token) = newState {
                        navPath.append(HomeViewNavData(token: token))
                    }
                }
        }
    }
}


#Preview {
    ContentView()
}
