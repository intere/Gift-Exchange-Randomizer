//
//  NameManagerTest.swift
//  Gift Exchange
//
//  Created by Eric Internicola on 11/4/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

@testable import Gift_Xchanger
import Quick
import Nimble
import XCTest

class NameManagerSpec: QuickSpec {

    override func spec() {
        context("Add Names") {
            // swiftlint:disable implicitly_unwrapped_optional
            var defaults: UserDefaults!
            var subject: NameManager!
            // swiftlint:enable implicitly_unwrapped_optional

            beforeEach {
                defaults = .newTestInstance
                subject = NameManager(with: defaults)
            }

            it("has a different default instance than the standard") {
                expect(UserDefaults.standard).toNot(beIdenticalTo(defaults))
            }

            it("has no names to start") {
                expect(subject.getAllNames()).to(beEmpty())
            }

            context("Add 'Greg'") {
                beforeEach {
                    subject.add(name: "Greg")
                }
                it("has a single name") {
                    expect(subject.getAllNames().count).to(equal(1))
                }
                it("has 'Greg'") {
                    expect(subject.getAllNames()).to(contain("Greg"))
                }

                context("Add 'Eric'") {
                    beforeEach {
                        subject.add(name: "Eric")
                    }
                    it("has two names") {
                        expect(subject.getAllNames().count).to(equal(2))
                    }
                    it("has 'Greg'") {
                        expect(subject.getAllNames()).to(contain("Greg"))
                    }
                    it("has 'Eric'") {
                        expect(subject.getAllNames()).to(contain("Eric"))
                    }

                    context("Add 'Lori'") {
                        beforeEach {
                            subject.add(name: "Lori")
                        }
                        it("has two names") {
                            expect(subject.getAllNames().count).to(equal(3))
                        }
                        it("has 'Greg'") {
                            expect(subject.getAllNames()).to(contain("Greg"))
                        }
                        it("has 'Eric'") {
                            expect(subject.getAllNames()).to(contain("Eric"))
                        }
                        it("has 'Lori'") {
                            expect(subject.getAllNames()).to(contain("Lori"))
                        }

                        context("Remove 'Greg'") {
                            beforeEach {
                                subject.remove(name: "Greg")
                            }
                            it("has two names") {
                                expect(subject.getAllNames().count).to(equal(2))
                            }
                            it("has 'Eric'") {
                                expect(subject.getAllNames()).to(contain("Eric"))
                            }
                            it("has 'Lori'") {
                                expect(subject.getAllNames()).to(contain("Lori"))
                            }

                            context("Remove index 0") {
                                beforeEach {
                                    subject.remove(index: 0)
                                }
                                it("has a single name") {
                                    expect(subject.getAllNames().count).to(equal(1))
                                }
                                it("has 'Lori'") {
                                    expect(subject.getAllNames()).to(contain("Lori"))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension UserDefaults {
    static var newTestInstance: UserDefaults {
        UserDefaults(suiteName: "test-\(UUID().uuidString)")!
    }
}
