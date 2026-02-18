//
//  ContentView.swift
//  Chimes
//
//  Created by Jay on 2/18/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .foregroundColor(.daytimeSky)
            
            Image(.towerOriginal)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
