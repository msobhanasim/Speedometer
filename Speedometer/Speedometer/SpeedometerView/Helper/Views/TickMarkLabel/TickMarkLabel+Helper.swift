//
//  TickMarkLabel+Helper.swift
//  Speedometer
//
//  Created by Sobhan Asim on 02/08/2025.
//

import SwiftUI

extension TickMarkLabel {
    // Computes the center point for the text label based on `self.angle`.
    func labelPosition(for viewSize: CGSize) -> CGPoint {
        let radius = viewSize.width / 2 * 0.75
        let polar = Polar(radius: radius, angle: angle)
        
        // GeometryReader positions Text at the top-left by default, so we translate coordinates from the center.
        let translationFromTopLeftToCenter = CGAffineTransform(
            translationX: viewSize.width / 2,
            y: viewSize.height / 2
        )
        
        return polar
            .cartesian
            .applying(translationFromTopLeftToCenter)
    }
    
    func labelFontSize(for viewSize: CGSize) -> CGFloat {
        return viewSize.width / 18
    }
    
    func labelText(_ value: Double) -> String {
        if value.isNaN || value.isInfinite || value == 0 {
            return "0"
            
        } else if value > 0 && value < 1000 {
            return "\(Int(value))"
            
        } else if value >= 1000 && value < 100_000 {
            return "\(Int(value) / 1000)k"
            
        } else {
            return "100k+"
            
        }
    }
}
