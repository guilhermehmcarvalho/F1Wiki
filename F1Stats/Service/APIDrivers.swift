//
//  APIDrivers.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation
import Combine

protocol APIDriversProtocol {
  func listOfAllDrivers(limit: Int, offset: Int) -> AnyPublisher<MRData<DriverTable>, Error>
  func listOfDriverStandings(driverId: String) -> AnyPublisher<MRData<StandingsTable>, Error>
}

class APIDrivers: APIDriversProtocol {

  final var baseURL: String
  final var urlSession: URLSession

  init(baseURL: String, urlSession: URLSession = URLSession.shared) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }

  func listOfAllDrivers(limit: Int = 30, offset: Int = 0) -> AnyPublisher<MRData<DriverTable>, Error> {
    var components = URLComponents(string: baseURL.appending("drivers.json"))
    components?.queryItems = [
      URLQueryItem(name: "limit", value: "\(limit)"),
      URLQueryItem(name: "offset", value: "\(offset)")
    ]

    guard let url = components?.url else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<DriverTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }

  func listOfDriverStandings(driverId: String) -> AnyPublisher<MRData<StandingsTable>, Error> {
    guard let url = URL(string: baseURL.appending("drivers/\(driverId)/driverStandings.json")) else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<StandingsTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }
}

class APIDriversStub: APIDriversProtocol {
  func listOfAllDrivers(limit: Int = 30, offset: Int = 0) -> AnyPublisher<MRData<DriverTable>, any Error> {
    let drivers = DriverModel.stubs(times: limit)
    let driverTable = DriverTable(drivers: drivers,
                                  driverId: nil,
                                  url: nil)

    return Just(MRData(table: driverTable,
                       limit: limit,
                       offset: offset,
                       total: limit,
                       series: "F1",
                       url: ""))
    .delay(for: .seconds(1), scheduler: RunLoop.main)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }


  func listOfDriverStandings(driverId: String) -> AnyPublisher<MRData<StandingsTable>, Error> {
  let jsonString = """
{
    "MRData": {
        "xmlns": "http://ergast.com/mrd/1.5",
        "series": "f1",
        "url": "http://ergast.com/api/f1/drivers/senna/driverstandings.json",
        "limit": "30",
        "offset": "0",
        "total": "11",
        "StandingsTable": {
            "driverId": "senna",
            "StandingsLists": [
                {
                    "season": "1984",
                    "round": "16",
                    "DriverStandings": [
                        {
                            "position": "9",
                            "positionText": "9",
                            "points": "13",
                            "wins": "0",
                            "Driver": {
                                "driverId": "senna",
                                "url": "http://en.wikipedia.org/wiki/Ayrton_Senna",
                                "givenName": "Ayrton",
                                "familyName": "Senna",
                                "dateOfBirth": "1960-03-21",
                                "nationality": "Brazilian"
                            },
                            "Constructors": [
                                {
                                    "constructorId": "toleman",
                                    "url": "http://en.wikipedia.org/wiki/Toleman",
                                    "name": "Toleman",
                                    "nationality": "British"
                                }
                            ]
                        }
                    ]
                },
                {
                    "season": "1985",
                    "round": "16",
                    "DriverStandings": [
                        {
                            "position": "4",
                            "positionText": "4",
                            "points": "38",
                            "wins": "2",
                            "Driver": {
                                "driverId": "senna",
                                "url": "http://en.wikipedia.org/wiki/Ayrton_Senna",
                                "givenName": "Ayrton",
                                "familyName": "Senna",
                                "dateOfBirth": "1960-03-21",
                                "nationality": "Brazilian"
                            },
                            "Constructors": [
                                {
                                    "constructorId": "team_lotus",
                                    "url": "http://en.wikipedia.org/wiki/Team_Lotus",
                                    "name": "Team Lotus",
                                    "nationality": "British"
                                }
                            ]
                        }
                    ]
                },
                {
                    "season": "1986",
                    "round": "16",
                    "DriverStandings": [
                        {
                            "position": "4",
                            "positionText": "4",
                            "points": "55",
                            "wins": "2",
                            "Driver": {
                                "driverId": "senna",
                                "url": "http://en.wikipedia.org/wiki/Ayrton_Senna",
                                "givenName": "Ayrton",
                                "familyName": "Senna",
                                "dateOfBirth": "1960-03-21",
                                "nationality": "Brazilian"
                            },
                            "Constructors": [
                                {
                                    "constructorId": "team_lotus",
                                    "url": "http://en.wikipedia.org/wiki/Team_Lotus",
                                    "name": "Team Lotus",
                                    "nationality": "British"
                                }
                            ]
                        }
                    ]
                },
                {
                    "season": "1987",
                    "round": "16",
                    "DriverStandings": [
                        {
                            "position": "3",
                            "positionText": "3",
                            "points": "57",
                            "wins": "2",
                            "Driver": {
                                "driverId": "senna",
                                "url": "http://en.wikipedia.org/wiki/Ayrton_Senna",
                                "givenName": "Ayrton",
                                "familyName": "Senna",
                                "dateOfBirth": "1960-03-21",
                                "nationality": "Brazilian"
                            },
                            "Constructors": [
                                {
                                    "constructorId": "team_lotus",
                                    "url": "http://en.wikipedia.org/wiki/Team_Lotus",
                                    "name": "Team Lotus",
                                    "nationality": "British"
                                }
                            ]
                        }
                    ]
                },
                {
                    "season": "1988",
                    "round": "16",
                    "DriverStandings": [
                        {
                            "position": "1",
                            "positionText": "1",
                            "points": "90",
                            "wins": "8",
                            "Driver": {
                                "driverId": "senna",
                                "url": "http://en.wikipedia.org/wiki/Ayrton_Senna",
                                "givenName": "Ayrton",
                                "familyName": "Senna",
                                "dateOfBirth": "1960-03-21",
                                "nationality": "Brazilian"
                            },
                            "Constructors": [
                                {
                                    "constructorId": "mclaren",
                                    "url": "http://en.wikipedia.org/wiki/McLaren",
                                    "name": "McLaren",
                                    "nationality": "British"
                                }
                            ]
                        }
                    ]
                },
                {
                    "season": "1989",
                    "round": "16",
                    "DriverStandings": [
                        {
                            "position": "2",
                            "positionText": "2",
                            "points": "60",
                            "wins": "6",
                            "Driver": {
                                "driverId": "senna",
                                "url": "http://en.wikipedia.org/wiki/Ayrton_Senna",
                                "givenName": "Ayrton",
                                "familyName": "Senna",
                                "dateOfBirth": "1960-03-21",
                                "nationality": "Brazilian"
                            },
                            "Constructors": [
                                {
                                    "constructorId": "mclaren",
                                    "url": "http://en.wikipedia.org/wiki/McLaren",
                                    "name": "McLaren",
                                    "nationality": "British"
                                }
                            ]
                        }
                    ]
                },
                {
                    "season": "1990",
                    "round": "16",
                    "DriverStandings": [
                        {
                            "position": "1",
                            "positionText": "1",
                            "points": "78",
                            "wins": "6",
                            "Driver": {
                                "driverId": "senna",
                                "url": "http://en.wikipedia.org/wiki/Ayrton_Senna",
                                "givenName": "Ayrton",
                                "familyName": "Senna",
                                "dateOfBirth": "1960-03-21",
                                "nationality": "Brazilian"
                            },
                            "Constructors": [
                                {
                                    "constructorId": "mclaren",
                                    "url": "http://en.wikipedia.org/wiki/McLaren",
                                    "name": "McLaren",
                                    "nationality": "British"
                                }
                            ]
                        }
                    ]
                },
                {
                    "season": "1991",
                    "round": "16",
                    "DriverStandings": [
                        {
                            "position": "1",
                            "positionText": "1",
                            "points": "96",
                            "wins": "7",
                            "Driver": {
                                "driverId": "senna",
                                "url": "http://en.wikipedia.org/wiki/Ayrton_Senna",
                                "givenName": "Ayrton",
                                "familyName": "Senna",
                                "dateOfBirth": "1960-03-21",
                                "nationality": "Brazilian"
                            },
                            "Constructors": [
                                {
                                    "constructorId": "mclaren",
                                    "url": "http://en.wikipedia.org/wiki/McLaren",
                                    "name": "McLaren",
                                    "nationality": "British"
                                }
                            ]
                        }
                    ]
                },
                {
                    "season": "1992",
                    "round": "16",
                    "DriverStandings": [
                        {
                            "position": "4",
                            "positionText": "4",
                            "points": "50",
                            "wins": "3",
                            "Driver": {
                                "driverId": "senna",
                                "url": "http://en.wikipedia.org/wiki/Ayrton_Senna",
                                "givenName": "Ayrton",
                                "familyName": "Senna",
                                "dateOfBirth": "1960-03-21",
                                "nationality": "Brazilian"
                            },
                            "Constructors": [
                                {
                                    "constructorId": "mclaren",
                                    "url": "http://en.wikipedia.org/wiki/McLaren",
                                    "name": "McLaren",
                                    "nationality": "British"
                                }
                            ]
                        }
                    ]
                },
                {
                    "season": "1993",
                    "round": "16",
                    "DriverStandings": [
                        {
                            "position": "2",
                            "positionText": "2",
                            "points": "73",
                            "wins": "5",
                            "Driver": {
                                "driverId": "senna",
                                "url": "http://en.wikipedia.org/wiki/Ayrton_Senna",
                                "givenName": "Ayrton",
                                "familyName": "Senna",
                                "dateOfBirth": "1960-03-21",
                                "nationality": "Brazilian"
                            },
                            "Constructors": [
                                {
                                    "constructorId": "mclaren",
                                    "url": "http://en.wikipedia.org/wiki/McLaren",
                                    "name": "McLaren",
                                    "nationality": "British"
                                }
                            ]
                        }
                    ]
                },
                {
                    "season": "1994",
                    "round": "16",
                    "DriverStandings": [
                        {
                            "position": "38",
                            "positionText": "38",
                            "points": "0",
                            "wins": "0",
                            "Driver": {
                                "driverId": "senna",
                                "url": "http://en.wikipedia.org/wiki/Ayrton_Senna",
                                "givenName": "Ayrton",
                                "familyName": "Senna",
                                "dateOfBirth": "1960-03-21",
                                "nationality": "Brazilian"
                            },
                            "Constructors": [
                                {
                                    "constructorId": "williams",
                                    "url": "http://en.wikipedia.org/wiki/Williams_Grand_Prix_Engineering",
                                    "name": "Williams",
                                    "nationality": "British"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    }
}
"""

  do {
    guard let jsonData = jsonString.data(using: .utf8) else {
      return Empty().eraseToAnyPublisher()
    }

    let model = try JSONDecoder().decode(MRData<StandingsTable>.self, from: jsonData)
    return Just(model)
      .delay(for: .seconds(1), scheduler: RunLoop.main)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()

  } catch let error {
    print(error)
    return Empty().eraseToAnyPublisher()
  }
  }
}

extension DriverModel {
  static let stub = DriverModel(driverId: "Senna",
                              url: "http://en.wikipedia.org/wiki/Ayrton_Senna",
                              dateOfBirth: "1960-03-21",
                               givenName: "Ayrton",
                              familyName: "Senna",
                              nationality: "Brazilian")

  static func stubs(times: Int) -> [DriverModel] {
    return [] + repeatElement(DriverModel.stub, count: times)
  }
}
