//
//  extension+Publisher.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 19/04/2024.
//

import Foundation
import Combine

extension Publisher {
  func assignToastForError<S: Subject>(with toastSubject: S,
                                       onTap: (() -> Void)? = nil) -> Publishers.HandleEvents<Self> where S.Output == Toast?, S.Failure == Never {
    return handleEvents(
      receiveSubscription: { _ in
        toastSubject.send(nil)
      },
      receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          let toast = Toast(style: .error, message: error.localizedDescription, onTap: onTap)
          toastSubject.send(toast)
        case .finished: break
        }
      })
  }
}
