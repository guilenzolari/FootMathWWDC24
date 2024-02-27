import SwiftUI
import RealityKit

struct ContentView: View {
    @StateObject var gameplayViewModel = GameplayViewModel()
    @EnvironmentObject var timerController:TimerController
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        GeometryReader {geometry in
            
            ZStack(alignment: .top) {
                
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
                
                if gameController.didGameplayStart{
                    if gameController.navigationLinkGameOverView {
                        GameOverHudView()
                    } else{
                        GameplayHudView(operacaoMatematica: $gameplayViewModel.operacaoMatematica)
                    }
                } else{
                    ZStack{
                        Rectangle()
                            .foregroundColor(.black)
                            .opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                        
                        AvisoDeteccaoPlanoHUD()
                            .position(x: geometry.size.width / 2, y: geometry.size.height * 0.7)
                        
                        Button {
                            gameController.didGameplayStart = false
                            timerController.stopTimer()
                            timerController.startTimer()
                            gameController.didGameplayStart = true
                            audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                        } label: {
                            Image("jogar")
                                .scaleEffect(0.6)
                        }.position(x: geometry.size.width / 2, y: geometry.size.height * 0.85)
                    }
                }
                        
                NavigationLink("", destination: VitoriaFasesView(), isActive: $gameController.navigationLinkGameplayToVitoria)
                
            }.onAppear{
                gameplayViewModel.iniciarJogada(operacao: gameplayViewModel.operacao[gameController.indiceFaseJogo])
            }
        }
    }
}
