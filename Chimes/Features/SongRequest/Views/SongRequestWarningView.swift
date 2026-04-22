//
//  SongRequestWarningView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import SwiftUI

struct SongRequestWarningView: View {
    var body: some View {
        HStack(spacing: 20) {
            Image("WarningIcon")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundStyle(Color("icons"))

            warningText
                .lineSpacing(5) // 20pt line-height − 15pt font = 5pt extra
                .frame(width: 246, alignment: .leading)
        }
        .padding(.horizontal, 19)
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 58)
        .background(GlassContainerBackground())
        .padding(.horizontal, 21)
    }

    private var warningText: Text {
        Text("Warning: ")
            .font(Font.custom("Inter", size: 15).weight(.bold))
            .tracking(-0.6)
            .foregroundColor(Color("icons"))
        + Text("custom requests may not always be selected for performance!")
            .font(Font.custom("Inter", size: 15).weight(.regular))
            .tracking(-0.6)
            .foregroundColor(Color("icons"))
    }
}
