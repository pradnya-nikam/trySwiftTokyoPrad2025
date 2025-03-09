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
      .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.75, blue: 0.8), Color(red: 1.0, green: 0.5, blue: 0.7)]), startPoint: .top, endPoint: .bottom)) // Beautiful pink gradient
      .opacity(0.7)
      .frame(width: 30, height: 15) // Size of the petal
      .position(position)
      .onAppear {
        animatePetal()
      }
  }

  // Make animatePetal public
  public func animatePetal() {
    // Animate the petal falling down with a slight left drift
    withAnimation(Animation.linear(duration: Double.random(in: 3...5)).repeatForever(autoreverses: false)) {
      position.y = UIScreen.main.bounds.height + 50 // Move to the bottom of the screen
      offset = -CGFloat.random(in: 100...150) // Increased random horizontal drift for more leftward movement
      position.x += offset
    }
  }
}

struct TreeView: View { // Renamed from SkyView to TreeView
  let numberOfPetals: Int

  var body: some View {
    ZStack {
      Color(red: 0.53, green: 0.81, blue: 0.98) // Beautiful sky blue color
        .edgesIgnoringSafeArea(.all)

      ForEach(0..<numberOfPetals, id: \.self) { index in
        let startX = CGFloat.random(in: UIScreen.main.bounds.width * 0.8...UIScreen.main.bounds.width) // Start farther on the right side
        let startY = CGFloat.random(in: -50...0) // Start above the screen
        FallingPetal(startPosition: CGPoint(x: startX, y: startY))
          .onAppear {
            // Stagger the falling of petals using DispatchQueue
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
              // Start the animation after the delay
              FallingPetal(startPosition: CGPoint(x: startX, y: startY)).animatePetal()
            }
          }
      }
    }
  }
}

#Preview {
  TreeView(numberOfPetals: 50)
}
