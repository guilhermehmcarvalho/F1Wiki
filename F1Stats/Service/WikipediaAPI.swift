//
//  WikipediaAPI.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation
import Combine

protocol WikipediaAPIProtocol {
  func getSummaryFor(url: String) -> AnyPublisher<WikipediaSummaryModel, Error>
}

class WikipediaAPI: WikipediaAPIProtocol {

  final var baseURL: String
  final var urlSession: URLSession

  var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }

  init(baseURL: String, urlSession: URLSession = URLSession.shared) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }

  func getSummaryFor(url: String) -> AnyPublisher<WikipediaSummaryModel, Error> {
    guard let title = URL(string: url)?.lastPathComponent else {
      return Empty().eraseToAnyPublisher()
    }
    guard let url = URL(string: baseURL.appending("page/summary/\(title)")) else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
      .tryDecodeResponse(type: WikipediaSummaryModel.self, decoder: decoder)
      .eraseToAnyPublisher()
  }
}

class WikipediaAPIStub: WikipediaAPIProtocol {
  func getSummaryFor(url: String) -> AnyPublisher<WikipediaSummaryModel, any Error> {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    let jsonString = """
{"type":"standard","title":"Ayrton Senna","displaytitle":"Ayrton Senna","namespace":{"id":0,"text":""},"wikibase_item":"Q10490","titles":{"canonical":"Ayrton_Senna","normalized":"Ayrton Senna","display":"Ayrton Senna"},"pageid":146638,"thumbnail":{"source":"https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Ayrton_Senna_8_%28cropped%29.jpg/320px-Ayrton_Senna_8_%28cropped%29.jpg","width":320,"height":414},"originalimage":{"source":"https://upload.wikimedia.org/wikipedia/commons/3/38/Ayrton_Senna_8_%28cropped%29.jpg","width":505,"height":653},"lang":"en","dir":"ltr","revision":"1216622002","tid":"657e3a8c-efd2-11ee-aae8-3680f576414a","timestamp":"2024-04-01T02:49:02Z","description":"Brazilian Formula One driver (1960–1994)","description_source":"local","content_urls":{"desktop":{"page":"https://en.wikipedia.org/wiki/Ayrton_Senna","revisions":"https://en.wikipedia.org/wiki/Ayrton_Senna?action=history","edit":"https://en.wikipedia.org/wiki/Ayrton_Senna?action=edit","talk":"https://en.wikipedia.org/wiki/Talk:Ayrton_Senna"},"mobile":{"page":"https://en.m.wikipedia.org/wiki/Ayrton_Senna","revisions":"https://en.m.wikipedia.org/wiki/Special:History/Ayrton_Senna","edit":"https://en.m.wikipedia.org/wiki/Ayrton_Senna?action=edit","talk":"https://en.m.wikipedia.org/wiki/Talk:Ayrton_Senna"}},"extract":"Ayrton Senna da Silva was a Brazilian racing driver who won the Formula One World Drivers' Championship in 1988, 1990, and 1991. One of three Formula One drivers from Brazil to become World Champion, Senna won 41 Grands Prix and set 65 pole positions, with the latter being the record until 2006. He died as a result of an accident while leading the 1994 San Marino Grand Prix, driving for the Williams team.","extract_html":"<p><b>Ayrton Senna da Silva</b> was a Brazilian racing driver who won the Formula One World Drivers' Championship in 1988, 1990, and 1991. One of three Formula One drivers from Brazil to become World Champion, Senna won 41 Grands Prix and set 65 pole positions, with the latter being the record until 2006. He died as a result of an accident while leading the 1994 San Marino Grand Prix, driving for the Williams team.</p>"}
"""

    do {
      guard let jsonData = jsonString.data(using: .utf8) else {
        return Empty().eraseToAnyPublisher()
      }

      let model = try decoder.decode(WikipediaSummaryModel.self, from: jsonData)
      return Just(model)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    } catch let error {
      print(error)
      return Empty().eraseToAnyPublisher()
    }
  }

}
