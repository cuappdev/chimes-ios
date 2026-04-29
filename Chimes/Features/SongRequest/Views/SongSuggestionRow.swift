//
//  SongSuggestionRow.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/29/26.
//

import SwiftUI

/// Single row in the autocomplete dropdown that appears beneath the
/// "Custom Song Request" input as the user types.
struct SongSuggestionRow: View {
    let song: RequestedSong
    let isSelected: Bool
    let onTap: () -> Void

    private let rowBackground = Color(red: 238 / 255, green: 204 / 255, blue: 198 / 255).opacity(0.95)
    private let rowBorder     = Color(red: 251 / 255, green: 244 / 255, blue: 244 / 255)

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 0) {
                HStack(spacing: 12) {
                    artwork
                        .frame(width: 46, height: 46)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                    VStack(alignment: .leading, spacing: 0) {
                        Text(song.title)
                            .font(Font.custom("Montserrat-Medium", size: 15))
                            .tracking(-0.45)
                            .foregroundStyle(Color("PrimaryText"))
                            .frame(width: 100, height: 17, alignment: .leading)

                        Text(song.artist)
                            .font(Font.custom("Montserrat-Medium", size: 10))
                            .tracking(-0.3)
                            .foregroundStyle(Color("SecondaryText"))
                            .frame(height: 13, alignment: .leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                Spacer(minLength: 0)

                Image(isSelected ? "RadioSelected" : "RadioUnselected")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity)
            .frame(height: 62)
            .background(rowBackground)
            .overlay(
                Rectangle().stroke(rowBorder, lineWidth: 0.5)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
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
