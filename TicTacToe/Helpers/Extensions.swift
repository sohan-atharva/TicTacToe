//
//  Extensions.swift
//  TicTacToe
//
//  Created by Sohan Vhora on 13/04/23.
//

import SwiftUI

extension View{
    
    func applyGradient(colors: [Color]) -> some View{
        self.overlay {
            Rectangle()
                .fill(LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing))
                .mask {
                    self
                }
        }
    }
    
    func capsuleBG(_ color: Color) -> some View{
        self.font(.system(size: 20))
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.vertical,4)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(color)
            )
    }
    
}
