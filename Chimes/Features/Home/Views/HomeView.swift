//
//  HomeView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 2/22/26.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var vm = HomeViewModel()

    var body: some View {
        ZStack {
            HomeBackgroundView()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    HomeHeaderView(
                        username: vm.username,
                        onMusic: { vm.openMusic() },
                        onRSVP: { vm.openRSVP() }
                    )

                    Spacer().frame(height: 305)

                    ChimeInCardView(
                        guessText: $vm.guessText,
                        onGuessMore: { vm.guessMore() },
                        onSubmit: { vm.submitGuess() }
                    )

                    KudosRowView { vm.tapKudos($0) }

                    PerformancesListView(performances: vm.performances)
                }
                .padding(.top, 95)
                .padding(.bottom, 45)
            }
            .ignoresSafeArea(.container, edges: .top)

            // temporary log out
            VStack {
                HStack {
                    Spacer()
                    Button("Log Out") {
                        try? Auth.auth().signOut()
                    }
                    .font(.caption)
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                    .padding(.trailing, 16)
                    .padding(.top, 50)
                }
                Spacer()
            }
        }
    }
}
