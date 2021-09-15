//
//  AppReducer.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation
import ComposableArchitecture
import FavoritePrimes
import Counter
import PrimeModal

//let appReducer: (inout AppState, AppAction) -> Void = combine(
//    pullback(counterReducer, value: \.count, action: \.counter),
//    pullback(primeModalReducer, value: \.primeModal, action: \.primeModal),
//    pullback(favoritePrimesReducer, value: \.favoritePrimes, action: \.favoritePrimes)
//)

let appReducer: Reducer<AppState, AppAction> = combine(
  pullback(counterViewReducer, value: \.counterView, action: \.counterView),
  pullback(favoritePrimesReducer, value: \.favoritePrimes, action: \.favoritePrimes)
)

func activityFeed(
    _ reducer: @escaping Reducer<AppState, AppAction>
) -> Reducer<AppState, AppAction> {
    
    return { state, action in
        switch action {
        case .counterView(.counter):
            break
            
        case .counterView(.primeModal(.removeFavoritePrimeTapped)):
            state.activityFeed.append(
                .init(timestamp: Date(), type: .removedFavoritePrime(state.count))
            )
            
        case .counterView(.primeModal(.saveFavoritePrimeTapped)):
            state.activityFeed.append(
                .init(timestamp: Date(), type: .addedFavoritePrime(state.count))
            )
            
        case let .favoritePrimes(.deleteFavoritePrimes(indexSet)):
            for index in indexSet {
                state.activityFeed.append(
                    .init(timestamp: Date(), type: .removedFavoritePrime(state.favoritePrimes[index]))
                )
            }
        case .favoritePrimes(.loadedFavoritePrimes(_)):
            break
        case .favoritePrimes(.loadButtonTapped):
            break
        case .favoritePrimes(.saveButtonTapped):
            break
        }
        return reducer(&state, action)
    }
}
