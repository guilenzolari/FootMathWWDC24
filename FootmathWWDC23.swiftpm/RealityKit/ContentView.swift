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
                
                if gameController.didFoundPlan{
                    if gameController.navigationLinkGameOverView {
                        GameOverHudView()
                    } else{
                        GameplayHudView(operacaoMatematica: $gameplayViewModel.operacaoMatematica)
                    }
                } else{
                    AvisoDeteccaoPlanoHUD()
                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.8)
                }
                
                NavigationLink("", destination: VitoriaFasesView(), isActive: $gameController.navigationLinkVitoriaFasesView)
                
            }.onAppear{
                gameplayViewModel.iniciarJogada(operacao: gameplayViewModel.operacao[gameController.indiceFaseJogo])
            }
        }
    }
}
