//
//  ColorChip.swift
//  Pantone_Clone
//
//  Created by Kanghos on 10/23/24.
//

import SwiftUI

struct ColorChip: Identifiable {
  let name: String
  let color: Color
  let scale: Float
  var id: Color {
    return color
  }
}

struct ColorChipView: View {
  let colorChip: ColorChip

  var scale: CGFloat {
    CGFloat(self.colorChip.scale)
  }

  var body: some View {
    let width: CGFloat = 57 * scale
    let height: CGFloat = 90 * scale

    VStack(alignment: .leading) {
      Spacer()
      HStack {
        VStack(alignment: .leading) {
          HStack(alignment: .top, spacing: 0) {
            Text("PANTONE")
              .font(Font.custom("HelveticaNeue-Bold", size: 7.5 * scale))
            Text("®")
              .font(Font.custom("HelveticaNeue-Bold", size: 3 * scale))
          }
          Text(colorChip.name)
            .font(Font.custom("HelveticaNeue-Bold", size: 6.5 * scale))
        }
        Spacer()
      }
      .padding(.horizontal, 5)
      .frame(width: width - 3 * scale, height: height / 3.5)
      .background(RoundedRectangle(cornerRadius: 5)
        .fill(Color.white))

    }
    .padding(3)
    .frame(width: width, height: height)
    .background(RoundedRectangle(cornerRadius: 5).fill(colorChip.color))
  }
}

extension ColorChip {
  static func makeColorChips(rgb: String, maxLength: Int = 32) -> [ColorChip] {
    var chips: [ColorChip] = []
    let rgbs: [Int] = rgb.components(separatedBy: ".").compactMap { Int($0) }

    for i in (0..<maxLength) {
      chips.append(
        ColorChip(name: String(format: "%d.%d.%d", rgbs[0] + i, rgbs[1] + i*2, rgbs[2] + i),
                  color: Color(rgb: rgbs, index: i),
                  scale: 2)
      )
    }

    return chips
  }
}
