//
//  CarouselView.swift
//  CarouselViewApp
//
//  Created by Nishant Kumar on 03/05/25.
//

import SwiftUI

struct CarouselView: View {
    @StateObject private var viewModel = CarouselViewModel()
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    private let spacing: CGFloat = -35

    var body: some View {
        GeometryReader { proxy in
            let screenWidth = proxy.size.width
            let imageSize = proxy.size.height
            let totalCardWidth = imageSize + spacing

            VStack {
                ZStack {
                    ForEach(viewModel.destinations.indices, id: \.self) { index in
                        let relativeIndex = CGFloat(index - currentIndex)
                        let finalIndex = relativeIndex + (dragOffset / totalCardWidth)
                        let offsetX = finalIndex * totalCardWidth
                        let scale = max(0.85, 1.0 - abs(finalIndex) * 0.15)
                        let zIndex = Double(100 - abs(finalIndex) * 10)

                        Image(viewModel.destinations[index].imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageSize, height: imageSize)
                            .cornerRadius(25)
                            .clipped()
                            .scaleEffect(scale)
                            .offset(x: offsetX)
                            .zIndex(zIndex)
                            .animation(.easeInOut(duration: 0.25), value: dragOffset)
                    }
                }
                .frame(width: screenWidth, height: imageSize)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            let totalCardWidth = imageSize + spacing
                            let predictedIndexOffset = -value.predictedEndTranslation.width / totalCardWidth
                            let newIndex = CGFloat(currentIndex) + predictedIndexOffset
                            let clampedIndex = min(max(Int(round(newIndex)), 0), viewModel.destinations.count - 1)

                            withAnimation(.spring()) {
                                currentIndex = clampedIndex
                                dragOffset = 0
                            }
                        }
                )

                HStack(spacing: 10) {
                    ForEach(viewModel.destinations.indices, id: \.self) { index in
                        Circle()
                            .fill(index == currentIndex ? Color.primary : Color.secondary.opacity(0.3))
                            .frame(width: 10, height: 10)
                            .animation(.easeInOut(duration: 0.25), value: currentIndex)
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
        .onAppear {
            if !viewModel.destinations.isEmpty {
                currentIndex = viewModel.destinations.count / 2
            }
        }
    }
}
