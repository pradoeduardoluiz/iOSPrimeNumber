//
//  AppReducer.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation

let _appReducer: (inout AppState, AppAction) -> Void = combine(
    pullback(counterReducer, value: \.count, action: \.counter),
    pullback(primeModalReducer, value: \.self, action: \.primeModal),
    pullback(favoritePrimesReducer, value: \.favoritePrimes, action: \.favoritePrimes)
)

let appReducer = pullback(_appReducer, value: \.self, action: \.self)

func activityFeed(
    _ reducer: @escaping (inout AppState, AppAction) -> Void
) -> (inout AppState, AppAction) -> Void {
    
    return { state, action in
        switch action {
        case .counter:
            break
            
        case .primeModal(.removeFavoritePrimeTapped):
            state.activityFeed.append(
                .init(timestamp: Date(), type: .removedFavoritePrime(state.count))
            )
        case .primeModal(.saveFavoritePrimeTapped):
            state.activityFeed.append(
                .init(timestamp: Date(), type: .addedFavoritePrime(state.count))
            )
        case let .favoritePrimes(.deleteFavoritePrimes(indexSet)):
            for index in indexSet {
                state.activityFeed.append(
                    .init(timestamp: Date(), type: .removedFavoritePrime(state.favoritePrimes[index]))
                )
            }
        }
        reducer(&state, action)
    }
}

func logging<Value, Action>(
  _ reducer: @escaping (inout Value, Action) -> Void
) -> (inout Value, Action) -> Void {
  return { value, action in
    reducer(&value, action)
    print("Action: \(action)")
    print("State:")
    dump(value)
    print("---")
  }
}
