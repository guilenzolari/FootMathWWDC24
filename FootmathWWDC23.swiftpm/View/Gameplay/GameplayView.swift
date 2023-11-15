//
//  SwiftUIView.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 14/11/23.
//

import SwiftUI

struct GameplayView: View {    
    @StateObject var timerModel = TimerModel()
    var gameController = GameController()

    var body: some View {
        let contas = Array(gameController.contasMais().prefix(3))
        
        ZStack{
            Image("GameplayBackgound")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
            
            Text(contas.joined(separator: " "))
                .font(Font.custom("8-bit Arcade In", size: 100))
                .foregroundColor(.white)
                .padding(.top, -365)
            
            Text("\(timerModel.countdown)")
                .font(Font.custom("8-bit Arcade In", size: 100))
                .foregroundColor(.white)
                .padding(.bottom, 1000)
                .padding(.leading, 650)
            
            ChutesView()
            
            Image("ball")
                .padding(.top, 900)
                
        }
        
        

    }
}

#Preview {
    GameplayView()
}
