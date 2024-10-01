//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Marcin Wawer on 30-09-2024.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environmentObject(vm)
        }
    }
}
