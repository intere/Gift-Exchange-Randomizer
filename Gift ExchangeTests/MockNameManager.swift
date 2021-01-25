//
//  MockNameManager.swift
//  Gift ExchangeTests
//
//  Created by Eric Internicola on 1/24/21.
//  Copyright © 2021 Willis Programming. All rights reserved.
//

@testable import Gift_Xchanger

class MockNameManager: NameManaging {

    var getAllNamesCount = 0
    var names = [String]()
    var addCalls = [String]()
    var removeIndexCalls = [Int]()
    var removeName = [String]()
    var clearCount = 0
    var removeNameCalls = [String]()
    var rowForNameCalls = [String]()
    var rowForNameResult: Int?

    func getAllNames() -> [String] {
        getAllNamesCount += 1
        return names
    }

    func add(name person: String) {
        addCalls.append(person)
        #warning("should we add the name to the names collection?")
    }

    func remove(index row: Int) {
        removeIndexCalls.append(row)
    }

    func remove(name person: String) {
        removeNameCalls.append(person)
    }

    func clear() {
        clearCount += 1
    }

    func row(forName name: String) -> Int? {
        rowForNameCalls.append(name)
        return rowForNameResult
    }

}

// MARK: - MockProtocol

extension MockNameManager: MockProtocol {

    func resetMock() {
        getAllNamesCount = 0
        names = []
        addCalls = []
        removeIndexCalls = []
        removeName = []
        clearCount = 0
        removeNameCalls = []
        rowForNameCalls = []
        rowForNameResult = nil
    }
}
