//
//  SongRequestHeaderView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import SwiftUI

struct SongRequestHeaderView: View {
    private let headerColor = Color(red: 0x4F / 255.0,
                                    green: 0x4E / 255.0,
                                    blue: 0x4E / 255.0)

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Song Request")
                .font(DesignConstants.Fonts.H1)
                .tracking(-1.8)
                .foregroundStyle(headerColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 115)

            Text("Chime in with your own track!")
                .font(DesignConstants.Fonts.H3Medium)
                .lineSpacing(4)
                .foregroundStyle(headerColor)
        }
        .padding(.horizontal, 21)
    }
}
