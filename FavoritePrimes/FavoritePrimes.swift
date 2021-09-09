//
//  FavoritePrimes.swift
//  FavoritePrimes
//
//  Created by Luiz Eduardo do Prado on 09/09/21.
//

import Foundation

public enum FavoritePrimesAction {
  case deleteFavoritePrimes(IndexSet)
}

public func favoritePrimesReducer(state: inout [Int], action: FavoritePrimesAction) -> Void {
    switch action {
    case let .deleteFavoritePrimes(indexSet):
        for index in indexSet {
            state.remove(at: index)
        }
    }
}
