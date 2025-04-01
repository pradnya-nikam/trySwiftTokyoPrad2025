import SwiftUI

struct SkyView: View {
  let numberOfClouds: Int
  let showBackground: Bool
  @State private var cloudPositions = [CGPoint]()
  let background = Color(red: 0.53, green: 0.81, blue: 0.98)

  init(
    numberOfClouds: Int,
    showBackground: Bool = true
  ) {
    self.numberOfClouds = numberOfClouds
    self.showBackground = showBackground
  }

  var body: some View {
    ZStack {
      if showBackground {
        background.edgesIgnoringSafeArea(.all)
      }
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
      y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
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

          if cloudPositions[index].y < ((UIScreen.main.bounds.height) + 50) {
            cloudPositions[index].y += dy
          }
          else {
            cloudPositions[index].y -= abs(dy)
          }
          if cloudPositions[index].x < ((UIScreen.main.bounds.width)+50) {
            cloudPositions[index].x += dx
          }
          else {
            cloudPositions[index].x -= abs(dx)
          }
        }
      }
    }
  }
}

#Preview {
  SkyView(numberOfClouds: 15, showBackground: true)
}

