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
    
    let labelValues: [Double] = [0.0, 1000, 5000, 10000, 25000, 50000, 100000]
    
    /// Creates an analog speedometer dial view.
    ///
    /// - Parameters:
    ///   - currentValue: The value the speedometer dial's hand should display.
    ///   - startAngle: The angle where the speedometer dial scale should start.
    ///   - endAngle: The angle where the speedometer dial scale should end.
    init(
        currentValue: Double,
        startAngle: Angle = .degrees(-195),
        endAngle: Angle = .degrees(15)
    ) {
        self.currentValue = currentValue
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.minValue = labelValues.first ?? 0
        self.maxValue = labelValues.last ?? 0
        
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
    SpeedometerView(currentValue: 15600)
        .padding()
}
