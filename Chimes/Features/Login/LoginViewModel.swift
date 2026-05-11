//
//  LoginViewModel.swift
//  Chimes
//
//  Created by Jay on 3/4/26.
//

import Foundation
import SwiftUI

@MainActor
@Observable
class LoginViewModel {
    var path = NavigationPath()

    var loggedIn: Bool {
        authManager.isLoggedIn
    }

    let authManager: AuthenticationManager

    init(authManager: AuthenticationManager) {
        self.authManager = authManager
    }

    func logIn() {
        authManager.signInWithGoogle()
    }

    func logInAsGuest() {
        authManager.signInAnonymously()
    }

}
