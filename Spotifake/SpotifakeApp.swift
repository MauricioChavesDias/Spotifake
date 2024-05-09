//
//  SpotifakeApp.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 23/4/2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct SpotifakeApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}


// This piece of code allows SwiftUI screen to swipe left to go back on the previous screen

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
