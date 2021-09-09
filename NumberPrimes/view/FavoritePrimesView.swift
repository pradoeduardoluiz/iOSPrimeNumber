//
//  FavoritePrimesView.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation
import ComposableArchitecture
import SwiftUI

//struct FavoritePrimesView_Previews: PreviewProvider {
//    static var previews: some View {
//        let primes: [Int] = [3, 5]
//        FavoritePrimesView(
//            store: Store(initialValue: primes, reducer: appReducer)
//        )
//    }
//}

struct FavoritePrimesView: View {
  @ObservedObject var store: Store<[Int], AppAction>

  var body: some View {
    List {
      ForEach(self.store.value, id: \.self) { prime in
        Text("\(prime)")
      }
      .onDelete { indexSet in
        self.store.send(.favoritePrimes(.deleteFavoritePrimes(indexSet)))
      }
    }
    .navigationBarTitle("Favorite Primes")
  }
}
