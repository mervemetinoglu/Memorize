//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by mervemetinoglu on 2.01.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
//    var viewModel: EmojiMemoryGame
    let emojis = ["🚗", "✈️", "🚚", "🚁", "🚜", "🚲", "🛵", "🚀", "🛥️", "🚆"]

    var body: some View {
        ScrollView {
            cards
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index]).aspectRatio(2 / 3, contentMode: .fit) // 2 wide 3 height
            }
        }
        .foregroundColor(.red)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3) // inside border
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 1)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview { // macro
    EmojiMemoryGameView()
}
