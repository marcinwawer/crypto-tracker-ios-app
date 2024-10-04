//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Marcin Wawer on 03-10-2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
