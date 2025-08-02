//
//  SpeedometerHand.swift
//  Speedometer
//
//  Created by Sobhan Asim on 02/08/2025.
//

import SwiftUI

struct SpeedometerHand: View {
    var angle: Angle
    
    // Relative width and height of the needle
    private let scaleFactorX: CGFloat = 0.32
    private let scaleFactorY: CGFloat = 0.01
    
    // Pivot position (0 rotates from left end, 0.5 from center, 1 from right end)
    private let pivotPosition: CGFloat = 0
    
    // Relative size of the central pivot circle
    private let knobScaleFactor: CGFloat = 0.05
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Central pivot circle
                Circle()
                    .fill(Color.needleBase)
                    .frame(
                        width: geometry.size.width * 0.13,
                        height: geometry.size.width * 0.13
                    )
                    .shadow(radius: 3)
                
                // Needle shape
                Capsule()
                    .scale(x: scaleFactorX, y: scaleFactorY)
                    .offset(
                        x: geometry.size.width * scaleFactorX * -(pivotPosition - 0.5),
                        y: 0
                    )
                    .rotation(self.angle)
                    .fill(.needle)
            }
        }
    }
}

#Preview {
    SpeedometerHand(angle: -.degrees(90))
        .background(Circle().fill(.gray))
}
