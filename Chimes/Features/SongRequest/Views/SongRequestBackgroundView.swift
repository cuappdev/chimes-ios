//
//  SongRequestBackgroundView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import SwiftUI

struct SongRequestBackgroundView: View {
    var body: some View {
        LinearGradient(
            stops: [
                .init(color: Color("BubbleWhite"), location: 0.0161),
                .init(color: Color("BubbleBlush"), location: 0.6433),
                .init(color: Color("BubbleRose"),  location: 0.8976)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
