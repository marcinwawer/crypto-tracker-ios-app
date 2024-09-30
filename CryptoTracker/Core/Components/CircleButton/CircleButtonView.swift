//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Marcin Wawer on 30-09-2024.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                 radius: 10
            )
            .padding()
    }
}

#Preview {
    CircleButtonView(iconName: "info")
    CircleButtonView(iconName: "plus")
}
