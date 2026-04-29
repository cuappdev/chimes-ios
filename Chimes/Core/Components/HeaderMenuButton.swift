//
//  HeaderMenuButton.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/29/26.
//

import SwiftUI

/// Top-right burger button used by the Home and Song Request headers.
///
/// Tapping the burger toggles a small dropdown panel anchored to the button's
/// top edge. Tapping anywhere outside the panel dismisses it.
struct HeaderMenuButton: View {
    let onRSVP: () -> Void
    let onMusic: () -> Void
    var onBell: () -> Void = {}
    var onSettings: () -> Void = {}

    @State private var isOpen = false

    var body: some View {
        Button(action: toggle) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.65))
                    .shadow(color: .black.opacity(0.13), radius: 2, x: 1, y: 2)

                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.8))
            }
            .frame(width: 44, height: 44)
        }
        .buttonStyle(.plain)
        .overlay(alignment: .topTrailing) {
            if isOpen {
                ZStack(alignment: .topTrailing) {
                    // Tap-outside-to-close scrim covering the whole screen.
                    Color.clear
                        .contentShape(Rectangle())
                        .ignoresSafeArea()
                        .onTapGesture { close() }

                    dropdown
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }

    private var dropdown: some View {
        VStack(spacing: 10) {
            Button(action: { close(); onRSVP() }) {
                Image("RSVP")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.plain)

            Button(action: { close(); onMusic() }) {
                Image("SongRequest")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.plain)

            Button(action: { close(); onBell() }) {
                Image(systemName: "bell")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(.black.opacity(0.85))
                    .frame(width: 28, height: 28)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.plain)

            Button(action: { close(); onSettings() }) {
                Image(systemName: "gearshape")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(.black.opacity(0.85))
                    .frame(width: 28, height: 28)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 19)
        .padding(.horizontal, 16)
        .background(Color.white.opacity(0.65))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.13), radius: 8, x: 0, y: 8)
    }

    private func toggle() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            isOpen.toggle()
        }
    }

    private func close() {
        withAnimation(.easeOut(duration: 0.2)) {
            isOpen = false
        }
    }
}
