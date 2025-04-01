import SwiftUI

struct SceneryView: View {
  var body: some View {
    ZStack {
      Image("background")
        .resizable().aspectRatio(contentMode: .fill)
        .edgesIgnoringSafeArea(.all)

      // remove background from sky view so image from scenery is visible
      SkyView(numberOfClouds: 20, showBackground: false)

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
