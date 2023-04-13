//
//  WinnigView.swift
//  TicTacToe
//
//  Created by Sohan Vhora on 13/04/23.
//

import Foundation
import SwiftUI

struct WinnigView: View{
    
    var winBy: Players = .one
    @Binding var showWin: Bool
    @State var appeared: Bool = false
    
    var body: some View{
        
        ZStack{
            
            Rectangle()
                .fill(Color.black)
                .opacity(appeared ? 0.8 : 0)
            
            VStack{
                
                Text("Player")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
//                    .applyGradient(color: winBy == .one ? .purple : .blue)
                    .opacity(appeared ? 1 : 0)
                    .rotation3DEffect(Angle(degrees: appeared ? 0 : -70), axis: (x: 1, y: 0, z: 0))
                
                Text(winBy == .one ? "1": "2")
                    .font(.system(size: 400))
                    .foregroundColor(Color.white)
//                    .applyGradient(color: winBy == .one ? .purple : .blue)
                    .opacity(appeared ? 1 : 0)
                    .rotation3DEffect(Angle(degrees: appeared ? 0 : 80), axis: (x: 1, y: 1, z: 0))
                    
                Text("WON")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
//                    .applyGradient(color: winBy == .one ? .purple : .blue)
                    .opacity(appeared ? 1 : 0)
                    .rotation3DEffect(Angle(degrees: appeared ? 0 : 80), axis: (x: 1, y: 1, z: 0))
            }
        }
        .ignoresSafeArea()
        .onAppear{
            withAnimation(.linear(duration: 0.4)) {
                appeared.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                withAnimation {
                    appeared = false
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                showWin = false
            }
        }
        
    }
    
}
