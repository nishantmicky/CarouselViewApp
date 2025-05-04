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
    @State private var finalOffset: CGFloat = 0
    @State private var dragOffset: CGFloat = 0

    private let imageWidth: CGFloat = 250
    private let spacing: CGFloat = -35

    var body: some View {
        VStack {
            GeometryReader { proxy in
                let screenWidth = proxy.size.width
                let totalCardWidth = imageWidth + spacing

                ZStack {
                    ForEach(viewModel.destinations.indices, id: \.self) { index in
                        let relativeIndex = CGFloat(index - currentIndex)
                        let finalIndex = relativeIndex + (dragOffset / totalCardWidth)
                        let offsetX = finalIndex * totalCardWidth
                        let scale = max(0.85, 1.0 - abs(finalIndex) * 0.15)
                        let zIndex = Double(100 - abs(finalIndex) * 10)

                        VStack {
                            Image(viewModel.destinations[index].imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: imageWidth, height: imageWidth)
                                .cornerRadius(25)
                                .clipped()
                        }
                        .scaleEffect(scale)
                        .offset(x: offsetX)
                        .zIndex(zIndex)
                        .animation(.easeInOut(duration: 0.25), value: dragOffset)
                    }
                }
                .frame(width: screenWidth, height: 250)
                .clipped()
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            let predictedTranslation = value.predictedEndTranslation.width
                            let predictedIndexOffset = -predictedTranslation / totalCardWidth
                            let newIndex = CGFloat(currentIndex) + predictedIndexOffset
                            let targetIndex = Int(round(newIndex))
                            let clampedIndex = min(max(targetIndex, 0), viewModel.destinations.count - 1)

                            withAnimation(.spring()) {
                                currentIndex = clampedIndex
                                dragOffset = 0
                            }
                        }
                )
            }
            .frame(height: 250)

            HStack(spacing: 10) {
                ForEach(viewModel.destinations.indices, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.primary : Color.secondary.opacity(0.3))
                        .frame(width: 10, height: 10)
                        .animation(.easeInOut(duration: 0.25), value: currentIndex)
                }
            }
            .padding(.top, 8)
        }
        .onAppear {
            if !viewModel.destinations.isEmpty {
                currentIndex = viewModel.destinations.count / 2
            }
        }
    }
}

#Preview {
    CarouselView()
}
