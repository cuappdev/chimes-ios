//
//  HomeViewModel.swift
//  Chimes
//
//  Created by Arielle Nudelman on 2/22/26.
//

import Foundation
import Observation

@Observable
final class HomeViewModel {
    var username: String = "Arielle"
    var guessText: String = ""

    var performances: [PerformanceSlot] = [
        .init(label: "Morning", timeRange: "7:45 AM - 8:00 AM"),
        .init(label: "Noon", timeRange: "1:10 PM - 1:25 PM"),
        .init(label: "Evening", timeRange: "6:00 PM - 6:15 PM")
    ]

    func tapKudos(_ type: KudosType) {
        // TODO: hook up backend/state
        print("Kudos:", type)
    }

    func guessMore() {
        // TODO: expand UI
        print("Guess more")
    }

    func submitGuess() {
        // TODO: validate + submit
        print("Submit guess:", guessText)
    }

    func openMusic() {
        // TODO: navigation
        print("Open music")
    }

    func openRSVP() {
        // TODO: navigation
        print("Open RSVP")
    }
}
