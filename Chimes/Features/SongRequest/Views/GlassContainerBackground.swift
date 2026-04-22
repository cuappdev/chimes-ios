//
//  GlassContainerBackground.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import SwiftUI

struct GlassContainerBackground: View {
    var cornerRadius: CGFloat = 12

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        ZStack {
            shape.fill(.ultraThinMaterial)

            shape.fill(Color.black.opacity(0))

            shape.fill(Color(red: 30 / 255.0,  green: 3 / 255.0,   blue: 3 / 255.0).opacity(0.78))
            shape.fill(Color(red: 255 / 255.0, green: 243 / 255.0, blue: 243 / 255.0).opacity(0.36))
                .blendMode(.colorDodge)

            shape.fill(Color(red: 237 / 255.0, green: 159 / 255.0, blue: 159 / 255.0).opacity(0.08))
                .blendMode(.hardLight)
                .blur(radius: 20)
        }
        .compositingGroup()
        .clipShape(shape)
    }
}
