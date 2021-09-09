//
//  Counter.swift
//  Counter
//
//  Created by Luiz Eduardo do Prado on 09/09/21.
//

import Foundation

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
