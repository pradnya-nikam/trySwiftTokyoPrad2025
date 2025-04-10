//
//  CloudView.swift
//  tryswifttokyo2025
//
//  Created by Nikam, Pradnya on 22/2/25.
//

import SwiftUI

struct CloudView: View {

  var body: some View {
    CloudShape()
      .fill(Color.white)
      .frame(width: 220, height: 120)
      .blur(radius: 2)
//      .shadow(color: .white, radius: 5, x: 0, y: 0)
    // ADD OR REMOVE THIS LINE TO SEE PERFORMANCE CHANGES
      .drawingGroup()

  }
}

struct CloudShape: Shape {
  let width: CGFloat = 100
  let height: CGFloat = 60

  func path(in rect: CGRect) -> Path {
    var path = Path()
    let dx1 = CGFloat.random(in: 40...90)
    let dy1 = CGFloat.random(in: 10...30)
    let dx2 = CGFloat.random(in: 40...80)
    let dy2 = CGFloat.random(in: 10...30)
    let dx3 = CGFloat.random(in: 10...60)
    let dy3 = CGFloat.random(in: 10...50)

    path
      .addEllipse(
        in: CGRect(
          x: rect.midX - dx1,
          y: rect.midY - dy1,
          width: width + dx1/2,
          height: height
        )
      )
    path
      .addEllipse(
        in: CGRect(
          x: rect.midX - dx2,
          y: rect.midY - dy2,
          width: width,
          height: height + 0
        )
      )
    path
      .addEllipse(
        in: CGRect(
          x: rect.midX,
          y: rect.midY - dy3,
          width: width,
          height: height + dy3/2
        )
      )
    //rightmost
    path
      .addEllipse(
        in: CGRect(
          x: rect.midX - dx3,
          y: rect.midY - dy3,
          width: width,
          height: height
        )
      )

    return path
  }
}

#Preview {
  ZStack {
    Color.black
      .opacity(0.5)
    CloudView()
  }
  

}
