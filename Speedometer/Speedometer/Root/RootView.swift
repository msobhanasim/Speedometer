//
//  RootView.swift
//  Speedometer
//
//  Created by Sobhan Asim on 02/08/2025.
//

import SwiftUI

struct RootView: View {
    @State private var speed: Double = 0
    @State private var speedString: String = ""
    @FocusState private var isFieldFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.001).onTapGesture {
                isFieldFocused = false
            }
            
            VStack(spacing: 30) {
                SpeedometerView(currentValue: speed)
                
                SpeedFieldView(
                    isFocused: $isFieldFocused,
                    enteredSpeed: $speedString
                )
                
                Button("Submit") {
                    withAnimation {
                        speed = Double(speedString) ?? 0
                    }
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .onChange(of: speedString) { _, newValue in
                if newValue.isEmpty {
                    withAnimation {
                        speed = Double(newValue) ?? 0
                    }
                }
            }
        }
    }
}

#Preview {
    RootView()
}
