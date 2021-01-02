//
//  MatchupManagerTest.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/5/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

@testable import Gift_Xchanger
import Quick
import Nimble
import XCTest

class MatchupManagerSpec: QuickSpec {

    override func spec() {
        let names = [ "Bob", "Mary", "Jane", "Eric", "Homer", "Marge", "Bart" ]
        var subject: MatchupManager!

        (0..<100).forEach { _ in
            context("Randomize") {
                var assignments: [String: String]!
                beforeEach {
                    subject = MatchupManager()
                    subject.names = names
                    assignments = subject.randomize()
                }

                it("does not assign a person to themselves") {
                    assignments.forEach { (key, value) in
                        expect(value).toNot(equal(key))
                    }
                }

                it("assigns every single person") {
                    names.forEach { name in
                        expect(assignments.keys.contains(name)).to(beTrue())
                        expect(assignments.values.contains(name)).to(beTrue())
                    }
                }
            }
        }
    }
}
