//
//  MainScreen.swift
//  TicTacToe
//
//  Created by Sohan Vhora on 13/04/23.
//

import SwiftUI

struct MainScreen: View {
    
    @State var start: Bool = false
    @State var animate: Bool = false
    
    var mainView: some View{
        ZStack{
            
            Rectangle()
                .fill(Color.green)
                .ignoresSafeArea()
                .overlay {
                    bgView()
                }
            
            
            VStack{
                Spacer()
                Text("TicTacToe")
                    .font(.system(size: 50))
                    .fontWeight(.black)
                    .applyGradient(colors: [.blue, .teal])
                    .shadow(color: Color.white.opacity(0.3), radius: 10, x: 0, y: 0)
                    .rotation3DEffect(Angle(degrees: 20), axis: (x: animate ? 0 : 1, y: animate ? 1 :0, z: 0))
                
                Spacer()
                Button {
                    withAnimation {
                        start = true
                    }
                } label: {
                    Image(systemName: "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30, alignment: .center)
                        .applyGradient(colors: [.blue, .teal])
                        .padding()
                        .background(Circle().fill(Color.white))
                        
                        
                    
                }

               
                Spacer()
                    .frame(height: 50)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever()){
                animate.toggle()
            }
        }
    }
    
    var body: some View {
        
        if start{
            ContentView(presented: $start )
                .transition(.scale.combined(with: .opacity).combined(with: .slide))
        }else{
            mainView
        }
        
    }
}

struct bgView: View{
    
    @State var animte: Bool = false
    
    var body: some View{
            
        ZStack{
            HStack{
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 50) {
                    ForEach(0..<100, id: \.self) { i in
                        Text("\(i.isMultiple(of: animte ? 3 : 5) ? "❌" : "⚫️")")
                            .foregroundColor(.white)
                            .opacity(0.1)
                    }
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever()){
                animte.toggle()
            }
        }
    }
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
