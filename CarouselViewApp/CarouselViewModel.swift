//
//  CarouselViewModel.swift
//  CarouselViewApp
//
//  Created by Nishant Kumar on 05/05/25.
//

import Combine

class CarouselViewModel: ObservableObject {
    @Published var destinations: [Destination] = []

    init() {
        loadDestinations()
    }
    
    func loadDestinations() {
        self.destinations = [
            Destination(imageName: "dubai"),
            Destination(imageName: "tajmahal"),
            Destination(imageName: "malaysia")
        ]
    }
}

