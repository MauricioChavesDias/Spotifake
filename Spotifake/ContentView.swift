//
//  ContentView.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 23/4/2024.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
        List {
            Button("Open Spotify") {
                router.showScreen(.fullScreenCover) { router in
                    HomeView(viewModel: HomeViewModel(router: router))
                }
            }
        }
        .padding()

 
    }

}

#Preview {
    RouterView { _ in
        ContentView()
    }

}
