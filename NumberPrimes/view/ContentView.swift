//
//  ContentView.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    @ObservedObject var store: Store<AppState, AppAction>
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    "Counter demo",
                    destination: CounterView(store: self.store.view {
                        ($0.count, $0.favoritePrimes)
                    })
                )
                NavigationLink(
                    "Favorite primes",
                    destination: FavoritePrimesView(store: self.store.view { $0.favoritePrimes })
                )
            }
            .navigationBarTitle("State management")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(initialValue: AppState(), reducer: with(appReducer, compose(logging, activityFeed)))
        )
    }
}

struct PrimeAlert: Identifiable {
    let prime: Int
    var id: Int { self.prime }
}

