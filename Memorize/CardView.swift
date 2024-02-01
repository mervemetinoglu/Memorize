//
//  CardView.swift
//  Memorize
//
//  Created by mervemetinoglu on 29.01.2024.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card

    let card: Card

    init(_ card: Card) {
        self.card = card
    }

    var body: some View {
        TimelineView(.animation(minimumInterval: 1 / 5)) { _ in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContents.padding(Constants.Pie.inset))
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
            } else {
                Color.clear
            }
        }
    }

    var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }

    private enum Constants {
        static let inset: CGFloat = 5

        enum FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }

        enum Pie {
            static let opacity: CGFloat = 0.3
            static let inset: CGFloat = 10
        }
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}

#Preview {
    CardView(CardView.Card(content: "🛶", id: "test1"))
        .padding()
        .foregroundStyle(.green)
}
