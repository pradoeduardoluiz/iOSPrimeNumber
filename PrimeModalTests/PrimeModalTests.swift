//
//  PrimeModalTests.swift
//  PrimeModalTests
//
//  Created by Luiz Eduardo do Prado on 09/09/21.
//

import XCTest
@testable import PrimeModal

class PrimeModalTests: XCTestCase {

    func testSaveFavoritePrimesTapped() {
        var state = (count: 2, favoritePrimes: [3, 5])

        let effects = primeModalReducer(state: &state, action: .saveFavoritePrimeTapped)

        let (count, favoritePrimes) = state
        XCTAssertEqual(state.count, 2)
        XCTAssertEqual(state.favoritePrimes, [3, 5, 2])
        XCTAssert(effects.isEmpty)
    }
    
    func testRemoveFavoritePrimesTapped() {
        var state = (count: 3, favoritePrimes: [3, 5])

        let effects = primeModalReducer(state: &state, action: .removeFavoritePrimeTapped)

        let (count, favoritePrimes) = state
        XCTAssertEqual(state.count, 3)
        XCTAssertEqual(state.favoritePrimes, [5])
        XCTAssert(effects.isEmpty)
    }

}
