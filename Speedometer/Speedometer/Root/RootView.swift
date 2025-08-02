//
//  RootView.swift
//  Speedometer
//
//  Created by Sobhan Asim on 02/08/2025.
//

import SwiftUI

struct RootView: View {
    @State var speed: Double = 0
    
    @State private var speedString: String = ""
    @FocusState private var isFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            SpeedometerView(currentValue: speed)
         
            SpeedFieldView(
                isFocused: $isFieldFocused,
                enteredSpeed: $speedString
            )
        }
        .padding()
        .onChange(of: speedString) { _, newValue in
            speed = Double(newValue) ?? 0
            
        }
    }
}

#Preview {
    RootView()
}
