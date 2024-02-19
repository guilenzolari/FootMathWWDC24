import SwiftUI

struct MenuView: View {
    @State var navigantionLinkAtivoJogar = false
    @State var botaoAtivado = true
    @EnvironmentObject var audioPlayer:AudioPlayer
    @StateObject var menu = MenuViewModel()
    
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Image(menu.images[menu.currentImageIndex])
                    .resizable()
                    .ignoresSafeArea()
                    .onAppear{
                        audioPlayer.playMusic(sound: "latin-music", type: "mp3", volume: 0.1)
                        menu.startImageChangeTimer(intervalInSeconds: 0.5)
                    }
                
                HStack{
                    Button {
                        audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            navigantionLinkAtivoJogar = true}
                        botaoAtivado = false
                        audioPlayer.stopAudio()
                    } label: {
                        Image("jogar")
                    }
                }.padding(.top, geometry.size.height * 7/10)
                    .disabled(!botaoAtivado)

                NavigationLink("",destination: HistoriaView(),isActive: $navigantionLinkAtivoJogar)
                
            }.navigationBarBackButtonHidden(true)
        }
    }
}





