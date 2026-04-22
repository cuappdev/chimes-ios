//
//  SongRequestView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import SwiftUI

struct SongRequestView: View {
    @State private var songText: String = ""

    // Placeholder data until a backend is wired in.
    private let recentlyRequested: [RequestedSong] = [
        .init(title: "SOS", artist: "sza", artworkAssetName: nil),
        .init(title: "SOS", artist: "sza", artworkAssetName: nil),
        .init(title: "SOS", artist: "sza", artworkAssetName: nil),
        .init(title: "SOS", artist: "sza", artworkAssetName: nil)
    ]

    var body: some View {
        ZStack(alignment: .topLeading) {
            SongRequestBackgroundView()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    SongRequestHeaderView()

                    SongRequestWarningView()
                        .padding(.top, 36)

                    SongRequestCardView(songText: $songText)
                        .padding(.top, 28)

                    RecentlyRequestedSongsView(songs: recentlyRequested)
                        .padding(.top, 28)

                    SongRequestSubmitButton(action: submitRequest)
                        .padding(.top, 36)
                }
                .padding(.top, 95)
                .padding(.bottom, 45)
            }
            .ignoresSafeArea(.container, edges: .top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    private func submitRequest() {
        // TODO: validate + hand the song text off to backend.
        print("Submit song request:", songText)
    }
}

#Preview {
    SongRequestView()
}
