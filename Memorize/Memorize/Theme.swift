//
//  Theme.swift
//  Memorize
//
//  Created by Rodion Chykerenda on 11.05.2022.
//

import Foundation

enum Theme: String, CaseIterable {
    case vehicles, sport, food
    
    private enum Emojis {
        
        static let vehicles = ["🚗", "🏎", "🚙", "🚕", "🚎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍", "🛺", "🚀", "⛴", "🚢", "🛳", "✈️"]
        
        static let food = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇"]
        
        static let sport = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓"]
    }
    
    private enum HexColor {
        
        static let purple: String = "541690"
        
        static let red: String = "FF4949"
        
        static let yellow: String = "F9D923"
    }
    
    var emojis: [String] {
        switch self {
        case .vehicles:
            return Emojis.vehicles.shuffled()
        case .food:
            return Emojis.food.shuffled()
        case .sport:
            return Emojis.sport.shuffled()
        }
    }
    
    var name: String {
        return self.rawValue.capitalized
    }
    
    var color: String {
        switch self {
        case .vehicles:
            return HexColor.purple
        case .sport:
            return HexColor.yellow
        case .food:
            return HexColor.red
        }
    }
    
    var numberOfPairOfCards: Int {
        switch self {
        case .vehicles:
            return 10
        case .sport:
            return 5
        case .food:
            return 20
        }
    }
}
