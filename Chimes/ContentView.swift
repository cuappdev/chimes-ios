//
//  ContentView.swift
//  Chimes
//
//  Created by Jay on 2/18/26.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: LoginViewModel

    init(authManager: AuthenticationManager) {
        _viewModel = State(initialValue: LoginViewModel(authManager: authManager))
    }

    var body: some View {
        Group {
            if viewModel.loggedIn {
                HomeView()
            } else {
                LoginView(viewModel: viewModel)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.loggedIn)
    }
}

#Preview {
    ContentView(authManager: AuthenticationManager())
}
