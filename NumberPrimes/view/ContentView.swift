//
//  ContentView.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var store: Store<AppState, AppAction>
    
    var body: some View {
        NavigationView {
          List {
            NavigationLink(
              "Counter demo",
              destination: CounterView(store: self.store)
            )
            NavigationLink(
              "Favorite primes",
              destination: FavoritePrimesView(store: self.store)
            )
          }
          .navigationBarTitle("State management")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(initialValue: AppState(), reducer: appReducer)
        )
    }
}

struct PrimeAlert: Identifiable {
  let prime: Int
  var id: Int { self.prime }
}

