//
//  RequestedSongCardView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import SwiftUI

struct RequestedSongCardView: View {
    let song: RequestedSong

    private let secondaryTextColor = Color(red: 0x5B / 255.0,
                                           green: 0x48 / 255.0,
                                           blue: 0x48 / 255.0)

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            artwork
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            Text(song.title)
                .font(Font.custom("Montserrat-Medium", size: 15))
                .tracking(-0.45)
                .foregroundStyle(Color("PrimaryText"))
                .frame(width: 100, height: 17, alignment: .leading)
                .padding(.top, 12)

            Text(song.artist)
                .font(Font.custom("Montserrat-Medium", size: 10))
                .tracking(-0.3)
                .foregroundStyle(secondaryTextColor)
                .frame(height: 13, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color("Stroke"))
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
