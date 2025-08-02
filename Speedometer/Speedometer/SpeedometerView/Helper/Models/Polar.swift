//
//  Polar.swift
//  Speedometer
//
//  Created by Sobhan Asim on 02/08/2025.
//

import CoreGraphics
import SwiftUI

/// Represents a polar coordinate with an angle and radius.
struct Polar {
    var radius: CGFloat
    var angle: Angle
    
    /// Converts the polar coordinate to a Cartesian (x, y) point.
    var cartesian: CGPoint {
        CGPoint(
            x: radius * CGFloat(cos(angle.radians)),
            y: radius * CGFloat(sin(angle.radians))
        )
    }
}
