//
//  Effect.swift
//  ComposableArchitecture
//
//  Created by Luiz Eduardo do Prado on 13/09/21.
//

import Combine

//public struct Effect<A> {
//
//    public let run: ( @escaping (A) -> Void) -> Void
//
//    public init (run: @escaping (@escaping (A) -> Void) -> Void){
//        self.run = run
//    }
//
//    public func map<B>(_ f: @escaping (A) -> B) -> Effect<B> {
//        return Effect<B> { callback in self.run { a in callback(f(a)) }
//        }
//
//    }
//}

public struct Effect<Output>: Publisher {
    public typealias Failure = Never
    
    let publisher: AnyPublisher<Output, Failure>
    
    public func receive<S>(
        subscriber: S
    ) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        self.publisher.receive(subscriber: subscriber)
    }
}

extension Publisher where Failure == Never {
    public func eraseToEffect() -> Effect<Output>{
        return Effect(publisher: self.eraseToAnyPublisher())
    }
}

//extension Effect where A == (Data?, URLResponse?, Error?) {
//    
//  public func decode<B: Decodable>(as type: B.Type) -> Effect<B?> {
//    return self.map { data, _, _ in
//      data
//        .flatMap { try? JSONDecoder().decode(B.self, from: $0) }
//    }
//  }
//    
//}
//
//extension Effect  {
// 
//    public func receive(on queue: DispatchQueue) -> Effect {
//        return Effect {callback in
//            self.run { a in
//                queue.async {
//                    callback(a)
//                }
//            }
//        }
//    }
// 
//}
//
//public func dataTask(with url: URL) -> Effect<(Data?, URLResponse?, Error?)> {
//    return Effect { callback in
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            callback((data, response, error))
//        }
//        .resume()
//    }
//}


