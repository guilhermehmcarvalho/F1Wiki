
protocol PseudoRandomGenerator: RandomNumberGenerator {
  associatedtype State
  init(seed: State)
  init<Source: RandomNumberGenerator>(from source: inout Source)
}

extension PseudoRandomGenerator {
  init() {
      var source = SystemRandomNumberGenerator()
      self.init(from: &source)
  }
}

private func rotl(_ x: UInt64, _ k: UInt64) -> UInt64 {
    return (x << k) | (x >> (64 &- k))
}

struct Xoroshiro256StarStar: PseudoRandomGenerator {
  typealias State = (UInt64, UInt64, UInt64, UInt64)
  var state: State

  init(seed: State) {
    precondition(seed != (0, 0, 0, 0))
    state = seed
  }

  init<Source: RandomNumberGenerator>(from source: inout Source) {
    repeat {
      state = (source.next(), source.next(), source.next(), source.next())
    } while state == (0, 0, 0, 0)
  }

  mutating func next() -> UInt64 {
    let result = rotl(state.1 &* 5, 7) &* 9

    let t = state.1 << 17
    state.2 ^= state.0
    state.3 ^= state.1
    state.1 ^= state.2
    state.0 ^= state.3

    state.2 ^= t

    state.3 = rotl(state.3, 45)

    return result
  }
}
