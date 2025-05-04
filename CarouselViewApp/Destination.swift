//
//  Destination.swift
//  CarouselViewApp
//
//  Created by Nishant Kumar on 05/05/25.
//

import Foundation

struct Destination: Identifiable, Decodable {
    let id: UUID
    let imageName: String

    init(imageName: String) {
        self.id = UUID()
        self.imageName = imageName
    }
}

