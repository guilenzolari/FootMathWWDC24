//
//  SwiftUIView.swift
//  
//
//  Created by Guilherme Ferreira Lenzolari on 09/01/24.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var timerController: TimerController
    @State var botaoAtivado = true
    @State var navigantionLinkAtivoJogar = false
    @EnvironmentObject var audioPlayer:AudioPlayer
    @EnvironmentObject var gameController:GameController

    let gameOverBackground = ["GameOver1","GameOver2","GameOver3"]
    
    var body: some View {
        ZStack{
            
            Image(gameOverBackground[gameController.indiceFaseJogo])
                .edgesIgnoringSafeArea(.top)
                .onAppear{
                    audioPlayer.playEffect(effect: "missed-goal", type: "mp3", volume: 3.5)
                }
            
            Button {
                audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    timerController.startTimer()
                    gameController.navigationLinkGameOverView = false}
                botaoAtivado = false
            } label: {
                Image("menuBotao")
            }.padding(.top, 550)
                .disabled(!botaoAtivado)
                
                        
        }.navigationBarBackButtonHidden(true)
            .onAppear {
                timerController.stopTimer()
        }
    }
}

