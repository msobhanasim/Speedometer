//
//  SpeedometerView+Content.swift
//  Speedometer
//
//  Created by Sobhan Asim on 02/08/2025.
//

import SwiftUI

extension SpeedometerView {
    var backgroundCircle: some View {
        Circle().fill(
            Gradient(
                stops: [
                    .init(
                        color: .speedometerBaseGradientStart,
                        location: 0
                    ),
                    .init(
                        color: .needleBase,
                        location: 1.0
                    )
                ]
            )
        )
    }
    
    func getBackgroundArcView(usingProxy proxy: GeometryProxy) -> some View {
        Circle()
            .inset(by: 5)
            .trim(from: 0.0, to: 1)
            .stroke(
                backgroundArcRadialGradient(usingProxy: proxy),
                style: StrokeStyle(lineWidth: 10, lineCap: .round)
            )
            .frame(
                width: proxy.size.width,
                height: proxy.size.width,
                alignment: .center
            )
            .shadow(radius: 5, x: -1, y: 0)
            .clipShape(Circle())
    }
    
    @ViewBuilder
    var progressArcView: some View {
        let currentValueAngle = angleForHand(
            for: currentValue,
            labels: majorTicks,
            startAngle: startAngle.degrees,
            endAngle: endAngle.degrees
        )
        
        let normalizedAngleForArc = normalizeAngle(
            currentValueAngle,
            startAngle: startAngle,
            endAngle: endAngle
        )
        
        Circle()
            .inset(by: 5)
            .trim(from: 0.0, to: normalizedAngleForArc)
            .stroke(
                Color.needle,
                style: StrokeStyle(lineWidth: 10, lineCap: .round)
                
            )
            .rotationEffect(startAngle)
            .animation(.spring(), value: currentValue)
    }
    
    var tickMarkLabels: some View {
        let combinedArray = Array(zip(majorTicks.indices, majorTicks))
        
        return ForEach(combinedArray, id: \.0) { index, value in
            TickMarkLabel(
                number: value,
                angle: self.angleForLabel(
                    for: index,
                    totalItems: majorTicks.count,
                    startAngle: startAngle.degrees,
                    endAngle: endAngle.degrees
                ),
                color: .white
            )
        }
    }
    
    var speedHandAndCurrentSpeedLabel: some View {
        ZStack {
            let currentHandAngle = angleForHand(
                for: currentValue,
                labels: majorTicks,
                startAngle: startAngle.degrees,
                endAngle: endAngle.degrees
            )
            
            // Hand
            SpeedometerHand(angle: currentHandAngle)
                .animation(.spring(), value: currentValue)
            
            // Current Speed Label
            Text(formattedValue(value: currentValue))
                .foregroundColor(.needle)
                .font(.title)
                .bold()
                .offset(y: 80)
                .frame(width: 160, height: 30)
//                .contentTransition(.numericText())
        }
    }
    
}
