//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rodion Chykerenda on 09.05.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        let numberOfPairOfCards = theme.numberOfPairOfCards > theme.emojis.count ? theme.emojis.count : theme.numberOfPairOfCards
        let emojis = theme.emojis
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairOfCards) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var memoryGame: MemoryGame<String>
    private var theme: Theme {
        didSet {
            memoryGame = EmojiMemoryGame.createMemoryGame(with: theme)
        }
    }
    
    init(theme: Theme) {
        self.theme = theme
        self.memoryGame = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    var cards: [MemoryGame<String>.Card] {
        memoryGame.cards
    }
    
    var themeName: String {
        theme.name
    }
    
    var themeColor: Color? {
        Color(hex: theme.color)
    }
    
    var score: Int {
        memoryGame.score
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        memoryGame.choose(card)
    }
    
    func newGameSelected() {
        var newTheme = theme
        
        while newTheme == theme {
            newTheme = Theme.allCases.randomElement()!
        }
        
        theme = newTheme
    }
}
