import SwiftUI

struct SceneryView: View {
  var body: some View {
    ZStack {
      Image("background")
        .resizable().aspectRatio(contentMode: .fill)
        .edgesIgnoringSafeArea(.all)

      VStack {
        SkyView(numberOfClouds: 20, showBackground: false)
          .frame(height: 350)
        Spacer().frame(height: 1)
        FallingPetalsView()
      }

      Image("sakura_tree")
        .resizable().aspectRatio(contentMode: .fill)
    }
  }
}

#Preview {
  SceneryView()
}
