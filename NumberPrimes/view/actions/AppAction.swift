//
//  AppActions.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation

enum AppAction {
  case counter(CounterAction)
  case primeModal(PrimeModalAction)
  case favoritePrimes(FavoritePrimesAction)
}

enum CounterAction {
  case decrTapped
  case incrTapped
}

enum PrimeModalAction {
  case saveFavoritePrimeTapped
  case removeFavoritePrimeTapped
}

enum FavoritePrimesAction {
  case deleteFavoritePrimes(IndexSet)
}
