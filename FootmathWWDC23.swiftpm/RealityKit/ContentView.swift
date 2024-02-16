import SwiftUI
import RealityKit

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
            
            if gameController.navigationLinkGameOverView {
                GameOverHudView()
            } else{
                GameplayHudView(operacaoMatematica: $gameplayViewModel.operacaoMatematica)
            }
            
            NavigationLink("", destination: VitoriaFasesView(), isActive: $gameController.navigationLinkVitoriaFasesView)
            
        }.onAppear{
            gameplayViewModel.iniciarJogada(operacao: gameplayViewModel.operacao[gameController.indiceFaseJogo])

        }
    }
}
