//
//  Store.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation

final class Store<Value, Action>: ObservableObject {
  let reducer: (inout Value, Action) -> Void
  @Published var value: Value

  init(initialValue: Value, reducer: @escaping (inout Value, Action) -> Void) {
    self.reducer = reducer
    self.value = initialValue
  }

  func send(_ action: Action) {
    self.reducer(&self.value, action)
  }
}
