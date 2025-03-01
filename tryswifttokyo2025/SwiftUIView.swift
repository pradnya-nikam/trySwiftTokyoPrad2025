//
//  SwiftUIView.swift
//  tryswifttokyo2025
//
//  Created by Nikam, Pradnya on 1/3/25.
//

import SwiftUI
struct SwiftUIView: View {
  @State private var currentGradientIndex = 0
  @State private var title: String
  private let titles = [
  "Early Morning",
  "Day",
  "Evening",
  "Night"]

  init(currentGradientIndex: Int = 0) {
    self.currentGradientIndex = currentGradientIndex
    self.title = titles[currentGradientIndex]
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
      LinearGradient(
        gradient: Gradient(
          stops: gradientStops(
            for: gradients[currentGradientIndex])),
        startPoint: .top,
        endPoint: .bottom)
        .ignoresSafeArea()
        .onAppear {
          animateGradient()
        }

        Text(title)
          .font(.title)
          .foregroundStyle(.white)
    }
  }

  private func animateGradient() {
    Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
      withAnimation(.easeInOut(duration: 3), {
        currentGradientIndex = (currentGradientIndex + 1) % gradients.count
      }, completion: {
        title = titles[currentGradientIndex]
      })
    }
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
    SwiftUIView()
  }
}

#Preview {
  SwiftUIView()
}

