import Foundation
import SwiftUI

struct HistoriaView: View {
    
    @EnvironmentObject var audioPlayer:AudioPlayer
    @EnvironmentObject var gameController:GameController
    @StateObject var historia = HistoriaViewModel()
    
    var body: some View{
        GeometryReader {geometry in
            ZStack{
                
                Color.black.edgesIgnoringSafeArea(.all)
                
                Image(historia.background[historia.etapaAtual][historia.currentImageIndex])
                    .resizable()
                    .ignoresSafeArea()
                    .onAppear{
                        audioPlayer.playEffect(effect: historia.sounds[historia.etapaAtual], type: "mp3", volume: 1.0)
                        historia.startImageChangeTimer(intervalInSeconds: 0.5)
                    }
                
                VStack{
                    
                    Button {
                        historia.currentImageIndex = 0
                        gameController.navigationLinkHistoriaToPlanetas = !historia.avancar()
                        audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                        audioPlayer.playEffect(effect: historia.sounds[historia.etapaAtual], type: "mp3", volume: 1.0)
                    } label: {
                        Image(historia.button[historia.etapaAtual])
                    }.padding(.top, geometry.size.height * 8/10)
                }
                
                NavigationLink("",destination: PlanetasView() ,isActive: $gameController.navigationLinkHistoriaToPlanetas)
                
            }.navigationBarBackButtonHidden(true)
        }
    }
}
