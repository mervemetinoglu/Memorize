//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by mervemetinoglu on 2.01.2024.
//
// TODO: rename the model and view model

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    private let aspectRatio: CGFloat = 2 / 3

    var body: some View {
        VStack {
            cards.animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }

    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(.red)
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    let game = EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    return game
}

// struct EmojiMemoryGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = EmojiMemoryGame()
//        EmojiMemoryGameView(viewModel: game)
//    }
// }
