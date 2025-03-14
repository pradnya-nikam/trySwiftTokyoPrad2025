import SwiftUI

struct SceneryView: View {
  var body: some View {
    ZStack {
      Image("background")
        .resizable().aspectRatio(contentMode: .fill)
        .edgesIgnoringSafeArea(.all)

      SkyView(numberOfClouds: 30)

      VStack {
        Spacer().frame(height: 350)
        FallingPetalsView(numberOfPetals: 100)
      }

      Image("sakura_tree")
        .resizable().aspectRatio(contentMode: .fill)
    }
  }
}

#Preview {
  SceneryView()
}
