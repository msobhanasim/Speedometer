//
//  SpeedometerView+Helper.swift
//  Speedometer
//
//  Created by Sobhan Asim on 02/08/2025.
//

import SwiftUI

extension SpeedometerView {
    
    /// Returns the angle that corresponds with the given value.
    func angleForHand(
        for value: Double,
        labels: [Double],
        startAngle: Double,
        endAngle: Double
    ) -> Angle {
        guard let firstLabel = labels.first, let lastLabel = labels.last, value > firstLabel else {
            return .degrees(startAngle)
        }
        
        guard value < lastLabel else {
            return .degrees(endAngle)
        }
        
        // Find the two labels that surround the current value
        for index in 0..<(labels.count - 1) {
            let lower = labels[index]
            let upper = labels[index + 1]
            
            if value >= lower && value <= upper {
                // Calculate local progress between these two labels
                let localProgress = (value - lower) / (upper - lower)
                
                // Calculate angle for lower and upper label
                let lowerAngle = angleForLabel(
                    for: index,
                    totalItems: labels.count,
                    startAngle: startAngle,
                    endAngle: endAngle
                ).degrees
                
                let upperAngle = angleForLabel(
                    for: index + 1,
                    totalItems: labels.count,
                    startAngle: startAngle,
                    endAngle: endAngle
                ).degrees
                
                // Interpolate between these two angles
                let interpolatedAngle = lowerAngle + (upperAngle - lowerAngle) * localProgress
                
                return .degrees(interpolatedAngle)
            }
        }
        
        return .degrees(startAngle)
    }
    
    // Helper function reused from earlier
    func angleForLabel(for index: Int, totalItems: Int, startAngle: Double, endAngle: Double) -> Angle {
        guard totalItems > 1 else { return .degrees(startAngle) }
        
        let step = (endAngle - startAngle) / Double(totalItems - 1)
        return .degrees(startAngle + step * Double(index))
    }
    
    /// Normalizes a given angle between startAngle and endAngle to a value between 0 and 1.
    /// Clamps the result to stay within [0, 1] range.
    func normalizeAngle(
        _ currentAngle: Angle,
        startAngle: Angle,
        endAngle: Angle
    ) -> Double {
        let start = startAngle.degrees
        let end = endAngle.degrees
        let current = currentAngle.degrees
        
        guard start != end else { return 0 }
        
        let normalized = (current - start) / (end - start)
        return min(max(normalized, 0), 1) * 0.58
        // Clamp to [0, 1]
        // 0.58 means that only around 58% of the complete circle is gonna get used
    }
    
    func formattedValue(value: Double) -> String {
        if value >= 1000 {
            return String(format: "%.1fk", value / 1000)
        } else {
            return String(format: "%.0f", value)
        }
    }
    
    func backgroundArcRadialGradient(usingProxy proxy: GeometryProxy) -> RadialGradient {
        RadialGradient(
            colors: [.needleBase, .speedometerBorderGradientStart],
            center: .center,
            startRadius: 0,
            endRadius: proxy.size.width * 0.485
        )
    }
}
