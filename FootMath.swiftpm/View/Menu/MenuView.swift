import SwiftUI

struct MenuView: View {
    @State var botaoAtivado = true
    @EnvironmentObject var audioPlayer:AudioPlayer
    @EnvironmentObject var gameController:GameController
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
                        botaoAtivado = true
                    }

                HStack{
                    Button {
                        audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            gameController.navigationLinkMenuToHistoria = true}
                        botaoAtivado = false
                    } label: {
                        Image("jogar")
                    }
                }.padding(.top, geometry.size.height * 7/10)
                    .disabled(!botaoAtivado)

                NavigationLink("",destination: HistoriaView(),isActive: $gameController.navigationLinkMenuToHistoria)
                
            }.navigationBarBackButtonHidden(true)
        }
    }
}





