//
//  Episode.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 10.06.2025.
//

import Foundation
import SwiftyJSON

class Episode {
    var id = 0
    var link = ""
    var number = 0
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["number"].int {
            self.number = temp
        }
        if let temp = json["link"].string {
            self.link = temp
        }
    }
}
