//
//  CloudView.swift
//  tryswifttokyo2025
//
//  Created by Nikam, Pradnya on 22/2/25.
//

import SwiftUI

struct CloudView: View {
  var body: some View {
    CloudShape()
      .fill(Color.white)
      .frame(width: 300, height: 100)
      .shadow(color: .gray, radius: 5, x: 0, y: 5)
      .padding()
      .background(Color.blue.opacity(0.3))
      .cornerRadius(10)
  }
}

struct CloudShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()

    // Draw the main body of the cloud
    path.addEllipse(in: CGRect(x: rect.midX - 50, y: rect.midY - 20, width: 100, height: 60))
    path.addEllipse(in: CGRect(x: rect.midX - 80, y: rect.midY - 40, width: 100, height: 80))
    path.addEllipse(in: CGRect(x: rect.midX, y: rect.midY - 30, width: 100, height: 70))
    path.addEllipse(in: CGRect(x: rect.midX + 50, y: rect.midY - 20, width: 100, height: 60))

    return path
  }
}

//struct ContentView: View {
//  var body: some View {
//    CloudShape()
//      .fill(Color.white)
//      .frame(width: 200, height: 100)
//      .shadow(color: .gray, radius: 5, x: 0, y: 5)
//      .padding()
//      .background(Color.blue.opacity(0.3))
//      .cornerRadius(10)
//  }
//}

#Preview {
    CloudView()
}
