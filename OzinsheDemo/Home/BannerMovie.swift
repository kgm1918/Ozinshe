//
//  BannerMovie.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 25.06.2025.
//

import Foundation
import SwiftyJSON

class BannerMovie {
    var id = 0
    var link = ""
    var movie: Movie = Movie()
    
    init() {
        
    }
    init(json: JSON) {
          self.movie = Movie(json: json["movie"])
      }
    
}


extension BannerMovie: CardDisplayable {
    var title: String { movie.movieType }
    var movieTitle: String { movie.movieTitle }
    var imageName: String { movie.poster_link }
    var subtitle: String { movie.desc }
    var cardType: Int { 1 }
}

