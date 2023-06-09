//
//  ContentView.swift
//  TicTacToe
//
//  Created by Sohan Vhora on 13/04/23.
//

import SwiftUI

enum BlockValue: String{
    case cross = "xmark"
    case zero = "circle"
    case empty = ""
}

enum Players{
    case one, two
}

struct ContentView: View {
    
    @Binding var  presented: Bool
    
    @State var blocksArray: [[BlockValue]] = [
        [BlockValue.empty,BlockValue.empty,BlockValue.empty],
        [BlockValue.empty,BlockValue.empty,BlockValue.empty],
        [BlockValue.empty,BlockValue.empty,BlockValue.empty]
    ]
    
    @State var activePlayer: Players = .one
    @State var message: String = ""
    @State var showWin: Bool = false
    @State var playerOneScore: Int = 0
    @State var playerTwoScore: Int = 0
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(.gray.opacity(0.05))
                .ignoresSafeArea()
            
            VStack{
                
                HStack{
                    
                    Button {
                        withAnimation {
                            presented = false
                        }
                        
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20, alignment: .center)
                            .opacity(0.4)
                    }

                    
                    Spacer()
                    
                    Button {
                        resetBoard()
                    } label: {
                        Text("Reset")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical,4)
                            .background(
                                Capsule()
                                    .fill(.red.opacity(0.7))
                            )
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
    
                Text(message)
                    .font(.system(size: 15))
                
                LazyVStack {
                    ForEach(blocksArray.indices, id: \.self) { i in
                        
                        HStack{
                            
                            ForEach(blocksArray[i].indices, id: \.self) { j in
                                
                                let value = blocksArray[i][j]
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill( value == .cross ? .blue.opacity(0.2) : value == .zero ? .purple.opacity(0.2) : Color.gray.opacity(0.2))
                                    
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                                    if value != .empty{
                                        Image(systemName: "\(value.rawValue)")
                                            .font(.system(size: 50))
                                            .fontWeight(.bold)
                                            .foregroundColor( value == .cross ? .blue : .purple)
                                            .transition(.opacity.combined(with: .scale))
                                    }
                                }
                                .frame(width: 100, height: 100, alignment: .center)
                                .onTapGesture {
                                    
                                    if blocksArray[i][j] == .empty{
                                        withAnimation(.easeInOut(duration: 1)) {
                                            blocksArray[i][j] = activePlayer == .one ? .zero : .cross
                                        }
                                        didPlayerClick()
                                        
                                    }else{
                                        //TODO: Show choose another one
                                        showMessage(message: "Please choose another one")
                                    }
                                }
                            }
                        }
                        
                    }
                }
                
                Spacer()
                
                HStack{
                    
                    Spacer()
                    
                    VStack{
                        
                        ZStack{
                            
                            Text("Player 1")
                                .capsuleBG( activePlayer == .one ? .purple : .gray)
                                .background(
                                    HStack{
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.purple)
                                            .frame(width: 30, height: 30, alignment: .center)
                                            .opacity(activePlayer == .one ? 1 : 0)
                                            .offset(y: activePlayer == .one ? -35 : 0)
                                        Spacer()
                                    }
                                )
                        }
                        
                        Text("\(playerOneScore)")
                            .font(.system(size: 25))
                            .fontWeight(.medium)
                            .foregroundColor(.purple)
                        
                        Text("Score")
                    }
                    
                    Spacer()
                    
                    Divider()
                    
                    Spacer()
                    
                    VStack{
                        
                        ZStack{

                            Text("Player 2")
                                .capsuleBG( activePlayer == .two ? .blue : .gray)
                                .background(
                                    HStack{
                                        Spacer()
                                        
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.blue)
                                            .frame(width: 30, height: 30, alignment: .center)
                                            .opacity(activePlayer == .two ? 1 : 0)
                                            .offset(y: activePlayer == .two ? -35 : 0)
                                    }
                                )
                        }
                        
                        Text("\(playerTwoScore)")
                            .font(.system(size: 25))
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                        
                        Text("Score")
                    }
                    
                    Spacer()
                }
                .frame(height: 30)
                .padding(.vertical)
                
                Spacer()
                    .frame(height: 50)
            }
            
            if showWin{
                WinnigView(winBy: activePlayer, showWin: $showWin)
            }
        }
    }
}

extension ContentView{
    
    func showMessage(message: String){
        withAnimation {
            self.message = message
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            withAnimation {
                self.message = ""
            }
        }
    }
    
    func didPlayerClick(){
        
        let res = checkWinCrossOrZero(value: .cross)
        if res.1{
            print("player 2 won")
            showMessage(message: "player 2 won")
            playerTwoScore += 1
            showWin = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                resetBoard()
            }
            return
        }
        
        let res1 = checkWinCrossOrZero(value: .zero)
        if res1.1{
            print("player 1 won")
            playerOneScore += 1
            showMessage(message: "player 1 won")
            showWin = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                resetBoard()
            }
            return
        }
        
        withAnimation {
            activePlayer = activePlayer == .one ? .two : .one
        }
    }
    
    func checkWinCrossOrZero(value: BlockValue) -> (BlockValue, Bool){
        
        let cross: [BlockValue] = [.cross,.cross,.cross]
        let zero: [BlockValue] = [.zero,.zero,.zero]
        
        let array = value == .cross ? cross : zero
        
        if blocksArray[0].elementsEqual(array) ||
            blocksArray[1].elementsEqual(array) ||
            blocksArray[2].elementsEqual(array){
            ///player won
            return (value, true)
        }
        
        if [blocksArray[0][0],blocksArray[1][0],blocksArray[2][0]].elementsEqual(array) ||
            [blocksArray[0][1],blocksArray[1][1],blocksArray[2][1]].elementsEqual(array) ||
            [blocksArray[0][2],blocksArray[1][2],blocksArray[2][2]].elementsEqual(array) {
            ///player won
            return (value, true)
        }
        
        if [blocksArray[0][0],blocksArray[0][1],blocksArray[0][2]].elementsEqual(array) ||
        [blocksArray[1][0],blocksArray[1][1],blocksArray[1][2]].elementsEqual(array) ||
            [blocksArray[2][0],blocksArray[2][1],blocksArray[2][2]].elementsEqual(array) {
            ///player won
            return (value, true)
        }
        
        if [blocksArray[0][0],blocksArray[1][1],blocksArray[2][2]].elementsEqual(array) ||
            [blocksArray[0][2],blocksArray[1][1],blocksArray[2][0]].elementsEqual(array) {
            ///player won
            return (value, true)
        }
        
        return (value, false)
    }
    
    func resetBoard(){
        blocksArray = [
            [BlockValue.empty,BlockValue.empty,BlockValue.empty],
            [BlockValue.empty,BlockValue.empty,BlockValue.empty],
            [BlockValue.empty,BlockValue.empty,BlockValue.empty]
        ]
        activePlayer = .one
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(presented: Binding.constant(true))
    }
}
