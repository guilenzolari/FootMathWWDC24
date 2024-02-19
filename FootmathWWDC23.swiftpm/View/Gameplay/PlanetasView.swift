import SwiftUI

struct PlanetasView: View {
    
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var gameController:GameController
    @StateObject var planetas = PlanetasViewModel()
    

    var body: some View {
        ZStack {
            Image(planetas.images[gameController.indiceFaseJogo][planetas.currentImageIndex])
                .resizable()
                .ignoresSafeArea()
                .onAppear {
                    planetas.startImageChangeTimer(intervalInSeconds: 0.3, fase: gameController.indiceFaseJogo, navigation: $gameController.navigationLinkProximaFase)
                    audioPlayer.playMusic(sound: "rocket-sound", type: "mp3", volume: 0.1)

                }
        }.navigationBarBackButtonHidden(true)
        
        NavigationLink("", destination: ContentView(), isActive: $gameController.navigationLinkProximaFase)
    }
}

