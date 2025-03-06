//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Marcin Wawer on 05-10-2024.
//

import Foundation

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init () {
        getData()
    }
    
    func getData () {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global?x_cg_demo_api_key=\(AppData.shared.apiKey)")
        else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
