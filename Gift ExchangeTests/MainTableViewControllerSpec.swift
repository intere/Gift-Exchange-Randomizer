//
//  MainTableViewControllerSpec.swift
//  Gift ExchangeTests
//
//  Created by Eric Internicola on 1/24/21.
//  Copyright © 2021 Willis Programming. All rights reserved.
//

@testable import Gift_Xchanger
import Quick
import Nimble
import XCTest

class MainTableViewControllerSpec: QuickSpec {

    override func spec() {

        var mockAnalyticsManager: MockAnalyticsManager!
        var mockMatchupManager: MockMatchupManager!
        var mockNameManager: MockNameManager!
        var subject: MainTableViewController!

        describe("MainTableViewController") {
            beforeEach {

                mockAnalyticsManager = MockAnalyticsManager()
                mockMatchupManager = MockMatchupManager()
                mockNameManager = MockNameManager()

                subject = MainTableViewController(
                    analytics: mockAnalyticsManager,
                    nameManager: mockNameManager,
                    matchupManager: mockMatchupManager
                )
            }

            context("viewDidLoad") {
                beforeEach {
                    // Trigger a call to "viewDidLoad"
                    _ = subject.view
                }

                it("reads all of the names from the NameManager") {
                    expect(mockNameManager.getAllNamesCount).to(equal(1))
                }

                context("viewWillAppear") {
                    beforeEach {
                        subject.viewWillAppear(false)
                    }

                    it("calls trackScreen") {
                        expect(mockAnalyticsManager.trackScreenCalls).to(contain("Main"))
                    }
                }
            }

            describe("NameAddedDelegate") {
                context("added(name:)") {
                    beforeEach {
                        subject.added(name: "Bill")
                    }

                    it("adds the name to the name manager") {
                        expect(mockNameManager.addCalls).to(contain("Bill"))
                    }
                }
            }

            describe("ButtonsCellDelegate") {
                context("tappedReset()") {
                    beforeEach {
                        subject.tappedReset()
                    }

                    it("trakcs the tap in analytics") {
                        expect(mockAnalyticsManager.trackTappedResetCalls).to(equal(1))
                    }

                    it("clears the names") {
                        expect(mockNameManager.clearCount).to(equal(1))
                    }
                }

                context("tappedRandomize") {
                    beforeEach {
                        mockNameManager.resetMock()
                        subject.tappedRandomize()
                    }

                    it("tracks the tap in analytics") {
                        expect(mockAnalyticsManager.trackTappedRandomizedCalls).to(equal(1))
                    }

                    it("fetches the names from the name manager") {
                        expect(mockNameManager.getAllNamesCount).to(equal(1))
                    }
                }
            }

            #warning("Add specs for numberOfRowsInSection")
            #warning("Add specs for cellForRowAt")
            #warning("Add specs for editActionsForRowAt")
        }
    }

}
