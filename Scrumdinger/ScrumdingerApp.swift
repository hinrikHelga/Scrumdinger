//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Hinrik Helgason on 03/03/2023.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
  @State private var scrums = DailyScrum.sampleData

  var body: some Scene {
    WindowGroup {
      NavigationView {
        ScrumsView(scrums: $scrums)
      }
    }
  }
}
