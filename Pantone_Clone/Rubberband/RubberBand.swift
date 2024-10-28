//
//  donutView.swift
//  Pantone_Clone
//
//  Created by Kanghos on 10/22/24.
//

import SwiftUI

struct RubberBand: View {

  // MARK: Debug State
  @State var xAnchor: CGFloat = 0.5
  @State var yAnchor: CGFloat = 0.5
  @State var perspective: CGFloat = 0.1
  @State var zAnchor: CGFloat = 150

  // MARK: Property
  @State var angle: CGFloat = 0
  @State var currentAngle: CGFloat = 0
  @State var offset: CGFloat = 0
  @State var lastStoredOffset: CGFloat = 0
  @State var verticalOFfset: CGFloat = 0

  let maxLength = 10

  var colorChips: [ColorChip] = ColorChip.makeColorChips(rgb: "40.32.10", maxLength: 10)

  var body: some View {
    VStack {
      Spacer()
      ZStack {
        ForEach(0..<maxLength, id: \.self) { index in
          let radian = 360.0 / Double(maxLength)
          var angle = offset
//          ColorChipView(colorChip: colorChips[index])
          CardView()
            .frame(maxWidth: 160 / 2, maxHeight: 90 / 2)
            .rotation3DEffect(
              .degrees(offset + (radian) * Double(index) +
                       (currentAngle))
              ,
              axis: (x: 0.0, y: 1.0, z: 0.0),
              anchor: UnitPoint(x: xAnchor, y: yAnchor),
              anchorZ: zAnchor,
              perspective: perspective
            )
        }
      }
      .gesture(
        DragGesture()
          .onChanged { value in
            offset = value.translation.width + lastStoredOffset
            verticalOFfset = value.translation.height
          }.onEnded { value in
            lastStoredOffset = offset
            currentAngle = lastStoredOffset.truncatingRemainder(dividingBy: 360)
          }
      )
      Spacer()
      Text("XAnchor")
      Slider(value: $xAnchor, in: -2...2, label: {
        Text("X")
      })
      Text("YAnchor")
      Slider(value: $yAnchor, in: -2...2, label: {
        Text("Y")
      })
      Text("Perspective")
      Slider(value: $perspective, in: -1...1, label: {
        Text("Perspective")
      })
      Text("ZAnchor")
      Slider(value: $zAnchor, in: -150...150, label: {
        Text("ZAnchor")
      })
    }
  }
}

struct CardView: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 5)
      .fill(Color.blue)
      .border(Color.green)
  }
}

#Preview {
  RubberBand()
}
