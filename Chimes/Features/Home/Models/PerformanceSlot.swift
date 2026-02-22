//
//  PerformanceSlot.swift
//  Chimes
//
//  Created by Arielle Nudelman on 2/22/26.
//

import Foundation

struct PerformanceSlot: Identifiable, Equatable {
    let id = UUID()
    let label: String        // ex. "Morning"
    let timeRange: String
}
