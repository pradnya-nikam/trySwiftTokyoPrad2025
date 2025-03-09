import SwiftUI

struct SkyView: View {
  let numberOfClouds: Int
  @State private var cloudPositions: [CGPoint] = []
  @State private var animatedPositions: [CGPoint] = []

  var body: some View {
    ZStack {
      Color.blue.opacity(0.5) // Sky background
        .edgesIgnoringSafeArea(.all)

      ForEach(animatedPositions.indices, id: \.self) { index in
        CloudView()
          .position(animatedPositions[index])

      }
    }
    .onAppear {
      generateCloudPositions()
      startAnimatingClouds()
    }
  }

  // Function to generate unique random positions for clouds
  private func generateCloudPositions() {
    while cloudPositions.count < numberOfClouds {
      let newPosition = randomPosition()
      if !cloudPositions.contains(where: { isOverlapping($0, newPosition) }) {
        cloudPositions.append(newPosition)
        animatedPositions.append(newPosition) // Initialize animated positions
      }
    }
  }

  // Function to generate random positions for clouds
  private func randomPosition() -> CGPoint {
    let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
    let y = CGFloat.random(in: 0...(UIScreen.main.bounds.height)) // Top half of the screen
    return CGPoint(x: x, y: y)
  }

  // Function to check if two points are overlapping
  private func isOverlapping(_ position1: CGPoint, _ position2: CGPoint) -> Bool {
    let distance = hypot(position1.x - position2.x, position1.y - position2.y)
    return distance < 50 // Adjust this value based on cloud size
  }

  // Function to start animating clouds
  private func startAnimatingClouds() {
    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
      withAnimation(.easeInOut(duration: 3)) {
        for index in animatedPositions.indices {
          let dx = CGFloat.random(in: -50...50) // Random horizontal movement
          let dy = CGFloat.random(in: -20...20) // Random vertical movement
          animatedPositions[index].x += dx
          animatedPositions[index].y += dy
        }
      }
    }
  }
}


#Preview {
  SkyView(numberOfClouds: 15)
}

