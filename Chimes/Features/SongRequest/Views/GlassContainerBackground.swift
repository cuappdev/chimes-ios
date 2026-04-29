//
//  GlassContainerBackground.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import SwiftUI

/// 3-layer Glass UI background, matching the Chimes glass spec:
///   • Last layer  – native Liquid Glass material.
///   • Middle layer – `#FFF3F3` @ 36% over `#1E0303` @ 78% (Color Dodge).
///   • Top layer    – `#ED9F9F` @ 8% bloom with Hard Light + layer blur.
///
/// Use this when a view needs to apply only the glass *background* (without
/// `GlassCard`'s padding and drop-shadow chrome).
struct GlassContainerBackground: View {
    var cornerRadius: CGFloat = 12

    private let middleLight = Color(red: 255 / 255, green: 243 / 255, blue: 243 / 255) // #FFF3F3
    private let middleDark  = Color(red:  30 / 255, green:   3 / 255, blue:   3 / 255) // #1E0303
    private let topBloom    = Color(red: 237 / 255, green: 159 / 255, blue: 159 / 255) // #ED9F9F

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        Color.clear
            .glassEffect(.regular, in: shape)
            .overlay {
                // No `compositingGroup()` here — letting Color Dodge / Hard Light
                // blend against the glass-rendered pixels matches Figma's stacking
                // and avoids the dark-mauve collapse you get from blending against
                // transparent.
                ZStack {
                    shape.fill(middleLight.opacity(0.36))

                    shape
                        .fill(middleDark.opacity(0.78))
                        .blendMode(.colorDodge)

                    shape
                        .fill(topBloom.opacity(0.08))
                        .blendMode(.hardLight)
                        .blur(radius: 20)
                }
                .clipShape(shape)
                .allowsHitTesting(false)
            }
    }
}
