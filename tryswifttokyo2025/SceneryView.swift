import SwiftUI

struct SceneryView: View {
  var body: some View {
    ZStack {
      Color(red: 0.53, green: 0.81, blue: 0.98) // Beautiful sky blue color
        .edgesIgnoringSafeArea(.all)
      SkyView(numberOfClouds: 50)
      VStack{
        Spacer()
          .frame(height: 350)
        TreeView(numberOfPetals: 100)
      }
      CherryBlossomTreeView()
    }
  }
}

#Preview {
  SceneryView()
}


struct CherryBlossomTreeView: View {
  private var imageWidth: CGFloat {
    UIScreen.main.bounds.width/2 + 50
  }
  private var imageHeight: CGFloat {
    UIScreen.main.bounds.height/2 + 50
  }
  var body: some View {
    VStack {
      Spacer()
        .frame(height: 200)
      HStack {
        Spacer()
          .frame(width: UIScreen.main.bounds.width - imageWidth)
        Image("cherry-blossom-tree")
          .resizable()
          .aspectRatio(contentMode: .fill)
        // this is the magic trick
          .frame(
            minWidth: imageWidth,
            maxWidth: .infinity,
            minHeight: imageHeight,
            maxHeight: .infinity,
            alignment: .topLeading
          )
          .aspectRatio(2, contentMode: .fit)
          .clipped()
      }
    }
  }
}
