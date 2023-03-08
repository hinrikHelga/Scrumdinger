//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Hinrik Helgason on 08/03/2023.
//

import SwiftUI

struct ThemePicker: View {
  @Binding var selection: Theme

  var body: some View {
    Picker("Theme", selection: $selection) {
      ForEach(Theme.allCases) { theme in
        ThemeView(theme: theme)
          .tag(theme)
      }
    }
    .pickerStyle(.navigationLink)
    .padding(4)
  }
}

struct ThemePicker_Previews: PreviewProvider {
  static var previews: some View {
    ThemePicker(selection: .constant(.periwinkle))
  }
}
