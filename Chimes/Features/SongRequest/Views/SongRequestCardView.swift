//
//  SongRequestCardView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import SwiftUI

struct SongRequestCardView: View {
    @Binding var songText: String

    /// Songs offered as autocomplete suggestions while the user types.
    var suggestions: [RequestedSong] = []

    @State private var selectedSongID: RequestedSong.ID?
    @State private var confirmedSong: RequestedSong?
    @FocusState private var isInputFocused: Bool

    private let secondaryTextColor = Color(red: 0x5B / 255.0,
                                           green: 0x48 / 255.0,
                                           blue: 0x48 / 255.0)

    private let inputPlaceholderColor = Color(red: 0xA3 / 255.0,
                                              green: 0xA3 / 255.0,
                                              blue: 0xA3 / 255.0)

    private var filteredSuggestions: [RequestedSong] {
        let query = songText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return [] }
        return suggestions.filter { song in
            song.title.localizedCaseInsensitiveContains(query)
                || song.artist.localizedCaseInsensitiveContains(query)
        }
    }

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

            if let song = confirmedSong {
                SelectedSongCard(song: song, onCancel: clearSelection)
                    .padding(.top, 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                songInput
                    .padding(.top, 18)
                    .overlay(alignment: .bottom) {
                        suggestionDropdown
                            .alignmentGuide(.bottom) { _ in 0 }
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 18, leading: 20, bottom: 12, trailing: 20))
        .frame(minHeight: 151)
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
                .focused($isInputFocused)
                .submitLabel(.done)
                .onSubmit(commitSelection)
                .onChange(of: isInputFocused) { _, focused in
                    if !focused { commitSelection() }
                }
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

    @ViewBuilder
    private var suggestionDropdown: some View {
        let matches = filteredSuggestions
        if !matches.isEmpty {
            VStack(spacing: 0) {
                ForEach(matches) { song in
                    SongSuggestionRow(
                        song: song,
                        isSelected: selectedSongID == song.id
                    ) {
                        selectedSongID = song.id
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
            .frame(maxWidth: .infinity)
            .transition(.opacity.combined(with: .move(edge: .top)))
        }
    }

    // MARK: - Selection lifecycle

    private func commitSelection() {
        guard let id = selectedSongID,
              let song = suggestions.first(where: { $0.id == id })
        else { return }
        confirmedSong = song
        songText = song.title
    }

    private func clearSelection() {
        confirmedSong = nil
        selectedSongID = nil
        songText = ""
    }
}
