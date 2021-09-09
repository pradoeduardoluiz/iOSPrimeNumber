//
//  PrimeModalReducer.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation

func primeModalReducer(state: inout AppState, action: PrimeModalAction) -> Void {
    switch action {
    case .removeFavoritePrimeTapped:
        state.favoritePrimes.removeAll(where: { $0 == state.count })
        
    case .saveFavoritePrimeTapped:
        state.favoritePrimes.append(state.count)
    }
}
