//
//  DefaultsManager.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 18.06.2025.
//

import Foundation

class DefaultsManager {
    static let shared = DefaultsManager()
    
    enum Key: String {
        case isDarkTheme
    }
    
    private init() {}
    
    func set(_ value: Bool, for key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func bool(for key: Key) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
}

