import SwiftUI

struct TorchView: View {
  @State private var rotation: Double = 0
  @State private var animate = false

  var body: some View {
    ZStack {
      // Background Gradient
      LinearGradient(
        gradient: Gradient(colors: [.purple, .blue]),
        startPoint: .top,
        endPoint: .bottom
      )
        .edgesIgnoringSafeArea(.all)

      // Complex Animated Shapes
      ForEach(0..<1000) { index in
        Circle()
          .fill(Color.yellow.opacity(0.15))
          .frame(width: 5 + CGFloat(index) * 8)
//          .scaleEffect(animate ? 1.0 : 0.5)
          .blur(radius: 1)
          .shadow(color: .yellow, radius: 1)
          .offset(x: CGFloat(index) * 10, y: CGFloat(index) * 10)
          .rotationEffect(.degrees(rotation), anchor: .center)

          .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: animate)
      }
    }
//    .drawingGroup()
    .onAppear {
      animate.toggle()
      Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
        rotation += 0.5
        if rotation >= 360 {
          rotation = 0
        }
      }
    }
  }
}

struct ComplexViewWithoutDrawingGroup_Previews: PreviewProvider {
  static var previews: some View {
    TorchView()
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
