//
//  Untitled.swift
//  tryswifttokyo2025
//
//  Created by Nikam, Pradnya on 22/2/25.
//

import SwiftUI

struct ComplexView: View {
  @State private var animate = false

  var body: some View {
    ZStack {
      // Background Gradient
      LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)

      // Complex Shape
      Circle()
        .fill(Color.pink)
        .shadow(radius: 5)
        .frame(width: 200)
        .scaleEffect(animate ? 1.2 : 1.0)
        .animation(Animation.easeInOut(duration: 0.1).repeatForever(autoreverses: true), value: animate)
        .onAppear {
          animate.toggle()
        }

      // Additional Shapes
      Rectangle()
        .fill(Color.green)
        .frame(width: 100, height: 100)
        .offset(x: -50, y: -50)

      Rectangle()
        .fill(Color.yellow)
        .frame(width: 100, height: 100)
        .offset(x: 50, y: 50)
    }
  }
}

struct ComplexView_Previews: PreviewProvider {
  static var previews: some View {
    ComplexView()
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
