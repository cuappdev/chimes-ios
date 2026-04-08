//
//  HomeBackgroundView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 2/22/26.
//

import SwiftUI

struct HomeBackgroundView: View {
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

    private var skyAssetName: String {
        switch currentTimeOfDay() {
        case .day: return "SkyDay"
        case .sunset: return "SkySunset"
        case .night: return "SkyNight"
        }
    }

    private var slopeAssetName: String {
        switch currentTimeOfDay() {
        case .day: return "SlopeDay"
        case .sunset: return "SlopeSunset"
        case .night: return "SlopeNight"
        }
    }

    private var towerAssetName: String {
        switch currentTimeOfDay() {
        case .day: return "TowerOriginal"
        case .sunset: return "TowerSunset"
        case .night: return "TowerNight"
        }
    }
    
    private var isNight: Bool {
        if case .night = currentTimeOfDay() { return true }
        return false
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {

                // Sky background (replaces gradient)
                Image(skyAssetName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: 411)
                    .clipped()
                    .offset(x: 0, y: 0)
                
                // Tower placement values
                let towerW: CGFloat = 164
                let towerX = geo.size.width - 29 - towerW
                let towerY: CGFloat = 165
                
                // Slope
                Image(slopeAssetName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: 594)
                    .clipped()
                    .offset(x: 0, y: 289)
                
                // City lights
                if isNight {
                    Image("CityLights")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 167, height: 78)
                        .offset(x: 2, y: 328)
                        .shadow(color: .black.opacity(0.18), radius: 2, x: 0, y: 1)
                }
                
                // Notes emitter
                ClocktowerNotesEmitterView(
                    spawnPoint: CGPoint(x: towerX + 118, y: towerY + 128),
                    topBoundaryEnd: CGPoint(x: 28, y: 70),
                    bottomBoundaryEnd: CGPoint(x: 12, y: 520),
                    spawnInterval: 0.55
                )

                // TreesFront
                if !isNight {
                    Image("TreesFront")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 172.00005, height: 102.7138)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                        .offset(
                            x: -17,
                            y: 324
                        )
                }

                // TreesBack
                if !isNight {
                    Image("TreesBack")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 68.00006, height: 58.7138)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                        .offset(
                            x: geo.size.width - 320 - 68.00006, // right = 320
                            y: 346
                        )
                }

                // Tower
                Image(towerAssetName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 164, height: 224)
                    .offset(
                        x: geo.size.width - 29 - 164,
                        y: 165
                    )
                    .shadow(color: .black.opacity(0.13), radius: 2, x: 1, y: 2)

            }
            .ignoresSafeArea()
        }
    }
}

