//
//  MyColorPicker.swift
//  MainProject
//
//  Created by Federico on 15/03/2022.
//

import SwiftUI

struct MyColorPicker: View {
    @Binding var ColorsPickers: Color
    private let colors:[Color] = [.red, .yellow, .orange, .purple, .blue, .indigo, .green, .mint]
    
    var body: some View {
  
            
            HStack {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .foregroundColor(color)
                        .frame(width: 30, height: 30)
                        .scaleEffect(color == ColorsPickers ? 1.2 : 1.0)
                        .onTapGesture {
                            ColorsPickers = color
                        }
                }
            }
            .padding()

        
    }
}

struct MyColorPicker_Previews: PreviewProvider {
    
    static var previews: some View {
        MyColorPicker(ColorsPickers: .constant(.blue))
    }
}
