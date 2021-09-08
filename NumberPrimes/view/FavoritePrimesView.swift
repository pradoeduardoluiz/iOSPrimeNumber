//
//  FavoritePrimesView.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation
import SwiftUI

struct FavoritePrimesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePrimesView(
            store: Store(initialValue: AppState(), reducer: appReducer)
        )
    }
}

struct FavoritePrimesView: View {
  @ObservedObject var store: Store<AppState, AppAction>

  var body: some View {
    List {
      ForEach(self.store.value.favoritePrimes, id: \.self) { prime in
        Text("\(prime)")
      }
      .onDelete { indexSet in
        self.store.send(.favoritePrimes(.deleteFavoritePrimes(indexSet)))
      }
    }
    .navigationBarTitle("Favorite Primes")
  }
}
