//
//  NameManager.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/4/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import Foundation

protocol NameManaging {
    func getAllNames() -> [String]
    func add(name person: String)
    func remove(index row: Int)
    func remove(name person: String)
    func clear()
    func row(forName name: String) -> Int?
}

/**
 * This class is responsible for managing the list of people
 */
class NameManager {
    let defaults: UserDefaults

    init(with defaults: UserDefaults) {
        self.defaults = defaults
    }

    fileprivate var names: [String] {
        get {
            return defaults.array(forKey: "names") as? [String] ?? [String]()
        }
        set {
            defaults.set(newValue.sorted(), forKey: "names")
        }
    }
}

// MARK: - NameManaging

extension NameManager: NameManaging {

    // Gets you the list of names
    func getAllNames() -> [String] {
        return names
    }

    // Add a specific name
    func add(name person: String) {
        var values = names
        values.append(person)
        names = values
    }

    // Remove a specific name (by index)
    func remove(index row: Int) {
        var values = names
        values.remove(at: row)
        names = values
    }

    // Remove a specific name from the list (if you have multiples of the same name, this will remove them all)
    func remove(name person: String) {
        let values = names.filter { (aName: String) -> Bool in
            return aName != person
        }
        names = values
    }

    // Clears the names
    func clear() {
        names = []
    }

    // Gets you the row for the provided name
    func row(forName name: String) -> Int? {
        names.firstIndex(where: { $0 == name })
    }

}
