//
//  SongRequestSubmitButton.swift
//  Chimes
//
//  Created by Arielle Nudelman on 4/22/26.
//

import SwiftUI

struct SongRequestSubmitButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Request")
                .font(Font.custom("Inter", size: 14).weight(.regular))
                .tracking(-0.42)
                .foregroundStyle(Color("ButtonText"))
                .padding(.top, 15.083)
                .padding(.bottom, 14.917)
                .frame(width: 340, height: 46)
                .background(
                    GlassContainerBackground(cornerRadius: 23)
                        .shadow(color: .black.opacity(0.09), radius: 3.7, x: 0, y: 4)
                )
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
