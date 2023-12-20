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

    init() {
        gameController.iniciarJogada()
    }

    var body: some View {
        
        ZStack{
            Image("GameplayBackgound")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
            
            Text("\(gameController.numero1) + \(gameController.numero2)")
                .font(Font.custom("8-bit Arcade In", size: 100))
                .foregroundColor(.white)
                .padding(.top, -365)
            
            Text("\(timerModel.countdown)")
                .font(Font.custom("8-bit Arcade In", size: 100))
                .foregroundColor(.white)
                .padding(.bottom, 1000)
                .padding(.leading, 650)
            
            ChutesView(gameController: gameController)
            
            Image("ball")
                
        }
    }
}

//#Preview {
//    GameplayView()
//}
