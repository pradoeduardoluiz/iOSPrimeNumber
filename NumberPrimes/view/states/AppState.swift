//
//  AppState.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation

struct AppState {
  var count = 0
  var favoritePrimes: [Int] = []
  var loggedInUser: User? = nil
  var activityFeed: [Activity] = []

  struct Activity {
    let timestamp: Date
    let type: ActivityType

    enum ActivityType {
      case addedFavoritePrime(Int)
      case removedFavoritePrime(Int)
    }
  }

  struct User {
    let id: Int
    let name: String
    let bio: String
  }
}

func appReducer(value: inout AppState, action: AppAction) {
    switch action {
    case .counter(.decrTapped):
        value.count -= 1
        
    case .counter(.incrTapped):
        value.count += 1
        
    case .primeModal(.saveFavoritePrimeTapped):
        value.favoritePrimes.removeAll(where: { $0 == value.count })
        value.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(value.count)))
        
    case .primeModal(.removeFavoritePrimeTapped):
        value.favoritePrimes.append(value.count)
        value.activityFeed.append(.init(timestamp: Date(), type: .addedFavoritePrime(value.count)))
        
    case let .favoritePrimes(.deleteFavoritePrimes(indexSet)):
        for index in indexSet {
            let prime = value.favoritePrimes[index]
            value.favoritePrimes.remove(at: index)
            value.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(prime)))
        }
    }
}
