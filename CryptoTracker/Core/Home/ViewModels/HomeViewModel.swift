//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Marcin Wawer on 01-10-2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        addSubsribers()
    }
    
    func addSubsribers() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
