//
//  Color+Ext.swift
//  Pantone_Clone
//
//  Created by Kanghos on 10/23/24.
//

import SwiftUI

extension Color {
  init(rgb: [Int], index: Int) {
    self = Color(
      red: Double(rgb[0] + index) / 255,
      green: Double(rgb[1] + index * 2) / 255,
      blue: Double(rgb[2] + index) / 255
    )
  }
}
