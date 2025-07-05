//
//  Season.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 05.07.2025.
//

import Foundation
import SwiftyJSON

class Season {
    var id = 0
    var movieId = 0
    var number = 0
    var videos: [Episode] = []
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["movieId"].int {
            self.movieId = temp
        }
        if let temp = json["number"].int {
            self.number = temp
        }
        
        if let array = json["videos"].array {
            for item in array {
                let video = Episode(json: item)
                videos.append(video)
            }
        }
    }
}
