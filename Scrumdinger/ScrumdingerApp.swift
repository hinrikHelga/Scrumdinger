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
          Task {
            do {
              try await ScrumStore.save(scrums: store.scrums)
            } catch {
              fatalError("Error saving scrums.")
            }
          }
        }
      }
      .task {
        do {
          store.scrums = try await ScrumStore.load()
        } catch {
          fatalError("Error loading scrum.")
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
