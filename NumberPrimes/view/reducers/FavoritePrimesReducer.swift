//
//  FavoritePrimesReducer.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation

func favoritePrimesReducer(state: inout [Int], action: FavoritePrimesAction) -> Void {
    switch action {
    case let .deleteFavoritePrimes(indexSet):
        for index in indexSet {
            state.remove(at: index)
        }
    }
}
