//
//  SongRequestedView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/29/26.
//

import SwiftUI

struct SongRequestedView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                stops: [
                    .init(color: Color("RequestedGradientTop"), location: 0.0161),
                    .init(color: Color("RequestedGradientBottom"), location: 0.8976)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                Image("RequestedClock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 127.69, height: 129)
                    .padding(.top, 244)

                Text("Your Song Has Been Requested!")
                    .font(DesignConstants.Fonts.H1)
                    .tracking(-1.8)
                    .foregroundStyle(Color("HeaderText"))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .frame(height: 88)
                    .padding(.top, 35)

                Text("Keep an ear out for your favorite tune")
                    .font(DesignConstants.Fonts.H2SemiBold)
                    .tracking(-0.54)
                    .lineSpacing(21 - 18)
                    .foregroundStyle(Color("HeaderText"))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 14)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea(.container, edges: .top)

            closeButton
                .padding(.top, 26)
                .padding(.trailing, 21)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    private var closeButton: some View {
        Button(action: { dismiss() }) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.65))
                    .shadow(color: .black.opacity(0.13), radius: 2, x: 1, y: 2)

                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.8))
            }
            .frame(width: 50, height: 50)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SongRequestedView()
}
