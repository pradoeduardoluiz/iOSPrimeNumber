//
//  IsPrimeView.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import PrimeModal

//struct IsPrimeModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        IsPrimeModalView(
//            store: Store(initialValue: AppState(), reducer: appReducer)
//        )
//    }
//}

struct IsPrimeModalView: View {
  @ObservedObject var store: Store<PrimeModalState, AppAction>

  var body: some View {
    VStack {
      if isPrime(self.store.value.count) {
        Text("\(self.store.value.count) is prime 🎉")
        if self.store.value.favoritePrimes.contains(self.store.value.count) {
          Button("Remove from favorite primes") {
            self.store.send(.primeModal(.removeFavoritePrimeTapped))
          }
        } else {
          Button("Save to favorite primes") {
            self.store.send(.primeModal(.saveFavoritePrimeTapped))
          }
        }
      } else {
        Text("\(self.store.value.count) is not prime :(")
      }
    }
  }
}
