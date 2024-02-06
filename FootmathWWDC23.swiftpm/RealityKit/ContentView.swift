import SwiftUI
import RealityKit
import ARKit
import UIKit

struct ContentView: View {
    @StateObject var gameplayViewModel = GameplayViewModel()
    @EnvironmentObject var timerController:TimerController
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        ZStack {
            
            //AR View
            ARViewContainer(palpites: $gameplayViewModel.palpites,
                            timer: timerController,
                            gameplayViewModel: gameplayViewModel)
                .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
                .onAppear{
                    audioPlayer.playMusic(sound: "soccer-stadium", type: "mp3", volume: 0.5)
                    audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                }
            
            HStack{
                
                //Scoreboard
                ZStack{
                    Image("scoreboardBack")
                    HStack(spacing: 12){
                        ForEach(gameController.resultados, id: \.self) {resultado in
                            switch resultado {
                            case ResultadoJogada.acertou:
                                Image("GreenSignal")
                            case ResultadoJogada.errou:
                                Image("RedSignal")
                            case ResultadoJogada.vazio:
                                Image("GraySignal")
                            }
                        }
                    }
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                //Timer
                Text("\(timerController.tempo)")
                    .foregroundColor(.white)
                    .font(Font.custom("Minecraftia-Regular", size: 30))
                
            }.padding(.bottom, 640)
                .padding(.horizontal, 22)
                .onChange(of: timerController.tempo) { newTempo in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        gameController.fimDaJogada(tempo: newTempo)}
                }
            
            //Operacao matematica
            Text(gameplayViewModel.operacaoMatematica)
                .padding(.bottom, 500)
                .foregroundColor(.white)
                .font(Font.custom("Minecraftia-Regular", size: 30))
            
        }.onAppear{
            gameplayViewModel.iniciarJogada(operacao: gameplayViewModel.operacao[gameController.indiceFaseJogo])

        }
    }
}

