//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Hinrik Helgason on 06/03/2023.
//

import SwiftUI

struct ScrumsView: View {
  let scrum: [DailyScrum]
  var body: some View {
    List {
      ForEach(scrum) { scrum in
        CardView(scrum: scrum)
          .listRowBackground(scrum.theme.mainColor)
      }
    }
  }
}

struct ScrumsView_Previews: PreviewProvider {
  static var previews: some View {
    ScrumsView(scrum: DailyScrum.sampleData)
  }
}
