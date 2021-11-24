//
//  MockAnalyticsManager.swift
//  Gift ExchangeTests
//
//  Created by Eric Internicola on 1/24/21.
//  Copyright © 2021 Willis Programming. All rights reserved.
//

@testable import Gift_Xchanger

class MockAnalyticsManager: AnalyticsManaging {

    var trackScreenCalls = [String]()
    var trackTappedRandomizedCalls = 0
    var trackTappedResetCalls = 0

    func trackScreen(named name: String) {
        trackScreenCalls.append(name)
    }

    func trackTappedRandomize() {
        trackTappedRandomizedCalls += 1
    }

    func trackTappedReset() {
        trackTappedResetCalls += 1
    }

}

// MARK: - MockProtocol

extension MockAnalyticsManager: MockProtocol {

    func resetMock() {
        trackScreenCalls = []
        trackTappedRandomizedCalls = 0
        trackTappedResetCalls = 0
    }
}
