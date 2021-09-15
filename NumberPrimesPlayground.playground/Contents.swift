public struct Effect<A> {
    public let run: (@escaping (A) -> Void) -> Void
    
    public func map<B>(_ f: @escaping (A) -> B) -> Effect<B> {
        return Effect<B> { callback in self.run { a in callback(f(a)) } }
    }
}

import Dispatch

let anIntInTwoSeconds = Effect<Int> { callback in
  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    callback(42)
  }
}


anIntInTwoSeconds.run { int in print(int) }

import Combine

var count = 0
let iterator = AnyIterator<Int>.init {
  count += 1
  return count
}

Array(iterator.prefix(10))
