//
//  AnalyticsManager.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/17/18.
//  Copyright © 2018 Willis Programming. All rights reserved.
//

import Foundation

class AnalyticsManager {
    static let shared = AnalyticsManager()

    /// Tracks that a screen has been viewed.
    ///
    /// - Parameter named: The name of the screen that was viewed.
    func trackScreen(named: String) {
    }

    /// Tracks that the "Randomize" button was tapped.
    func trackTappedRandomized() {
    }

    /// Tracks that the "Reset" button was tapped.
    func trackTappedReset() {
    }
}
