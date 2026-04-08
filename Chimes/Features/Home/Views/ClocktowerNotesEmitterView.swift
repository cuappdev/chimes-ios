//
//  ClocktowerNotesEmitterView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 2/24/26.
//

import SwiftUI

struct ClocktowerNotesEmitterView: View {
    let spawnPoint: CGPoint
    let topBoundaryEnd: CGPoint
    let bottomBoundaryEnd: CGPoint
    var spawnInterval: Double = 0.55

    @State private var notes: [Note] = []

    struct Note: Identifiable {
        let id = UUID()
        let assetName: String
        let rotation: Double
        let duration: Double
        let start: CGPoint
        let end: CGPoint
    }

    var body: some View {
        ZStack {
            ForEach(notes) { note in
                FloatingNote(note: note)
            }
        }
        .allowsHitTesting(false)
        .onAppear { startSpawning() }
    }

    // MARK: - Spawn loop

    private func startSpawning() {
        Timer.scheduledTimer(withTimeInterval: spawnInterval, repeats: true) { _ in
            spawnOne()
        }
    }

    private func spawnOne() {
        let assets = assetsForCurrentTimeOfDay()

        let note = Note(
            assetName: assets.randomElement()!,
            rotation: Double.random(in: -20...25),
            duration: Double.random(in: 3.2...4.6),
            start: spawnPoint,
            end: randomEndPointOffScreenLeft()
        )

        notes.append(note)

        // Remove after it is off-screen
        DispatchQueue.main.asyncAfter(deadline: .now() + note.duration + 0.2) {
            notes.removeAll { $0.id == note.id }
        }
    }

    // MARK: - Assets by time of day

    private enum TimeOfDay {
        case day
        case sunset
        case night
    }

    private func currentTimeOfDay(date: Date = Date(), calendar: Calendar = .current) -> TimeOfDay {
        let hour = calendar.component(.hour, from: date)
        switch hour {
        case 6..<17:
            return .day
        case 17..<20:
            return .sunset
        default:
            return .night
        }
    }

    private func assetsForCurrentTimeOfDay() -> [String] {
        switch currentTimeOfDay() {
        case .day:
            return ["MusicDay1", "MusicDay2", "MusicDay3"]
        case .sunset:
            return ["MusicSunset1", "MusicSunset2", "MusicSunset3"]
        case .night:
            return ["MusicNight1", "MusicNight2", "MusicNight3"]
        }
    }

    // MARK: - End point math

    private func randomEndPointOffScreenLeft() -> CGPoint {
        // Always end off-screen left
        let endX = CGFloat.random(in: -70 ... -25)

        // Find the wedge's y-range at that x using the two boundary lines
        let yTop = yOnLine(from: spawnPoint, to: topBoundaryEnd, atX: endX)
        let yBottom = yOnLine(from: spawnPoint, to: bottomBoundaryEnd, atX: endX)

        var low = min(yTop, yBottom)
        var high = max(yTop, yBottom)

        // Keep it from going too far down
        high = min(high, spawnPoint.y + 160)

        // If range is weirdly tiny, just use the midpoint
        if low >= high { return CGPoint(x: endX, y: (yTop + yBottom) / 2) }

        // Bias toward the top part of the wedge
        let y = biasedTowardTop(low: low, high: high)

        return CGPoint(x: endX, y: y)
    }

    private func yOnLine(from p0: CGPoint, to p1: CGPoint, atX x: CGFloat) -> CGFloat {
        let dx = p1.x - p0.x
        if abs(dx) < 0.0001 { return p0.y }
        let t = (x - p0.x) / dx
        return p0.y + t * (p1.y - p0.y)
    }

    private func biasedTowardTop(low: CGFloat, high: CGFloat) -> CGFloat {
        let u = CGFloat.random(in: 0...1)
        let power: CGFloat = 1.8
        let biased = pow(u, power)
        return low + (high - low) * biased
    }
}

private struct FloatingNote: View {
    let note: ClocktowerNotesEmitterView.Note
    @State private var animate = false

    var body: some View {
        Image(note.assetName)
            .resizable()
            .scaledToFit()
            .frame(width: 27.4598, height: 29.99999)
            .rotationEffect(.degrees(note.rotation))
            .shadow(color: .black.opacity(0.11), radius: 2, x: 0, y: 1)
            .position(x: animate ? note.end.x : note.start.x,
                      y: animate ? note.end.y : note.start.y)
            .onAppear {
                withAnimation(.easeOut(duration: note.duration)) {
                    animate = true
                }
            }
    }
}
