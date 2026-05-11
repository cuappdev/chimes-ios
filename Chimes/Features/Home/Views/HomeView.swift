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
                .padding(.top, 95)
                .padding(.bottom, 45)
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $showingSongRequest) {
                SongRequestView()
                    .toolbar(.hidden, for: .navigationBar)
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

#Preview {
    HomeView()
}
