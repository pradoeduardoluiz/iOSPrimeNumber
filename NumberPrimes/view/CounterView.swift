//
//  CounterView.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation
import SwiftUI

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(
            store: Store(initialValue: AppState(), reducer: appReducer)
        )
    }
}

struct CounterView: View {
  @ObservedObject var store: Store<AppState, AppAction>
  @State var isPrimeModalShown = false
  @State var alertNthPrime: PrimeAlert?
  @State var isNthPrimeButtonDisabled = false

  var body: some View {
    VStack {
      HStack {
        Button("-") { self.store.send(.counter(.decrTapped)) }
        Text("\(self.store.value.count)")
        Button("+") { self.store.send(.counter(.incrTapped)) }
      }
      Button("Is this prime?") { self.isPrimeModalShown = true }
      Button(
        "What is the \(ordinal(self.store.value.count)) prime?",
        action: self.nthPrimeButtonAction
      )
      .disabled(self.isNthPrimeButtonDisabled)
    }
    .font(.title)
    .navigationBarTitle("Counter demo")
    .sheet(isPresented: self.$isPrimeModalShown) {
      IsPrimeModalView(store: self.store)
    }
    .alert(item: self.$alertNthPrime) { alert in
      Alert(
        title: Text("The \(ordinal(self.store.value.count)) prime is \(alert.prime)"),
        dismissButton: .default(Text("Ok"))
      )
    }
  }

  func nthPrimeButtonAction() {
    self.isNthPrimeButtonDisabled = true
    nthPrime(self.store.value.count) { prime in
      self.alertNthPrime = prime.map(PrimeAlert.init(prime:))
      self.isNthPrimeButtonDisabled = false
    }
  }
}
