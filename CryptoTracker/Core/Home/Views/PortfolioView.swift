//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Marcin Wawer on 05-10-2024.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText = ""
    @State private var showCheckmark = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        porfolioInputSection
                    }
                }
            }
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton().onTapGesture {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    trailingNavBarButtons
                }
            }
            .onChange(of: vm.searchText) { _, newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeVM)
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
        .scrollIndicators(.hidden)
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var porfolioInputSection: some View {
            VStack(spacing: 20) {
                HStack {
                    Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                    Spacer()
                    
                    Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                }
                
                Divider()
                
                HStack {
                    Text("Amount holding")
                    Spacer()
                    
                    TextField("Ex: 1.4", text: $quantityText)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                
                Divider()
                
                HStack {
                    Text("Current value:")
                    Spacer()
                    
                    Text(getCurrentValue().asCurrencyWith2Decimals())
                }
        }
        .animation(.none, value: UUID())
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("SAVE")
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ?
                1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}

