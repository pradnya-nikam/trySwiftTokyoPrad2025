//
//  SwiftUIView.swift
//  tryswifttokyo2025
//
//  Created by Nikam, Pradnya on 1/3/25.
//

import SwiftUI
struct SwiftUIView: View {
  @State private var gradientColors: [Color] = [Color.red, Color.blue]

  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea()
        .onAppear {
          animateGradient()
        }

      VStack {
        Text("What time is it?")
          .font(.title)
        Slider(value: .constant(7), in: 0...24)
      }
    }
  }

  private func animateGradient() {
    // Change the colors after a delay
    withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: true)) {
      gradientColors = [Color.green, Color.purple]
    }
  }
}

#Preview {
  SwiftUIView()
}

