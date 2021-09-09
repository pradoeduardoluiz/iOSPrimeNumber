//
//  PrimeModal.swift
//  PrimeModal
//
//  Created by Luiz Eduardo do Prado on 09/09/21.
//

public typealias PrimeModalState = (count: Int, favoritePrimes: [Int])

public enum PrimeModalAction {
    case saveFavoritePrimeTapped
    case removeFavoritePrimeTapped
}

public func primeModalReducer(state: inout PrimeModalState, action: PrimeModalAction) -> Void {
    switch action {
    case .removeFavoritePrimeTapped:
        state.favoritePrimes.removeAll(where: { $0 == state.count })
        
    case .saveFavoritePrimeTapped:
        state.favoritePrimes.append(state.count)
    }
}
