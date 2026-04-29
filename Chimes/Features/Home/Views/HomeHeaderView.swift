//
//  HomeHeaderView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 2/22/26.
//

import SwiftUI

struct HomeHeaderView: View {
    let username: String
    let onMusic: () -> Void
    let onRSVP: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            // Left side: greeting
            HStack(spacing: 0) {
                Text("Hi, \(username)")
                    .font(Font.custom("Articulat CF", size: 36))
                    .foregroundStyle(.primaryText)

                Text(" ☀️")
                    .font(Font.custom("Articulat CF", size: 36))
            }

            Spacer(minLength: 0) // Auto spacing

            // Right side: burger menu
            HeaderMenuButton(onRSVP: onRSVP, onMusic: onMusic)
        }
        .padding(.horizontal, 21)
    }
}
