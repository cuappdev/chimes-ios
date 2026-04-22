//
//  RequestedSong.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import Foundation

struct RequestedSong: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let artist: String
    /// Optional asset name; nil falls back to the lightgray placeholder.
    let artworkAssetName: String?
}
