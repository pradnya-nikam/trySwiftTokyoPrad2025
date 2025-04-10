import SwiftUI

struct CatalogView: View {
  @State private var path = NavigationPath()


  var body: some View {
    NavigationStack(path: $path) {
      VStack(spacing: 20) {
        Text("Catalog")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(.top, 20)
          .padding(.bottom, 10)

        catalogButton(title: "Time of the day", color: Color(red: 1.0, green: 0.97, blue: 0.7)) {
          path.append("time")
        }

        catalogButton(title: "Sky with Clouds", color: Color(red: 0.75, green: 0.87, blue: 0.95)) {
          path.append("sky")
        }

        catalogButton(title: "Falling Petals", color: Color(red: 0.98, green: 0.86, blue: 0.91)) {
          path.append("cherry")
        }

        catalogButton(title: "Cherry Blossom View", color: Color(red: 0.96, green: 0.76, blue: 0.96)) {
          path.append("cherry")
        }

        catalogButton(title: "(Bonus) Torch View", color: Color(red: 0.8, green: 0.8, blue: 0.95)) {
          path.append("torch")
        }
        Spacer()
      }
      .padding(.horizontal, 20)
      .navigationDestination(for: String.self) { destination in
        switch destination {
          case "time":
            TimeOfTheDayAnimationView()
              .navigationBarBackButtonHidden(true)
          case "sky":
            SkyView(numberOfClouds: 20)
              .navigationBarBackButtonHidden(true)
          case "cherry":
            SceneryView()
              .navigationBarBackButtonHidden(true)
          case "torch":
            TorchView()
              .navigationBarBackButtonHidden(true)
          default:
            EmptyView()
        }
      }
      .navigationBarHidden(true)
    }
  }

  // Custom button function
  func catalogButton(title: String, color: Color, action: @escaping () -> Void) -> some View {
    Button(action: action) {
      Text(title)
        .font(.headline)
        .fontWeight(.semibold)
        .foregroundColor(.black.opacity(0.7))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
          RoundedRectangle(cornerRadius: 12)
            .fill(color)
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
        )
    }
  }
}

#Preview {
  CatalogView()
}
