import SwiftUI


struct FallingPetalsView: View {
  @State private var petalCount: Int = 5

  var body: some View {
    ZStack {
      ForEach(0..<petalCount, id: \.self) { index in
        FallingPetal(startPosition: randomStartPostion())
      }
    }
    .onAppear {
      Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
        petalCount += 1
      }
    }
  }
  private func randomStartPostion() -> CGPoint {
    // Petal appears on the right side of the screen
    let startX = CGFloat.random(in: UIScreen.main.bounds.width * 0.5...UIScreen.main.bounds.width)
    let startY = CGFloat.random(in: 0...50)
    return CGPoint(x: startX, y: startY)
  }
}

#Preview {
  FallingPetalsView()
}

