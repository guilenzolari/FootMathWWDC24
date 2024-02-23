import SwiftUI

struct VitoriaFasesView: View {
    @State var botaoAtivado = true
    @State var navigantionLinkAtivoMenu = false
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var gameController: GameController
    @StateObject var vitoriaFases = VitoriaFasesModel()
    
    var body: some View {
        GeometryReader {geometry in
            ZStack{
                
                Image(vitoriaFases.images[vitoriaFases.currentImageIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.top)
                    .onAppear{
                        audioPlayer.playMusic(sound: "latin-music", type: "mp3", volume: 0.1)
                        audioPlayer.playEffect(effect: "goal-scream", type: "mp3", volume: 3.5)
                        vitoriaFases.startImageChangeTimer(intervalInSeconds: 0.5)
                    }
                
                VStack{
//                    Button {
//                        audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
//                            navigantionLinkAtivoMenu = true}
//                        botaoAtivado = false
//                    } label: {
//                        Image("menu")
//                    }.disabled(!botaoAtivado)
//                    .padding(.bottom, 10)
                    
                    Button {
                        audioPlayer.playEffect(effect: "apito-futebol", type: "mp3", volume: 0.1)
                        botaoAtivado = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            gameController.navigantionLinkAtivoAboutMe = true
                            botaoAtivado = true}
                    } label: {
                        Image("aboutMe")
                    }
                        .disabled(!botaoAtivado)
                }.padding(.top, geometry.size.height * 0.7)
                
                NavigationLink("",destination: MenuView(),isActive: $navigantionLinkAtivoMenu)
                NavigationLink("",destination: AboutMeView(),isActive: $gameController.navigantionLinkAtivoAboutMe)
                
            }.navigationBarBackButtonHidden(true)
        }
    }
}
