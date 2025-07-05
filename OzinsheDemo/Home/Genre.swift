//
//  Genre.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 02.07.2025.
//

import Foundation
import SwiftyJSON

struct Genre {
    var id: Int = 0
    var name: String = ""
    var fileId: Int = 0
    var link: String = ""
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["fileId"].int {
            self.fileId = temp
        }
        if let temp = json["name"].string {
            self.name = temp
        }
        if let temp = json["link"].string {
            self.link = temp
        }
    }
}

