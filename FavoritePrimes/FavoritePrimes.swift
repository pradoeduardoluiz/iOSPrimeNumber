//
//  FavoritePrimes.swift
//  FavoritePrimes
//
//  Created by Luiz Eduardo do Prado on 09/09/21.
//

import ComposableArchitecture
import Combine

public enum FavoritePrimesAction {
    case deleteFavoritePrimes(IndexSet)
    case loadedFavoritePrimes([Int])
    case saveButtonTapped
    case loadButtonTapped
}

public func favoritePrimesReducer(state: inout [Int], action: FavoritePrimesAction) -> [Effect<FavoritePrimesAction>] {
  switch action {
  case let .deleteFavoritePrimes(indexSet):
    for index in indexSet {
      state.remove(at: index)
    }
    return []

  case let .loadedFavoritePrimes(favoritePrimes):
    state = favoritePrimes
    return []

  case .saveButtonTapped:
    return [saveEffect(favoritePrimes: state)]
    
  case .loadButtonTapped:
    return [
        loadEffect
            .compactMap { $0 }
            .eraseToEffect()
    ]
  }
}

private func saveEffect(favoritePrimes: [Int]) -> Effect<FavoritePrimesAction> {
    return Effect.fireAndForget {
    let data = try! JSONEncoder().encode(favoritePrimes)
    let documentsPath = NSSearchPathForDirectoriesInDomains(
      .documentDirectory, .userDomainMask, true
      )[0]
    let documentsUrl = URL(fileURLWithPath: documentsPath)
    let favoritePrimesUrl = documentsUrl
      .appendingPathComponent("favorite-primes.json")
    try! data.write(to: favoritePrimesUrl)
  }
}

private let loadEffect = Effect<FavoritePrimesAction?>.sync {
  let documentsPath = NSSearchPathForDirectoriesInDomains(
    .documentDirectory, .userDomainMask, true
    )[0]
  let documentsUrl = URL(fileURLWithPath: documentsPath)
  let favoritePrimesUrl = documentsUrl
    .appendingPathComponent("favorite-primes.json")
  guard
    let data = try? Data(contentsOf: favoritePrimesUrl),
    let favoritePrimes = try? JSONDecoder().decode([Int].self, from: data) else { return nil }
  return .loadedFavoritePrimes(favoritePrimes)
}

extension Effect {
    public static func sync(work: @escaping () -> Output) -> Effect {
        return Deferred { Just(work()) }.eraseToEffect()
    }
}

