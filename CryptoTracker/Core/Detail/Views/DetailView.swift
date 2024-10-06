//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Marcin Wawer on 06-10-2024.
//

import SwiftUI

struct DetailLodaingView: View {
    @Binding var coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    @StateObject var vm: DetailViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        Text("hello")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
