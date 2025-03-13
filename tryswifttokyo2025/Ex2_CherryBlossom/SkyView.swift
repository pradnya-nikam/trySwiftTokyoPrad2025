import SwiftUI

struct SkyView: View {
  let numberOfClouds: Int
  @State private var cloudPositions = [CGPoint]()

  var body: some View {
    ZStack {
      ForEach(cloudPositions.indices, id: \.self) { index in
        CloudView()
          .position(cloudPositions[index])
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
        cloudPositions.append(newPosition) // Initialize cloud positions
      }
    }
  }

  // Function to generate random positions for clouds
  private func randomPosition() -> CGPoint {
    let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
    let y = CGFloat.random(in: 0...(UIScreen.main.bounds.height) / 2) // Top half of the screen
    return CGPoint(x: x, y: y)
  }

  // Function to check if two points are overlapping
  private func isOverlapping(_ position1: CGPoint, _ position2: CGPoint) -> Bool {
    let distance = hypot(position1.x - position2.x, position1.y - position2.y)
    return distance < 70 // Adjust this value based on cloud size
  }

  // Function to start animating clouds
  private func startAnimatingClouds() {
    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
      withAnimation(.easeInOut(duration: 3)) {
        for index in cloudPositions.indices {
          let dx = CGFloat.random(in: -50...50) // Random horizontal movement
          let dy = CGFloat.random(in: -20...20) // Random vertical movement
          cloudPositions[index].x += dx
          cloudPositions[index].y += dy
        }
      }
    }
  }
}

#Preview {
  ZStack {
    Color.blue.opacity(0.5)
    SkyView(numberOfClouds: 15)
  }
}

