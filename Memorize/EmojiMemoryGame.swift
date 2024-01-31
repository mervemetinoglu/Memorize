//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by mervemetinoglu on 18.01.2024.
//

import SwiftUI

// ViewModel
class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card

    private static let emojis = ["🚗", "✈️", "🚚", "🚁", "🚜", "🚲", "🛵", "🚀",
                                 "🛥️", "🚆", "🛸", "🚕", "🚛", "🏍️", "🛺", "🚎", "🚡",
                                 "🚤", "🛶", "🚇"]

    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 8) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }

    @Published private var model = createMemoryGame()

    var cards: [Card] {
        model.cards
    }

    var color: Color {
        .blue
    }

    var score: Int {
        model.score
    }

    // MARK: - Intents

    func shuffle() {
        model.shuffle()
    }

    func choose(_ card: Card) {
        model.choose(card)
    }
}
