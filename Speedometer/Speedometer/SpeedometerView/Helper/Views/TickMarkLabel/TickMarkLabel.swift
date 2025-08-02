//
//  TickMarkLabel.swift
//  Speedometer
//
//  Created by Sobhan Asim on 02/08/2025.
//

import SwiftUI

struct TickMarkLabel: View {
    var number: Double
    var angle: Angle
    var color: Color
    
    var body: some View {
        GeometryReader { geometryProxy in
            Text(labelText(number))
                .font(
                    .system(
                        size: self.labelFontSize(for: geometryProxy.size),
                        weight: .bold
                    )
                )
                .foregroundColor(self.color)
                .position(self.labelPosition(for: geometryProxy.size))
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        
        TickMarkLabel(
            number: 5,
            angle: Angle(degrees: 0.0),
            color: .white
        )
    }
}
