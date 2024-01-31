//
//  Pie.swift
//  Memorize
//
//  Created by mervemetinoglu on 30.01.2024.
//

import CoreGraphics
import SwiftUI

struct Pie: Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle
    var clockwise = true

    func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )

        var piePath = Path()

        piePath.move(to: center)
        piePath.addLine(to: start)
        piePath.addArc(center: center,
                       radius: radius,
                       startAngle: startAngle,
                       endAngle: endAngle,
                       clockwise: !clockwise)
        piePath.addLine(to: center)

        return piePath
    }
}
