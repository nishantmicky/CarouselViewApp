//
//  ContentView.swift
//  CarouselViewApp
//
//  Created by Nishant Kumar on 03/05/25.
//

import SwiftUI

struct ContentView: View {
    private let defaultCarouselViewHeight: CGFloat = 250
    
    var body: some View {
        VStack {
            // Uncomment to add top text view
//            Text("Featured Destinations")
//                .font(.title)
//                .frame(height: 25)

            CarouselView()

            // Uncomment to add bottom text view
//            Text("Explore More Below")
//                .font(.headline)
//                .frame(height: 25)
        }
        .frame(maxHeight: defaultCarouselViewHeight)
        .padding()
    }
}


#Preview {
    ContentView()
}
