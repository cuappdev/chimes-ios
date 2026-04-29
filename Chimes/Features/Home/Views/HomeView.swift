//
//  HomeView.swift
//  Chimes
//
//  Created by Arielle Nudelman on 2/22/26.
//

import SwiftUI

struct HomeView: View {
    @State private var vm = HomeViewModel()
    @State private var showingSongRequest = false

    var body: some View {
        NavigationStack {
            ZStack {
                HomeBackgroundView()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {
                        HomeHeaderView(
                            username: vm.username,
                            onMusic: { showingSongRequest = true },
                            onRSVP: { vm.openRSVP() }
                        )
                        .zIndex(1) // keep dropdown above the cards below

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
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $showingSongRequest) {
                SongRequestView()
                    .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}

#Preview {
    HomeView()
}
