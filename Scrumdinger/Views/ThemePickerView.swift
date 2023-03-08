//
//  ThemePickerView.swift
//  Scrumdinger
//
//  Created by Hinrik Helgason on 08/03/2023.
//

import SwiftUI

struct ThemePickerView: View {
  @Binding var selection: Theme

  var body: some View {
    Picker("Theme", selection: $selection) {}
  }
}

struct ThemePickerView_Previews: PreviewProvider {
  static var previews: some View {
    ThemePickerView(selection: .constant(.periwinkle))
  }
}
