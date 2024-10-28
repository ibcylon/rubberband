//
//  MainTab.swift
//  Pantone_Clone
//
//  Created by Kanghos on 10/23/24.
//

import SwiftUI

struct MainTab: View {
  @State private var selectedIndex: Int = 0
  
  var body: some View {
    TabView(selection: $selectedIndex) {
      VStack {
        ChipContentView(rgb: "50.30.87")
          .zIndex(1)
        ChipContentView(rgb: "80.25.64")
          .zIndex(0.5)
          .offset(y: -35)
        ChipContentView(rgb: "10.55.112")
          .zIndex(0)
          .offset(y: -35 * 2)
      }
      .tabItem { Text("Pantone") }
      .tag(1)
      
      RubberBand()
        .tabItem { Text("Rubber.band") }
        .tag(2)
    }
  }
}
