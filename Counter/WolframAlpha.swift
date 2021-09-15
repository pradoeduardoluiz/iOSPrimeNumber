//
//  WolframAlpha.swift
//  Counter
//
//  Created by Luiz Eduardo do Prado on 09/09/21.
//

import ComposableArchitecture

private let wolframAlphaApiKey = "6H69Q3-828TKQJ4EP"

public struct WolframAlphaResult: Decodable {
  let queryresult: QueryResult

  struct QueryResult: Decodable {
    let pods: [Pod]

    struct Pod: Decodable {
      let primary: Bool?
      let subpods: [SubPod]

      struct SubPod: Decodable {
        let plaintext: String
      }
    }
  }
}

//func wolframAlpha(query: String, callback: @escaping (WolframAlphaResult?) -> Void) -> Void {

//}

public func wolframAlpha(query: String) -> Effect<WolframAlphaResult?> {
    var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
    components.queryItems = [
        URLQueryItem(name: "input", value: query),
        URLQueryItem(name: "format", value: "plaintext"),
        URLQueryItem(name: "output", value: "JSON"),
        URLQueryItem(name: "appid", value: wolframAlphaApiKey),
    ]
//    return dataTask(with: components.url(relativeTo: nil)!).decode(as: WolframAlphaResult.self)
    return URLSession.shared
        .dataTaskPublisher(for: components.url(relativeTo: nil)!)
        .map { data, _ in data }
        .decode(type: WolframAlphaResult?.self, decoder: JSONDecoder())
        .replaceError(with: nil)
        .eraseToEffect()
}
