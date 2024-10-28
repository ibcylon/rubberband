//
//  ChipDebugView.swift
//  Pantone_Clone
//
//  Created by Kanghos on 10/28/24.
//

import SwiftUI

struct ChipDebugView: View {
  @Binding var xAnchor: Double
  @Binding var yAnchor: Double
  @Binding var zAnchor: Double
  @Binding var perspective: Double

  var body: some View {
    VStack {
      Section("XAnchor") {
        Slider(value: $xAnchor, in: -2...2) {
          Text("XAnchor")
        } minimumValueLabel: {
          Text("-2")
        } maximumValueLabel: {
          Text("2")
        }
      }
      Section("YAnchor") {
        Slider(value: $yAnchor, in: -2...2) {
          Text("XAnchor")
        } minimumValueLabel: {
          Text("-2")
        } maximumValueLabel: {
          Text("2")
        }
      }
      Section("Perspective") {
        Slider(value: $perspective, in: 0...1){
          Text("Perspective")
        } minimumValueLabel: {
          Text("0")
        } maximumValueLabel: {
          Text("1")
        }
      }
      Section("ZAnchor") {
        Slider(value: $zAnchor, in: -150...150){
          Text("Perspective")
        } minimumValueLabel: {
          Text("-150")
        } maximumValueLabel: {
          Text("150")
        }
      }
    }
  }
}
