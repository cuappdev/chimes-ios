//
//  AuthManager.swift
//  Chimes
//
//  Created by Jay on 3/18/26.
//

import FirebaseAuth
import GoogleSignIn
import FirebaseCore

@MainActor
@Observable
class AuthenticationManager {
    var isLoggedIn: Bool = false
    var isLoading: Bool = false

    private var authStateHandle: AuthStateDidChangeListenerHandle?

    init() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.isLoggedIn = user != nil
            }
        }
    }

func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard
            let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }),
            let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
            let topVC = keyWindow.rootViewController
        else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: topVC) { [weak self] result, error in
            guard error == nil else {
                print("Google Sign-In Error: \(error!.localizedDescription)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else { return }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            DispatchQueue.main.async { self?.isLoading = true }

            Auth.auth().signIn(with: credential) { [weak self] result, error in
                DispatchQueue.main.async { self?.isLoading = false }
                if let error = error {
                    print("Firebase Auth Error: \(error.localizedDescription)")
                    return
                }
                print("Successfully signed into Firebase!")
            }
        }
    }

    func signInAnonymously() {
        DispatchQueue.main.async { self.isLoading = true }
        
        Auth.auth().signInAnonymously { result, error in
            if let error = error {
                print("Anonymous Sign-In Error: \(error.localizedDescription)")
                return
            }
        }
    }
}
