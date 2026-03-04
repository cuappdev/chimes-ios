//
//  ContentView.swift
//  Chimes
//
//  Created by Jay on 2/18/26.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = LoginViewModel()
    
    var body: some View {
        if (viewModel.loggedIn == true){
            HomeView()
        } else {
            LoginView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView()
}
