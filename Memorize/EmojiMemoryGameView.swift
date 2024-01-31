//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by mervemetinoglu on 2.01.2024.
//
// TODO: rename the model and view model

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame

    private let aspectRatio: CGFloat = 2 / 3
    private let spacing: CGFloat = 4

    var body: some View {
        VStack {
            cards
                .foregroundStyle(viewModel.color)
            HStack {
                score
                Spacer()
                shuffle
            }
        }
        .padding()
    }

    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }

    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }

    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
    }

    private func scoreChange(causedBy card: Card) -> Int {
        return 0
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
