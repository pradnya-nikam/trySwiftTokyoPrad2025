import SwiftUI

struct SkyView: View {
  let numberOfClouds: Int
  @State private var cloudPositions = [CGPoint]()

  var body: some View {
    ZStack {
      // Add this if you want to display only this view since the clouds won't be visible on white background
//      Image("background")
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

  private func generateCloudPositions() {
    while cloudPositions.count < numberOfClouds {
      let newPosition = randomPosition()
      if !cloudPositions.contains(where: { isOverlapping($0, newPosition) }) {
        cloudPositions.append(newPosition)
      }
    }
  }

  private func randomPosition() -> CGPoint {
    return CGPoint(
      x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
      // Show clouds in top half of the screen
      y: CGFloat.random(in: 0...UIScreen.main.bounds.height/2))
  }

  // Function to check if two points are overlapping
  private func isOverlapping(_ position1: CGPoint, _ position2: CGPoint) -> Bool {
    let distance = hypot(position1.x - position2.x, position1.y - position2.y)
    return distance < 30
  }

  private func startAnimatingClouds() {
    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
      withAnimation(.easeInOut(duration: 3)) {
        for index in cloudPositions.indices {
          // Random horizontal and vertical movement
          let dx = CGFloat.random(in: -50...50)
          let dy = CGFloat.random(in: -20...20)
          cloudPositions[index].x += dx
          // dont let the cloud enter into the lower half of the screen
          if cloudPositions[index].y < ((UIScreen.main.bounds.height) / 2) {
            cloudPositions[index].y += dy
          }
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

