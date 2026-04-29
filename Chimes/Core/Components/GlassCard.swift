//
//  GlassCard.swift
//  Chimes
//
//  Created by Arielle Nudelman on 2/22/26.
//

import SwiftUI

/// Chimes-specific Glass UI container.
///
/// Inspired by Apple's Liquid Glass but customized for Chimes. Composed of
/// three stacked layers (rendered back-to-front):
///   1. Last layer  – native Liquid Glass material (refraction / depth / frost).
///   2. Middle layer – warm fills: `#FFF3F3` @ 36% over `#1E0303` @ 78% with
///      Color Dodge blending.
///   3. Top layer    – `#ED9F9F` @ 8% pink bloom with Hard Light blending and
///      a heavy layer blur.
///
/// Note: this layered system applies to all Chimes glass surfaces *except*
/// circular buttons (see `GlassCircle`). We intentionally don't apply a
/// SwiftUI `.shadow` modifier here — that would rasterize the glass into an
/// offscreen layer and cause Color Dodge / Hard Light to collapse to dark
/// muddy output. Liquid Glass already provides intrinsic depth.
struct GlassCard<Content: View>: View {
    let cornerRadius: CGFloat
    let content: Content

    init(cornerRadius: CGFloat = 12, @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.content = content()
    }

    var body: some View {
        content
            .padding(.vertical, 14)
            .padding(.horizontal, 22)
            .background {
                GlassBackground(cornerRadius: cornerRadius)
            }
    }
}

// MARK: - Layered glass background

private struct GlassBackground: View {
    let cornerRadius: CGFloat

    // Middle-layer tints
    private let middleLight = Color(red: 255 / 255, green: 243 / 255, blue: 243 / 255) // #FFF3F3
    private let middleDark  = Color(red:  30 / 255, green:   3 / 255, blue:   3 / 255) // #1E0303

    // Top-layer bloom
    private let topBloom = Color(red: 237 / 255, green: 159 / 255, blue: 159 / 255) // #ED9F9F

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        // ── Last layer: native Liquid Glass material (refraction / depth / frost).
        Color.clear
            .glassEffect(.regular, in: shape)
            .overlay {
                // ── Middle + top tinted layers.
                //
                // No `compositingGroup()` here — that would isolate the blend
                // modes against transparent pixels (which makes Color Dodge
                // collapse to dark/muddy output). Without it, the Color Dodge
                // and Hard Light fills blend against the live glass beneath,
                // matching how Figma composes these layers.
                ZStack {
                    shape.fill(middleLight.opacity(0.36))

                    shape
                        .fill(middleDark.opacity(0.78))
                        .blendMode(.colorDodge)

                    shape
                        .fill(topBloom.opacity(0.08))
                        .blendMode(.hardLight)
                        .blur(radius: 20) // Figma blur 40 ≈ SwiftUI radius 20
                }
                .clipShape(shape)
                .allowsHitTesting(false)
            }
    }
}
