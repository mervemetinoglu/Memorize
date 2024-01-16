//
//  ContentView.swift
//  Memorize
//
//  Created by mervemetinoglu on 2.01.2024.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🚗", "✈️", "🚚", "🚁", "🚜", "🚲", "🛵", "🚀", "🛥️", "🚆"]
    @State var cardCount = 10

    var body: some View {
        VStack {
            cards
            Spacer()
            cardCountAdjusters
        }
        .padding(.horizontal)
    }

    var cards: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                ForEach(emojis[0 ..< cardCount], id: \.self) { emoji in
                    CardView(content: emoji).aspectRatio(2 / 3, contentMode: .fit) // 2 wide 3 height
                }
            }
        }
        .foregroundColor(.red)
    }

    var cardCountAdjusters: some View {
        HStack {
            cardRemoverButton
            Spacer()
            cardAdderButton
        }
        .imageScale(.large)
        .font(.largeTitle)
        .padding(.horizontal)
    }

    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button {
            cardCount += offset
        } label: {
            Image(systemName: symbol)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }

    var cardRemoverButton: some View {
        cardCountAdjuster(by: -1, symbol: "minus.circle")
    }

    var cardAdderButton: some View {
        cardCountAdjuster(by: 1, symbol: "plus.circle")
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
    ContentView()
}
