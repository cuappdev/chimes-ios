//
//  RecentlyRequestedSongsView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import SwiftUI

struct RecentlyRequestedSongsView: View {
    let songs: [RequestedSong]

    private let secondaryTextColor = Color(red: 0x5B / 255.0,
                                           green: 0x48 / 255.0,
                                           blue: 0x48 / 255.0)

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Recently Requested Songs")
                .font(Font.custom("Montserrat-Medium", size: 18))
                .tracking(-0.54)
                .foregroundStyle(Color("PrimaryText"))

            Text("Fresh chimes from the crowd")
                .font(Font.custom("Inter", size: 15).weight(.regular))
                .tracking(-0.6)
                .foregroundStyle(secondaryTextColor)
                .padding(.top, 7)

            carousel
                .padding(.top, 18)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 18, leading: 20, bottom: 12, trailing: 20))
        .frame(height: 274)
        .background(GlassContainerBackground())
        .padding(.horizontal, 21)
    }

    private var carousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(songs) { song in
                    RequestedSongCardView(song: song)
                }
            }
        }
    }
}
