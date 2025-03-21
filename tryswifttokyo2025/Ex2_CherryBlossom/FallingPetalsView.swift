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

struct FallingPetal: View {
  @State private var position: CGPoint
  @State private var offset: CGFloat = 0

  init(startPosition: CGPoint) {
    _position = State(initialValue: startPosition)
  }

  var body: some View {
    PetalShape()
      .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.75, blue: 0.8), Color(red: 1.0, green: 0.5, blue: 0.7)]), startPoint: .top, endPoint: .bottom))
      .frame(width: 10, height: 5) // Petal size
      .opacity(0.8)
//      .shadow(radius: 1)
//      .drawingGroup()
      .position(position)
      .onAppear {
        animatePetal()
      }
  }

  public func animatePetal() {
    // Animate the petal falling down with a slight left drift
    withAnimation(
      Animation.linear(duration: Double.random(in: 6...15)) // falling speed
        .repeatForever(autoreverses: false)) {
          position.y = UIScreen.main.bounds.height + 50
          // horizontal drift for more leftward movement
          offset = -CGFloat.random(in: 150...350)
          position.x += offset
        }
  }
}

struct FallingPetalsView: View {
  let numberOfPetals: Int
  @State private var petalPositions: [CGPoint] = []

  var body: some View {
    ZStack {
      ForEach(petalPositions.indices, id: \.self) { index in
        FallingPetal(startPosition: petalPositions[index])
      }
    }
    .onAppear {
      // Start generating more petals
      Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
        if petalPositions.count < numberOfPetals {
          let newPosition = randomPosition()
          petalPositions.append(newPosition)
        }
        // Remove petals that have fallen off the screen
        petalPositions.removeAll { position in
          position.y > UIScreen.main.bounds.height
        }
      }
    }
  }

  private func randomPosition() -> CGPoint {
    let startX = CGFloat.random(in: UIScreen.main.bounds.width * 0.5...UIScreen.main.bounds.width)
    let startY = CGFloat.random(in: 0...50)
    return CGPoint(x: startX, y: startY)
  }
}

#Preview {
  FallingPetalsView(numberOfPetals: 50)
}
