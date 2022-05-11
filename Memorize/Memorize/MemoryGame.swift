//
//  MemoryGame.swift
//  Memorize
//
//  Created by Rodion Chykerenda on 09.05.2022.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: [Card]
    private(set) var score: Int = 0
    private var indexOfFacedUpCard: Int?
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchCardIndex = indexOfFacedUpCard {
                if cards[chosenIndex].content == cards[potentialMatchCardIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchCardIndex].isMatched = true
                    score += 2
                } else {
                    score -= 1
                }
                
                indexOfFacedUpCard = nil
            } else {
                for index in cards.indices {
                    if !cards[index].isMatched {
                        cards[index].isFaceUp = false
                    }
                }
                
                indexOfFacedUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    func index(of card: Card) -> Int? {
        for index in 0 ..< cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        
        return nil
    }
    
    struct Card: Identifiable {
        var id = UUID()
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
