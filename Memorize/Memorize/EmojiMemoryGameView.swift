//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Rodion Chykerenda on 05.05.2022.
//

import SwiftUI

//private enum Emojis {
//    static let vehicles: [String] = ["🚗", "🏎", "🚙", "🚕", "🚎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍", "🛺", "🚀", "⛴", "🚢", "🛳", "✈️"]
//    static let food: [String] = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑"]
//    static let sport: [String] = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱"]
//}

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
     
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.cards) { card in
                        CardView(card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                            game.choose(card)
                        }
                    }
                }
            }
            .foregroundColor(.pink)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    private let card: EmojiMemoryGame.Card
    
    private enum Constants {
        static let cornerRadius: CGFloat = 20
        
        static let borderLineWidth: CGFloat = 3
        
        static let fontScale: CGFloat = 0.8
    }
    
    init(_ card: EmojiMemoryGame .Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
                
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: Constants.borderLineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * Constants.fontScale)
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
            .previewDisplayName("iPhone 13")

        EmojiMemoryGameView(game: game)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")
            .previewInterfaceOrientation(.portrait)
    }
}
