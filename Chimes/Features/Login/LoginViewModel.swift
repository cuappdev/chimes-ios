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
    var loggedIn: Bool = false
    
    // TODO: Authentication stuff
    
    init() { }
    
    // Dummy for now, replace with login() functino after auth set up
    func logIn() {
        loggedIn = true
    }
    
}
