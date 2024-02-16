import Foundation
import SwiftUI

struct HistoriaView: View {
    
    @State var navigantionLinkAtivo = false
    @EnvironmentObject var audioPlayer:AudioPlayer

    @StateObject var historia = HistoriaViewModel()
    
    var body: some View{
        GeometryReader {geometry in
            ZStack{
                
                Color.black.edgesIgnoringSafeArea(.all)
                
                Image(historia.background[historia.etapaAtual])
                    .resizable()
                    .ignoresSafeArea()
                    .onAppear{
                        audioPlayer.playEffect(effect: historia.sounds[historia.etapaAtual], type: "mp3", volume: 1.0)
                    }
                
                VStack{
                    
                    Button {
                        navigantionLinkAtivo = !historia.avancar()
                        audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 1.0)
                        audioPlayer.playEffect(effect: historia.sounds[historia.etapaAtual], type: "mp3", volume: 1.0)
                    } label: {
                        Image(historia.button[historia.etapaAtual])
                    }.padding(.top, geometry.size.height * 8/10)
                }
                
                NavigationLink("",destination: PlanetasView() ,isActive: $navigantionLinkAtivo)
                
            }.navigationBarBackButtonHidden(true)
        }
    }
}
