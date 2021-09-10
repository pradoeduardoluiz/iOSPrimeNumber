//
//  Counter.swift
//  Counter
//
//  Created by Luiz Eduardo do Prado on 09/09/21.
//

import ComposableArchitecture
import PrimeModal

public enum CounterAction {
  case decrTapped
  case incrTapped
}

public func counterReducer(state: inout Int, action: CounterAction) {
    switch action {
    case .decrTapped:
        state -= 1
    case .incrTapped:
        state += 1
    }
}

public let counterViewReducer = combine(
  pullback(counterReducer, value: \CounterViewState.count, action: \CounterViewAction.counter),
  pullback(primeModalReducer, value: \.self, action: \.primeModal)
)
