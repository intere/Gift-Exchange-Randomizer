//
//  MockMatchupManager.swift
//  Gift ExchangeTests
//
//  Created by Eric Internicola on 1/24/21.
//  Copyright © 2021 Willis Programming. All rights reserved.
//

@testable import Gift_Xchanger

class MockMatchupManager: MatchupManaging {
    var names = [String]()
    var randomMatchup = [String: String]()
    var randomizeCalls = 0

    func randomize() -> [String: String] {
        randomizeCalls += 1
        return randomMatchup
    }

}

// MARK: - MockProtocol

extension MockMatchupManager: MockProtocol {

    func resetMock() {
        names = []
        randomMatchup = [:]
        randomizeCalls = 0
    }
}
