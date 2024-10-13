//
//  String.swift
//  CryptoTracker
//
//  Created by Marcin Wawer on 11-10-2024.
//

import Foundation

extension String {
    var removingHTMLOccurences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
