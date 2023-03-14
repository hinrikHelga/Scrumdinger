//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Hinrik Helgason on 03/03/2023.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
  @StateObject private var store = ScrumStore()

  var body: some Scene {
    WindowGroup {
      NavigationView {
        ScrumsView(scrums: $store.scrums) {
          ScrumStore.save(scrums: store.scrums) { result in
            if case let .failure(error) = result {
              fatalError(error.localizedDescription)
            }
          }
        }
      }
      .onAppear {
        ScrumStore.load { result in
          switch result {
          case let .failure(error):
            fatalError(error.localizedDescription)
          case let .success(scrums):
            store.scrums = scrums
          }
        }
      }
    }
  }
}
