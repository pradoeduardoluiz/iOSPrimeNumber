//
//  FavoritePrimesView.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import SwiftUI
import ComposableArchitecture

//struct FavoritePrimesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritePrimesView(
//            store: Store(initialValue: [2, 3, 5, 7, 11], reducer: favoritePrimesReducer)
//        )
//    }
//}

public struct FavoritePrimesView: View {
  @ObservedObject var store: Store<[Int], FavoritePrimesAction>
    
    public init(store: Store<[Int], FavoritePrimesAction>) {
        self.store = store
    }

    public var body: some View {
    List {
      ForEach(self.store.value, id: \.self) { prime in
        Text("\(prime)")
      }
      .onDelete { indexSet in
        self.store.send(.deleteFavoritePrimes(indexSet))
      }
    }
    .navigationBarTitle("Favorite Primes")
    .navigationBarItems(trailing: HStack {
        Button("Save"){
            self.store.send(.saveButtonTapped)
        }
        Button("Load"){
            self.store.send(.loadButtonTapped)
        }
    })
  }
}
