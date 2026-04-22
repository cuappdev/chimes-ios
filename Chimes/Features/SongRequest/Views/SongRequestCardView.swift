//
//  SongRequestCardView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import SwiftUI

struct SongRequestCardView: View {
    @Binding var songText: String

    private let secondaryTextColor = Color(red: 0x5B / 255.0,
                                           green: 0x48 / 255.0,
                                           blue: 0x48 / 255.0)

    private let inputPlaceholderColor = Color(red: 0xA3 / 255.0,
                                              green: 0xA3 / 255.0,
                                              blue: 0xA3 / 255.0)

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Custom Song Request")
                .font(Font.custom("Montserrat-Medium", size: 18))
                .tracking(-0.54)
                .foregroundStyle(Color("PrimaryText"))

            Text("Add your song to the tower playlist")
                .font(Font.custom("Inter", size: 15).weight(.regular))
                .tracking(-0.6)
                .foregroundStyle(secondaryTextColor)
                .padding(.top, 7)

            songInput
                .padding(.top, 18)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 18, leading: 20, bottom: 12, trailing: 20))
        .frame(height: 151)
        .background(GlassContainerBackground())
        .padding(.horizontal, 21)
    }

    private var songInput: some View {
        ZStack(alignment: .leading) {
            if songText.isEmpty {
                Text("Enter a song...")
                    .font(Font.custom("Inter", size: 15).weight(.regular))
                    .tracking(-0.45)
                    .foregroundStyle(inputPlaceholderColor)
            }

            TextField("", text: $songText)
                .font(Font.custom("Inter", size: 15).weight(.regular))
                .tracking(-0.45)
                .foregroundStyle(Color("PrimaryText"))
                .textFieldStyle(.plain)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 41)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color("Stroke"), lineWidth: 1)
        )
    }
}
