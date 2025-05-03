//
//  CarouselView.swift
//  CarouselViewApp
//
//  Created by Nishant Kumar on 03/05/25.
//

import SwiftUI

struct Destination: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct CarouselView: View {
    let destinations: [Destination] = [
        Destination(name: "Dubai", imageName: "dubai"),
        Destination(name: "Taj Mahal", imageName: "tajmahal"),
        Destination(name: "Malaysia", imageName: "malaysia")
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(destinations.indices, id: \.self) { index in
                    VStack {
                        Image(destinations[index].imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .scrollTransition { content, phase in
                                content
                                    .scaleEffect(
                                        x: phase.isIdentity ? 1.0 : 1.0,
                                        y: phase.isIdentity ? 1.0 : 0.75
                                    )
                                    .offset(y: phase.isIdentity ? 0 : 0)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    CarouselView()
}
