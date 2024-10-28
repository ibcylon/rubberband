//
//  ChipContentView.swift
//  Pantone_Clone
//
//  Created by Kanghos on 10/22/24.
//

import SwiftUI

struct ChipContentView: View { //<Content: View, ID, Item>: View where Item: RandomAccessCollection, Item.Element: Equatable, Item.Element: Identifiable, ID: Hashable {
  let zIndexPreset: [Double]
  let chipShapes: [ColorChip]

  @State var delta: Double = 0 // Change in angle
  @State var currentAngle: Double = 0
  @State var currentCard: Int = 0 // Currently selected card
  @State var isDragging = false

  // MARK: DEBUG Property
  @State var xAnchor: Double = -2
  @State var yAnchor: Double = -1.5
  @State var zAnchor: Double = 0
  @State var perspective: Double = 0.1

  //  var content: @escaping (Item.Element) -> Content

  init(rgb: String) {
    chipShapes = ColorChip.makeColorChips(rgb: rgb)
    zIndexPreset = (1...chipShapes.count).map { Double($0) / 360 }.reversed()
  }

  var body: some View {
      ZStack {
        let angleOffset: Double = -30
        ForEach(0..<32, id: \.self) { (index) in
          let relativeIndex = index - currentCard > 0
          ? index - currentCard
          : (index - currentCard) + chipShapes.count

          let correctdRelativeIndex = relativeIndex + chipShapes.count/2 >= chipShapes.count ? relativeIndex + chipShapes.count/2 - chipShapes.count : relativeIndex + chipShapes.count/2


          ZStack(alignment: .top) {
            ColorChipView(colorChip: chipShapes[index])
              .offset(y: currentCard == index ? 100 : 0)

            ZStack(alignment: .bottomTrailing) {
              VStack(spacing: 0) {
                Rectangle()
                  .fill(Color.white)
                  .frame(width: 57*2.5, height: 90*1.5)
              }
              Text(String(index+1))
                .font(Font.custom("HelveticaNeue-Bold", size: 15))
                .rotationEffect(.degrees(90))
                .padding(10)
            }
            .zIndex(1)
          }
          .rotationEffect(.degrees(-90))
          .rotation3DEffect(
            calculateAngle(from: index, offset: angleOffset),
            axis: (x: 0, y: 1, z: 0), // 축
            anchor: UnitPoint(x: xAnchor, y: yAnchor),
            anchorZ: zAnchor, // rotation anchor center = 0.5, 0.5
            perspective: perspective
          ) // 시점
          .zIndex(zIndexPreset[correctdRelativeIndex])
        }
        .shadow(radius: 5, x: 5, y: 0)
        .offset(x: -100)
        .gesture(
          DragGesture()
            .onChanged{ val in
              isDragging = true
              delta = val.translation.width

              // Calculate the cards corresponding to the current location
              // CurrentCard = -round(Current angle(360 ~ -360) / Unit angle).
              let tempCurrentCard = -Int(round(Double(currentAngle + delta) / Double(360 / chipShapes.count))) % chipShapes.count

              // If CurrentCard is negative, make it positive.
              withAnimation(.easeInOut(duration: 0.1)) {
                if tempCurrentCard < 0 {
                  currentCard = tempCurrentCard + chipShapes.count
                } else {
                  currentCard = tempCurrentCard
                }
              }
            }
            .onEnded { val in
              isDragging = false
              currentAngle += delta
              currentAngle = Double((Int(currentAngle) % 360)) // Make currentAngle between -360` ~ 360`
            })
      }
//      ChipDebugView(
//        xAnchor: $xAnchor,
//        yAnchor: $yAnchor,
//        zAnchor: $zAnchor,
//        perspective: $perspective
//      )
  }
  private func calculateAngle(from index: Int, offset: Double) -> Angle {
    let dragOffset = isDragging ? currentAngle + delta : currentAngle
    let radian = Double(360 / chipShapes.count) * Double(index)
    return Angle(degrees: offset + radian + dragOffset)
  }
}


#Preview {
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
}
