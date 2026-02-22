//
//  KudosType.swift
//  Chimes
//
//  Created by Arielle Nudelman on 2/22/26.
//

import Foundation

enum KudosType: String, CaseIterable, Identifiable {
    case star
    case heart
    case thumbsUp
    case clap

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .star: return "⭐️"
        case .heart: return "💖"
        case .thumbsUp: return "👍"
        case .clap: return "👏"
        }
    }
}
