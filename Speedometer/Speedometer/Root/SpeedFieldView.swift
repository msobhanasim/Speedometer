//
//  SpeedFieldView.swift
//  Speedometer
//
//  Created by Sobhan Asim on 02/08/2025.
//

import SwiftUI

struct SpeedFieldView: View {
    var title: String = "Enter your desired Speed"
    
    @FocusState.Binding var isFocused: Bool
    
    @Binding var enteredSpeed: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "barometer")
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.accent)
                    .frame(width: 26)
                
                
                ZStack(alignment: .leading) {
                    TextField("", text: $enteredSpeed)
                        .foregroundStyle(.accent)
                        .focused($isFocused)
                        .keyboardType(.numberPad)
                    
                    Text(title)
                        .font(
                            Font.custom("Rubik", size: 15)
                        )
                        .foregroundColor(.secondary)
                        .opacity(enteredSpeed.isEmpty ? 1 : 0)
                        .allowsHitTesting(false)
                    
                }
                
                if isFocused || !enteredSpeed.isEmpty {
                    Button {
                        enteredSpeed = ""
                        
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .frame(width: 14, height: 14, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .opacity(enteredSpeed.isEmpty ? 0.0 : 1.0)
                    .animation(.easeInOut, value: enteredSpeed)
                }
            }
            .padding(12)
            .frame(height: 40)
            .background(.gray.opacity(0.15))
            .cornerRadius(20)
            .onTapGesture {
                isFocused = true
            }
        }
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var speed: String = ""
    @FocusState private var isFieldFocused: Bool
    
    var body: some View {
        SpeedFieldView(
            isFocused: $isFieldFocused,
            enteredSpeed: $speed
        )
        .padding()
        .onAppear {
            isFieldFocused = true // optional: auto-focus in preview
        }
    }
}
