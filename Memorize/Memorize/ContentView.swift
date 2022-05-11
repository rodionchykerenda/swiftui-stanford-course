//
//  ContentView.swift
//  Memorize
//
//  Created by Rodion Chykerenda on 05.05.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
     
    var body: some View {
        VStack {
            Text("Memorize! \(viewModel.themeName)").font(.largeTitle)
            Text("Score: \(viewModel.score)").font(.title2)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                            viewModel.choose(card)
                        }
                    }
                }
            }
            .foregroundColor(viewModel.themeColor)
            Spacer()
            Button {
                viewModel.newGameSelected()
            } label: {
                Text("New Game")
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.white)
                    .background(viewModel.themeColor)
                    .clipShape(Circle())
            }

        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(theme: .vehicles)
        ContentView(viewModel: game)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
            .previewDisplayName("iPhone 13")

        ContentView(viewModel: game)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            .previewDisplayName("iPhone 13 Pro Max")
            .previewInterfaceOrientation(.portrait)
    }
}
