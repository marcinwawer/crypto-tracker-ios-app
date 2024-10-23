//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Marcin Wawer on 13-10-2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/swiftfulthinking")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://www.github.com/marcinwawer")!
    
    var body: some View {
        NavigationView {
            ZStack {
                // background
                Color.theme.background
                    .ignoresSafeArea()
                
                // content
                List {
                    swiftfulThinkingSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    
                    developerSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
            .tint(.blue)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton().onTapGesture { 
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    private var swiftfulThinkingSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was made by following a @SwiftfulThinking course on Youtube. It uses MVVM architecture, Combine and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Subscribe on Youtube 🥳", destination: youtubeURL)
            Link("Support his coffee addiction ☕️", destination: coffeeURL)
        } header: {
            Text("Swiftful Thinking")
        }
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The cryptocurrency data that is used in this app comes from a free API form CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit CoinGecko 🦎", destination: coingeckoURL)
        } header: {
            Text("CoinGecko")
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image(systemName: "iphone.sizes")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was developed by Marcin Wawer. It uses SwiftUI and is written 100% in Swift. The project benefits from mulit-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit Github 🤝", destination: coingeckoURL)
        } header: {
            Text("Developer")
        }
    }
    
    private var applicationSection: some View {
        Section {
            Link("Terms of Service", destination: defaultURL)
            Link("Pricay Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        } header: {
            Text("Application")
        }
    }
}
