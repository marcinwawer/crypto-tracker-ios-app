//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by Marcin Wawer on 06-10-2024.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
