//
//  SpeedometerView.swift
//  Speedometer
//
//  Created by Sobhan Asim on 02/08/2025.
//

import SwiftUI

struct SpeedometerView: View {
    let currentValue: Double
    
    let minValue: Double
    
    let maxValue: Double
    
    let startAngle: Angle
    
    let endAngle: Angle
    
    let majorTicks: [Double] = [0.0, 1000, 5000, 10000, 25000, 50000, 100000]
    
    /// Creates an analog dial view.
    ///
    /// - Parameters:
    ///   - currentValue: The value the dial's hand should display. Should be between `minValue`
    ///     and `maxValue`.
    ///   - minValue: The minimum value in the dial's range.
    ///   - maxValue: The maximum value in the dial's range.
    ///   - startAngle: The angle where the dial scale should start.
    ///   - endAngle: The angle where the dial scale should end.
    init(
        currentValue: Double,
        minValue: Double = 0,
        maxValue: Double = 100_000,
        startAngle: Angle = .degrees(-195),
        endAngle: Angle = .degrees(16)
    ) {
        self.currentValue = currentValue
        self.minValue = minValue
        self.maxValue = maxValue
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                backgroundCircle
                
                getBackgroundArcView(usingProxy: proxy)
                
                progressArcView
                
                tickMarkLabels
                
                speedHandAndCurrentSpeedLabel
                
            }
            .drawingGroup()
            
        }
        .aspectRatio(1, contentMode: .fit)
        
    }
}

#Preview {
    SpeedometerView(currentValue: 600)
        .padding()
}
