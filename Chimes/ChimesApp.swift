//
//  ChimesApp.swift
//  Chimes
//
//  Created by Jay on 2/18/26.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct ChimesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var authManager: AuthenticationManager

    init() {
        FirebaseApp.configure()
        _authManager = State(initialValue: AuthenticationManager())
    }

    var body: some Scene {
        WindowGroup {
            ContentView(authManager: authManager)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
