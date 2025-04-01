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
    GeometryReader { proxy in
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
        generateCloudPositions(viewSize: proxy.size)
        startAnimatingClouds(viewSize: proxy.size)
      }
    }
  }

  private func generateCloudPositions(viewSize: CGSize) {
    while cloudPositions.count < numberOfClouds {
      let newPosition = randomPosition(viewSize: viewSize)
      if !cloudPositions.contains(where: { isOverlapping($0, newPosition) }) {
        cloudPositions.append(newPosition)
      }
    }
  }

  private func randomPosition(viewSize: CGSize) -> CGPoint {
    return CGPoint(
      x: CGFloat.random(in: 0...viewSize.width),
      y: CGFloat.random(in: 0...viewSize.height))
  }

  // Function to check if two points are overlapping
  private func isOverlapping(_ position1: CGPoint, _ position2: CGPoint) -> Bool {
    let distance = hypot(position1.x - position2.x, position1.y - position2.y)
    return distance < 30
  }

  private func startAnimatingClouds(viewSize: CGSize) {
    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
      withAnimation(.easeInOut(duration: 3)) {
        for index in cloudPositions.indices {
          // Random horizontal and vertical movement
          let dx = CGFloat.random(in: -50...50)
          let dy = CGFloat.random(in: -20...20)
          let newXPosition = cloudPositions[index].x + dx
          let newYPosition = cloudPositions[index].y + dy

          if newYPosition < viewSize.height && newYPosition > 0 {
            cloudPositions[index].y = newYPosition
          }

          if newXPosition < viewSize.width && newXPosition > 0 {
            cloudPositions[index].x = newXPosition
          }
        }
      }
    }
  }
}

#Preview {
  SkyView(numberOfClouds: 15, showBackground: true)
}

