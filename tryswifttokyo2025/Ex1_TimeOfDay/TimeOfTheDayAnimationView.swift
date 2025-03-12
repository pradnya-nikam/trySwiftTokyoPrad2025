//
//  SwiftUIView.swift
//  tryswifttokyo2025
//
//  Created by Nikam, Pradnya on 1/3/25.
//

import SwiftUI
struct TimeOfTheDayAnimationView: View {
  @State private var currentGradientIndex = 0
  @State private var currentAngleIndex = 0
  @State private var circleColor = Color.yellow
  @State private var title: String

  private let titles = [
  "Early Morning",
  "Day",
  "Evening",
  "Night"]

  private let angles: [Double] = [120, 90, 60, -50]

  init() {
    self.currentGradientIndex = 0
    self.currentAngleIndex = 0
    self.title = titles[0]
  }

  private let gradients: [[Color]] = [
//    [Color.orange, Color.yellow], // Early Morning
//    [Color.blue, Color.white],     // Day
//    [Color.purple, Color.red],     // Evening
//    [Color.black, Color.blue]       // Night
    [Color.red.opacity(0.8), Color.orange],
    [Color.orange, Color.yellow],
    [Color.pink.opacity(0.8), Color.orange],
    [Color.purple, Color.blue]
  ]

  var body: some View {
    ZStack {
      gradient(index: currentGradientIndex)
        .onAppear {
          animateGradient()
        }

      VStack {
        Text(title)
          .font(.title)
          .fontWeight(.bold)
          .foregroundStyle(.white)
        Circle()
          .fill(circleColor)
          .frame(width: 50, height: 50)
          .position(sunPosition())
      }
    }
  }

  func gradient(index: Int) -> some View {
    LinearGradient(
      gradient: Gradient(
        stops: gradientStops(
          for: gradients[currentGradientIndex])),
      startPoint: .top,
      endPoint: .bottom)
    .ignoresSafeArea()
  }

  private func animateGradient() {
    Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
      withAnimation(
        .easeInOut(duration: 3),
        {
        currentGradientIndex = (currentGradientIndex + 1) % gradients.count
        currentAngleIndex = (currentAngleIndex + 1) % angles.count // Cycle through the angles

        },
        completion: {
          title = titles[currentGradientIndex]
          print("index-g = \(currentGradientIndex), index-a = \(currentAngleIndex), title:\(title), angle:\(angles[currentAngleIndex])")
//          circleColor = (currentAngleIndex != 3) ? Color.yellow : Color.clear
        })

    }
  }

  private func sunPosition() -> CGPoint {
    let radius: CGFloat = UIScreen.main.bounds.width * 0.8
    let centerX = UIScreen.main.bounds.midX
    let centerY = UIScreen.main.bounds.height/2 + 100

    let angle = angles[currentAngleIndex]

    // Calculate the sun's position
    let x = centerX + radius * CGFloat(cos(angle * .pi / 180))
    let y = centerY - radius * CGFloat(sin(angle * .pi / 180))

    return CGPoint(x: x, y: y)
  }

  private func gradientStops(for colors: [Color]) -> [Gradient.Stop] {
    return [
      Gradient.Stop(color: colors[0], location: 0.0),
      Gradient.Stop(color: colors[0], location: 0.6),
      Gradient.Stop(color: colors[1], location: 1.0)
    ]
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    TimeOfTheDayAnimationView()
  }
}

#Preview {
  TimeOfTheDayAnimationView()
}

