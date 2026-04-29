//
//  SelectedSongCard.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/29/26.
//

import SwiftUI

/// Larger pill-style card shown inside the Custom Song Request container
/// after the user confirms a selection from the autocomplete dropdown
/// (by pressing return or dismissing focus). Tapping the cancel icon
/// returns the user to the empty input state.
struct SelectedSongCard: View {
    let song: RequestedSong
    let onCancel: () -> Void

    private let background = Color(red: 238 / 255, green: 204 / 255, blue: 198 / 255)
    private let border     = Color(red: 251 / 255, green: 244 / 255, blue: 244 / 255)

    var body: some View {
        HStack(spacing: 0) {
            artwork
                .frame(width: 75, height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            VStack(alignment: .leading, spacing: 0) {
                Text(song.title)
                    .font(Font.custom("Montserrat-Medium", size: 24))
                    .tracking(-0.72)
                    .foregroundStyle(Color("PrimaryText"))

                Text(song.artist)
                    .font(Font.custom("Montserrat-Medium", size: 15))
                    .tracking(-0.45)
                    .foregroundStyle(Color("PrimaryText"))
            }
            .padding(.leading, 16)

            Spacer(minLength: 25)

            Button(action: onCancel) {
                Image("CancelIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 17)
        .padding(.vertical, 6)
        .frame(width: 311, height: 108)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(background)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(border, lineWidth: 1)
        )
    }

    @ViewBuilder
    private var artwork: some View {
        if let name = song.artworkAssetName, UIImage(named: name) != nil {
            Image(name)
                .resizable()
                .scaledToFill()
        } else {
            Color(.lightGray)
        }
    }
}
