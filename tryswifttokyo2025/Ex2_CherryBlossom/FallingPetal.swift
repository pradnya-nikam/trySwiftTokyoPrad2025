//
//  FallingPetal.swift
//  tryswifttokyo2025
//
//  Created by Nikam, Pradnya on 2/4/25.
//

import SwiftUI

struct FallingPetal: View {
  @State private var position: CGPoint
  @State private var offset: CGFloat = 0
  @State private var scale: CGFloat = 1.0
  @State private var rotation: Double = 0.0
  @State private var opacity: Double = 0.8

  let petalGradient = LinearGradient(
    gradient: Gradient(colors: [
      Color(red: 1.0, green: 0.75, blue: 0.8),
      Color(red: 1.0, green: 0.5, blue: 0.7)
    ]),
    startPoint: .top,
    endPoint: .bottom
  )
  init(startPosition: CGPoint) {
    _position = State(initialValue: startPosition)
    _scale = State(initialValue: CGFloat.random(in: 0.8...1.2))
    _rotation = State(initialValue: Double.random(in: -15...15))
  }

  var body: some View {
    PetalShape()
      .fill(petalGradient)
      .frame(width: 10, height: 5)
      .rotationEffect(.degrees(rotation))
      .scaleEffect(scale)
      .opacity(opacity)
      .drawingGroup()
      .position(position)
      .onAppear {
        animatePetalPosition()
        animatePetalProperties()
      }
  }

  public func animatePetalPosition() {
    // Animate the petal falling down with a slight left drift
    withAnimation(Animation.linear(duration: Double.random(in: 6...15))
                           .repeatForever(autoreverses: false)) {
          position.y = UIScreen.main.bounds.height + 50
          // horizontal drift for more leftward movement
          offset = -CGFloat.random(in: 150...350)
          position.x += offset
      }
  }
  public func animatePetalProperties() {
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
      withAnimation(.easeInOut(duration: 0.2)) {
        scale = CGFloat.random(in: 0.7...1.3)
        rotation = Double.random(in: -30...30)
        opacity = Double.random(in: 0.3...0.8)
      }
    }
  }
}
