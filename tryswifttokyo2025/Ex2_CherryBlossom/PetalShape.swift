//
//  PetalShap.swift
//  tryswifttokyo2025
//
//  Created by Nikam, Pradnya on 2/4/25.
//
import SwiftUI

struct PetalShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    // Define the petal shape using a custom path
    path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // Top point of the petal
    path.addCurve(to: CGPoint(x: rect.maxX, y: rect.midY), // Right curve
                  control1: CGPoint(x: rect.maxX, y: rect.minY), // Control point for right curve
                  control2: CGPoint(x: rect.maxX, y: rect.midY)) // Control point for right curve
    path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY), // Bottom point of the petal
                  control1: CGPoint(x: rect.maxX, y: rect.maxY), // Control point for bottom curve
                  control2: CGPoint(x: rect.midX, y: rect.maxY)) // Control point for bottom curve
    path.addCurve(to: CGPoint(x: rect.minX, y: rect.midY), // Left curve
                  control1: CGPoint(x: rect.minX, y: rect.maxY), // Control point for left curve
                  control2: CGPoint(x: rect.minX, y: rect.minY)) // Control point for left curve
    path.addCurve(to: CGPoint(x: rect.midX, y: rect.minY), // Back to the top point
                  control1: CGPoint(x: rect.minX, y: rect.midY), // Control point for top curve
                  control2: CGPoint(x: rect.minX, y: rect.minY)) // Control point for top curve
    return path
  }
}
