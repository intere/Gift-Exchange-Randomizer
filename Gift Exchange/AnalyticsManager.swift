//
//  AnalyticsManager.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/17/18.
//  Copyright © 2018 Willis Programming. All rights reserved.
//

import AppCenterAnalytics

protocol AnalyticsManaging {
    /// Tracks that a screen has been viewed.
    ///
    /// - Parameter named: The name of the screen that was viewed.
    func trackScreen(named: String)

    /// Tracks that the "Randomize" button was tapped.
    func trackTappedRandomize()

    /// Tracks that the "Reset" button was tapped.
    func trackTappedReset()
}

class AnalyticsManager: AnalyticsManaging {

    /// Tracks that a screen has been viewed.
    ///
    /// - Parameter named: The name of the screen that was viewed.
    func trackScreen(named: String) {
        Analytics.trackEvent("trackScreen", withProperties: ["name": named])
    }

    /// Tracks that the "Randomize" button was tapped.
    func trackTappedRandomize() {
        Analytics.trackEvent("randomized")
    }

    /// Tracks that the "Reset" button was tapped.
    func trackTappedReset() {
        Analytics.trackEvent("reset")
    }
}
