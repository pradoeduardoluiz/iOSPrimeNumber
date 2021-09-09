//
//  AppState.swift
//  NumberPrimes
//
//  Created by Luiz Eduardo do Prado on 08/09/21.
//

import Foundation

struct AppState {
    var count = 0
    var favoritePrimes: [Int] = []
    var loggedInUser: User? = nil
    var activityFeed: [Activity] = []
    
//    var favoritePrimesState: FavoritePrimesState {
//        get {
//            return FavoritePrimesState(
//                favoritePrimes: self.favoritePrimes,
//                activityFeed: self.activityFeed
//            )
//        }
//        set {
//            self.activityFeed = newValue.activityFeed
//            self.favoritePrimes = newValue.favoritePrimes
//        }
//    }
    
    struct Activity {
        let timestamp: Date
        let type: ActivityType
        
        enum ActivityType {
            case addedFavoritePrime(Int)
            case removedFavoritePrime(Int)
        }
    }
    
    struct User {
        let id: Int
        let name: String
        let bio: String
    }
}
