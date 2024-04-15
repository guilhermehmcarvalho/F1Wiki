//
//  ImageWidget.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 15/04/2024.
//

import SwiftUI

struct ImageWidget: View {

  let imageString: String?

  var url: URL? {
    guard let imageString = imageString else {
      return nil
    }

    return URL(string: imageString)
  }

  var errorVIew: some View {
    Image(systemName: "photo.circle")
      .resizable()
      .foregroundColor(.F1Stats.primary)
      .opacity(0.6)
      .frame(width: 48, height: 48)
  }

  var loadingView: some View {
    ProgressView()
      .padding(8)
  }

  var body: some View {
    if let url = url {
      AsyncImage(url: url) { phase in
        switch phase {
        case .success(let image):
          image
            .resizable()
            .scaledToFill()

        case .failure(_):
          errorVIew

        default:
          loadingView
        }
      }
    } else {
      errorVIew
    }
  }
}

#Preview {
  ImageWidget(imageString: "https://instagram.fpoz4-1.fna.fbcdn.net/v/t51.29350-15/323820661_1217716338836353_7109190875671388956_n.jpg?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xNDQweDE4MTguc2RyLmYyOTM1MCJ9&_nc_ht=instagram.fpoz4-1.fna.fbcdn.net&_nc_cat=101&_nc_ohc=-ScMquptZN4Ab42QaTz&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=MzAwODkzOTc0NTkzMTM4MDU2NQ%3D%3D.2-ccb7-5&oh=00_AfDWcwQvdwvEwuZFrey42IqkoUVN-u5EYofE-Ab9kB4t-w&oe=6622BC4D&_nc_sid=fc8dfb")
}
