//
//  CardDisplayable.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 01.07.2025.
//

import Foundation


protocol CardDisplayable {
    var title: String { get}
    var imageName: String { get }
    var movieTitle: String { get }
    var subtitle: String { get }
    var cardType: Int { get }
}
