//
//  SplashScreen.swift
//  Chimes
//
//  Created by Jay on 3/3/26.
//

import SwiftUI

struct LoginView: View {
    // 0 = Logo, 1 = Logo + Name, 2 = Logo + name + log in
    @State private var animationPhase = 0
    @State var viewModel: LoginViewModel

    var body: some View {
        ZStack {
            Color("BubblePink")
                .ignoresSafeArea()

            VStack {
                Spacer()

                // 0. Logo (Always visible)
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: animationPhase == 0 ? 120 : 69,
                        height: animationPhase == 0 ? 120 : 69
                    )

                // 1. App Name Appears
                if animationPhase >= 1 {
                    Text("chimes")
                        .font(.system(size: 32, weight: .regular))
                        .foregroundColor(Color.splashText)
                        .padding(.top, 8)
                        .transition(.opacity)
                }

                // 2. Login Buttons Appears
                if animationPhase == 2 {
                    VStack {
                        Button("Log-in with Cornell netID") {
                            // TODO:
                            viewModel.logIn()
                        }
                        .buttonStyle(WhitePillButtonStyle())

                        // Your horizontal line
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 0.5)
                            .frame(width: 196)
                            .padding(.vertical, 36)

                        Button("log in without an account") {
                            // TODO
                            viewModel.logIn()
                        }
                        .font(.caption)
                        .underline()
                        .foregroundColor(.gray)
                    }
                    .padding(.top, 40)
                    .transition(
                        .opacity.combined(with: .move(edge: .bottom))
                    )
                }

                Spacer()
            }
            .onAppear {
                // Animate to show App Name
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeIn(duration: 0.8)) {
                        animationPhase = 1
                    }
                }

                // Animate to show log in buttons
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(
                        .spring(response: 0.6, dampingFraction: 0.8)
                    ) {
                        animationPhase = 2
                    }
                }
            }

        }
    }
}

struct WhitePillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 14)
            .padding(.horizontal, 24)
            .background(Color.white)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
