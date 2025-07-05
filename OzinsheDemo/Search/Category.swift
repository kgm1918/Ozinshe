//
//  Category.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 24.06.2025.
//

import Foundation
import SwiftyJSON

struct Category {
    let id: Int
    let name: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}
