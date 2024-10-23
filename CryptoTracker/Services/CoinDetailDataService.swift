//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by Marcin Wawer on 06-10-2024.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetails: CoinDetailModel? = nil
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    init (coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false&x_cg_demo_api_key=CG-ua76UZJbusWpdUyMpADNEvuo")
        else { return }
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
